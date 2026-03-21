/// Abstract Git client with Forgejo implementation.
library dart_git;

// Client interfaces
export 'src/client/git_credentials.dart';
export 'src/client/git_exception.dart';
export 'src/client/git_host_type.dart';
export 'src/client/i_git_auth.dart';
export 'src/client/i_git_client.dart';
export 'src/client/i_git_oauth.dart';
export 'src/client/i_git_registration.dart';

// Models
export 'src/models/git_commit.dart';
export 'src/models/git_directory_entry.dart';
export 'src/models/git_file.dart';
export 'src/models/git_repo.dart';

// Forgejo
export 'src/forgejo/forgejo_client.dart';
export 'src/forgejo/forgejo_endpoints.dart';
export 'src/forgejo/forgejo_oauth.dart';
export 'src/forgejo/forgejo_registration.dart';

// Webhooks
export 'src/webhook/forgejo_webhook_parser.dart';
export 'src/webhook/i_webhook_parser.dart';
export 'src/webhook/normalized_push_event.dart';
