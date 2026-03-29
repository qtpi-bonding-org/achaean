import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../app_router.dart';
import '../../../core/models/polis_info.dart';
import '../../../core/models/repo_identifier.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../design_system/widgets/stone_divider.dart';
import '../../../design_system/widgets/terracotta_button.dart';
import '../../polis/cubit/polis_cubit.dart';
import '../../polis/cubit/polis_state.dart';
import '../../polis/services/i_polis_service.dart';

/// Data passed via GoRouter extra to identify the polis.
class PolisDetailArgs {
  final String repoUrl;
  final String name;

  const PolisDetailArgs({required this.repoUrl, required this.name});
}

class PolisDetailScreen extends StatelessWidget {
  final PolisDetailArgs args;

  const PolisDetailScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<PolisCubit>(),
      child: _PolisDetailScreenBody(args: args),
    );
  }
}

class _PolisDetailScreenBody extends StatefulWidget {
  final PolisDetailArgs args;

  const _PolisDetailScreenBody({required this.args});

  @override
  State<_PolisDetailScreenBody> createState() => _PolisDetailScreenBodyState();
}

class _PolisDetailScreenBodyState extends State<_PolisDetailScreenBody> {
  PolisInfo? _polisInfo;
  bool _loadingInfo = true;
  Object? _loadError;

  RepoIdentifier get _repoId {
    final uri = Uri.parse(widget.args.repoUrl);
    final segments = uri.pathSegments;
    final baseUrl = '${uri.scheme}://${uri.host}';
    final owner = segments.isNotEmpty ? segments[0] : '';
    final repo = segments.length > 1 ? segments[1] : '';
    return RepoIdentifier(baseUrl: baseUrl, owner: owner, repo: repo);
  }

  @override
  void initState() {
    super.initState();
    context.read<PolisCubit>().loadOwnPoleis();
    _loadPolisInfo();
  }

  Future<void> _loadPolisInfo() async {
    try {
      final info = await GetIt.instance<IPolisService>().getPolisInfo(_repoId);
      if (mounted) {
        setState(() {
          _polisInfo = info;
          _loadingInfo = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loadError = e;
          _loadingInfo = false;
        });
      }
    }
  }

  bool _isJoined(PolisState state) {
    return state.poleis.any((p) => p.repo == widget.args.repoUrl);
  }

  void _onJoin(BuildContext context) {
    context.read<PolisCubit>().joinPolis(_repoId);
  }

  void _onLeave(BuildContext context) {
    context.read<PolisCubit>().leavePolis(_repoId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AchaeanScaffold(
      title: widget.args.name,
      onBack: () => AppNavigation.back(context),
      body: _buildBody(context, theme),
    );
  }

  Widget _buildBody(BuildContext context, ThemeData theme) {
    if (_loadingInfo) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_loadError != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.space * 2),
          child: Text(
            'Failed to load polis info.',
            style: theme.textTheme.bodyMedium,
          ),
        ),
      );
    }

    final info = _polisInfo;
    if (info == null) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSizes.space * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Polis name (headline)
          Text(
            info.name,
            style: theme.textTheme.headlineMedium,
          ),
          if (info.description != null && info.description!.isNotEmpty) ...[
            SizedBox(height: AppSizes.space * 2),
            Text(
              info.description!,
              style: theme.textTheme.bodyMedium,
            ),
          ],
          if (info.norms != null && info.norms!.isNotEmpty) ...[
            SizedBox(height: AppSizes.space * 2),
            const StoneDivider(),
            SizedBox(height: AppSizes.space * 2),
            Text(
              'Norms',
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: AppSizes.space),
            Text(
              info.norms!,
              style: theme.textTheme.bodyMedium,
            ),
          ],
          SizedBox(height: AppSizes.space * 3),
          const StoneDivider(),
          SizedBox(height: AppSizes.space * 2),
          BlocBuilder<PolisCubit, PolisState>(
            builder: (context, state) {
              final joined = _isJoined(state);
              final loading = state.isLoading;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!joined)
                    TerracottaButton(
                      label: 'Join',
                      isLoading: loading,
                      onPressed: loading ? null : () => _onJoin(context),
                    )
                  else ...[
                    OutlinedButton(
                      onPressed: loading ? null : () => _onLeave(context),
                      child: loading
                          ? SizedBox(
                              height: AppSizes.iconMedium,
                              width: AppSizes.iconMedium,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Leave'),
                    ),
                    SizedBox(height: AppSizes.space * 2),
                    TextButton(
                      onPressed: () => AppNavigation.toFeed(context),
                      child: const Text('View Agora'),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
