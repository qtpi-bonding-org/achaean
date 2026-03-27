import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../design_system/widgets/stone_divider.dart';
import '../../../l10n/app_localizations.dart';
import '../../trust/cubit/trust_cubit.dart';
import '../../trust/cubit/trust_state.dart';
import '../../observe/cubit/observe_cubit.dart';
import '../../observe/cubit/observe_state.dart';
import '../widgets/trust_observe_buttons.dart';

/// Data passed via GoRouter extra to identify the user.
class UserDetailArgs {
  final String pubkey;
  final String repoUrl;

  const UserDetailArgs({required this.pubkey, required this.repoUrl});
}

class UserDetailScreen extends StatefulWidget {
  final UserDetailArgs args;

  const UserDetailScreen({super.key, required this.args});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TrustCubit>().loadOwnTrust();
    context.read<ObserveCubit>().loadOwnObserve();
  }

  bool _isTrusted(TrustState state) {
    return state.declarations.any((d) => d.subject == widget.args.pubkey);
  }

  bool _isObserving(ObserveState state) {
    return state.declarations.any((d) => d.subject == widget.args.pubkey);
  }

  String get _subjectName {
    final pk = widget.args.pubkey;
    return pk.length >= 16 ? pk.substring(0, 16) : pk;
  }

  void _onTrustPressed(BuildContext context, bool currentlyTrusted) {
    final l10n = AppLocalizations.of(context)!;

    if (currentlyTrusted) {
      context.read<TrustCubit>().revokeTrust(subjectName: _subjectName);
      return;
    }

    showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.trustConfirmTitle),
        content: Text(l10n.trustConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.trustConfirmCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.trustConfirmAction),
          ),
        ],
      ),
    ).then((confirmed) {
      if (confirmed == true && context.mounted) {
        context.read<TrustCubit>().declareTrust(
              subjectPubkey: widget.args.pubkey,
              subjectRepo: widget.args.repoUrl,
              level: TrustLevel.trust,
            );
      }
    });
  }

  void _onObservePressed(BuildContext context, bool currentlyObserving) {
    if (currentlyObserving) {
      context.read<ObserveCubit>().revokeObserve(subjectName: _subjectName);
    } else {
      context.read<ObserveCubit>().declareObserve(
            subjectPubkey: widget.args.pubkey,
            subjectRepo: widget.args.repoUrl,
          );
    }
  }

  String get _truncatedPubkey {
    final pk = widget.args.pubkey;
    if (pk.length <= 12) return pk;
    return '${pk.substring(0, 6)}...${pk.substring(pk.length - 6)}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AchaeanScaffold(
      title: _truncatedPubkey,
      onBack: () => AppNavigation.back(context),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.space * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pubkey (tappable to copy)
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: widget.args.pubkey));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.pubkeyCopied)),
                );
              },
              child: Text(
                widget.args.pubkey,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: AppSizes.space * 2),
            // Trust / Observe buttons
            BlocBuilder<TrustCubit, TrustState>(
              builder: (context, trustState) {
                return BlocBuilder<ObserveCubit, ObserveState>(
                  builder: (context, observeState) {
                    return TrustObserveButtons(
                      isTrusted: _isTrusted(trustState),
                      isObserving: _isObserving(observeState),
                      isLoading: trustState.isLoading || observeState.isLoading,
                      onTrustPressed: () =>
                          _onTrustPressed(context, _isTrusted(trustState)),
                      onObservePressed: () =>
                          _onObservePressed(context, _isObserving(observeState)),
                    );
                  },
                );
              },
            ),
            const StoneDivider(),
            Expanded(
              child: Center(
                child: Text(
                  'Posts coming soon',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
