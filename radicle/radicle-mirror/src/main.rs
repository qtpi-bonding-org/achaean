use axum::{extract::Json, http::StatusCode, routing::post, Router};
use serde::Deserialize;
use std::process::Command;
use std::{env, fs, path::PathBuf};
use tracing::{error, info, warn};

/// Subset of Forgejo push webhook payload.
#[derive(Deserialize)]
struct PushEvent {
    #[serde(rename = "ref")]
    git_ref: String,
    repository: Repository,
}

#[derive(Deserialize)]
struct Repository {
    full_name: String,
    name: String,
    owner: Owner,
}

#[derive(Deserialize)]
struct Owner {
    login: String,
}

/// Configuration from environment variables.
struct Config {
    /// Root path where Forgejo bare repos are mounted (read-only).
    forgejo_repos: PathBuf,
    /// Root path for working copies used for mirroring.
    mirror_dir: PathBuf,
    /// Port to listen on.
    port: u16,
}

impl Config {
    fn from_env() -> Self {
        Self {
            forgejo_repos: PathBuf::from(
                env::var("FORGEJO_REPOS").unwrap_or_else(|_| {
                    "/forgejo-data/git/repositories".to_string()
                }),
            ),
            mirror_dir: PathBuf::from(
                env::var("MIRROR_DIR").unwrap_or_else(|_| {
                    "/var/radicle-mirrors".to_string()
                }),
            ),
            port: env::var("PORT")
                .unwrap_or_else(|_| "8080".to_string())
                .parse()
                .unwrap_or(8080),
        }
    }
}

fn extract_branch(git_ref: &str) -> Option<&str> {
    git_ref.strip_prefix("refs/heads/")
}

fn mirror_repo(
    forgejo_repos: &PathBuf,
    mirror_dir: &PathBuf,
    owner: &str,
    repo_name: &str,
    branch: &str,
) -> Result<(), String> {
    let bare_path = forgejo_repos.join(owner).join(format!("{repo_name}.git"));
    if !bare_path.exists() {
        return Err(format!("bare repo not found: {}", bare_path.display()));
    }

    let work_dir = mirror_dir.join(owner).join(repo_name);

    // Ensure parent directory exists
    if let Some(parent) = work_dir.parent() {
        fs::create_dir_all(parent)
            .map_err(|e| format!("failed to create mirror dir: {e}"))?;
    }

    if work_dir.join(".git").exists() {
        // Working copy exists — pull latest
        info!("pulling latest for {owner}/{repo_name}");
        let output = Command::new("git")
            .args(["pull", "origin", branch])
            .current_dir(&work_dir)
            .output()
            .map_err(|e| format!("git pull failed to execute: {e}"))?;

        if !output.status.success() {
            return Err(format!(
                "git pull failed: {}",
                String::from_utf8_lossy(&output.stderr)
            ));
        }
    } else {
        // First time — clone from bare repo
        info!("cloning {owner}/{repo_name}");
        let output = Command::new("git")
            .args([
                "clone",
                &bare_path.to_string_lossy(),
                &work_dir.to_string_lossy(),
            ])
            .output()
            .map_err(|e| format!("git clone failed to execute: {e}"))?;

        if !output.status.success() {
            return Err(format!(
                "git clone failed: {}",
                String::from_utf8_lossy(&output.stderr)
            ));
        }
    }

    // Check if rad remote exists
    let has_rad = Command::new("git")
        .args(["remote"])
        .current_dir(&work_dir)
        .output()
        .map(|o| String::from_utf8_lossy(&o.stdout).contains("rad"))
        .unwrap_or(false);

    if !has_rad {
        // Initialize in Radicle
        info!("initializing {repo_name} in radicle");
        let output = Command::new("rad")
            .args([
                "init",
                "--name",
                repo_name,
                "--default-branch",
                branch,
                "--public",
                "--no-confirm",
            ])
            .env("RAD_PASSPHRASE", "")
            .current_dir(&work_dir)
            .output()
            .map_err(|e| format!("rad init failed to execute: {e}"))?;

        if !output.status.success() {
            let stderr = String::from_utf8_lossy(&output.stderr);
            // Check if it failed because it was already initialized in storage
            // (different working copy, same repo). Verify rad remote got added.
            let has_rad_now = Command::new("git")
                .args(["remote"])
                .current_dir(&work_dir)
                .output()
                .map(|o| String::from_utf8_lossy(&o.stdout).contains("rad"))
                .unwrap_or(false);

            if !has_rad_now {
                return Err(format!("rad init failed and no rad remote: {stderr}"));
            }
            warn!("rad init had errors but rad remote exists, continuing");
        }
    }

    // Push to Radicle
    info!("pushing {branch} to radicle for {owner}/{repo_name}");
    let output = Command::new("git")
        .args(["push", "rad", branch])
        .current_dir(&work_dir)
        .output()
        .map_err(|e| format!("git push rad failed to execute: {e}"))?;

    if !output.status.success() {
        let stderr = String::from_utf8_lossy(&output.stderr);
        // "Everything up-to-date" comes on stderr but isn't an error
        if !stderr.contains("Everything up-to-date") {
            return Err(format!("git push rad failed: {stderr}"));
        }
    }

    Ok(())
}

async fn handle_webhook(Json(payload): Json<PushEvent>) -> StatusCode {
    let config = Config::from_env();
    let owner = &payload.repository.owner.login;
    let repo_name = &payload.repository.name;
    let full_name = &payload.repository.full_name;

    let branch = match extract_branch(&payload.git_ref) {
        Some(b) => b.to_string(),
        None => {
            info!("ignoring non-branch ref: {}", payload.git_ref);
            return StatusCode::OK;
        }
    };

    info!("webhook received: {full_name} branch={branch}");

    match mirror_repo(
        &config.forgejo_repos,
        &config.mirror_dir,
        owner,
        repo_name,
        &branch,
    ) {
        Ok(()) => {
            info!("mirror complete: {full_name}");
            StatusCode::OK
        }
        Err(e) => {
            error!("mirror failed for {full_name}: {e}");
            // Return OK anyway — we don't want Forgejo to retry and spam us.
            // Mirror failures are non-fatal.
            StatusCode::OK
        }
    }
}

async fn handle_health() -> &'static str {
    "ok"
}

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init();

    let config = Config::from_env();
    let addr = format!("0.0.0.0:{}", config.port);

    let app = Router::new()
        .route("/webhook", post(handle_webhook))
        .route("/health", axum::routing::get(handle_health));

    info!("radicle-mirror listening on {addr}");
    info!(
        "forgejo repos: {}",
        config.forgejo_repos.display()
    );
    info!("mirror dir: {}", config.mirror_dir.display());

    let listener = tokio::net::TcpListener::bind(&addr).await.unwrap();
    axum::serve(listener, app).await.unwrap();
}
