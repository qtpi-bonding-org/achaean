import 'package:achaean_client/achaean_client.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../agora/cubit/agora_cubit.dart';
import '../../agora/cubit/agora_state.dart';
import '../../personal_feed/widgets/post_reference_tile.dart';
import '../../polis/cubit/polis_cubit.dart';
import '../../polis/cubit/polis_state.dart';

/// Agora tab content showing a polis dropdown and the selected polis's feed.
///
/// Reads joined poleis from [PolisCubit] and agora posts from [AgoraCubit].
/// Shows an empty state with a link to Connections when no poleis are joined.
class AgoraContent extends StatefulWidget {
  const AgoraContent({super.key});

  @override
  State<AgoraContent> createState() => _AgoraContentState();
}

class _AgoraContentState extends State<AgoraContent> {
  PolisMembership? _selectedPolis;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PolisCubit>().loadOwnPoleis();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<AgoraCubit>().loadMore();
    }
  }

  void _onPolisSelected(PolisMembership? polis) {
    if (polis == null) return;
    setState(() => _selectedPolis = polis);
    context.read<AgoraCubit>().loadAgora(polis.repo);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PolisCubit, PolisState>(
      listenWhen: (prev, curr) =>
          prev.poleis != curr.poleis && curr.poleis.isNotEmpty,
      listener: (context, state) {
        // Auto-select the first polis on initial load if none is selected.
        if (_selectedPolis == null && state.poleis.isNotEmpty) {
          _onPolisSelected(state.poleis.first);
        }
      },
      builder: (context, polisState) {
        if (polisState.isLoading && polisState.poleis.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (polisState.poleis.isEmpty) {
          return _EmptyPolisState();
        }

        // Ensure selected polis is still in the list.
        final poleis = polisState.poleis;
        if (_selectedPolis != null &&
            !poleis.any((p) => p.repo == _selectedPolis!.repo)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _onPolisSelected(poleis.first);
          });
        }

        final effectiveSelection = _selectedPolis != null &&
                poleis.any((p) => p.repo == _selectedPolis!.repo)
            ? _selectedPolis
            : poleis.first;

        return Column(
          children: [
            _PolisDropdown(
              poleis: poleis,
              selected: effectiveSelection,
              onChanged: _onPolisSelected,
            ),
            const Divider(height: 1),
            Expanded(
              child: BlocBuilder<AgoraCubit, AgoraState>(
                builder: (context, agoraState) {
                  if (agoraState.isLoading && agoraState.posts.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (agoraState.isFailure && agoraState.posts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Failed to load agora',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(height: AppSizes.space),
                          TextButton(
                            onPressed: () {
                              if (effectiveSelection != null) {
                                context
                                    .read<AgoraCubit>()
                                    .loadAgora(effectiveSelection.repo);
                              }
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (agoraState.posts.isEmpty && agoraState.isSuccess) {
                    return Center(
                      child: Text(
                        'No posts in this agora yet.',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: agoraState.posts.length,
                    itemBuilder: (context, index) {
                      final ref = agoraState.posts[index];
                      return PostReferenceTile(
                        postRef: ref,
                        onTap: () => AppNavigation.toPostDetail(context, ref),
                        onAuthorTap: () => AppNavigation.toUserDetail(
                          context,
                          pubkey: ref.authorPubkey,
                          repoUrl: ref.authorRepoUrl,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PolisDropdown extends StatelessWidget {
  final List<PolisMembership> poleis;
  final PolisMembership? selected;
  final ValueChanged<PolisMembership?> onChanged;

  const _PolisDropdown({
    required this.poleis,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.space * 2,
        vertical: AppSizes.space,
      ),
      child: DropdownButtonFormField<PolisMembership>(
        value: selected,
        decoration: const InputDecoration(
          labelText: 'Polis',
          border: OutlineInputBorder(),
          isDense: true,
        ),
        items: poleis
            .map(
              (p) => DropdownMenuItem(
                value: p,
                child: Text(p.name),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class _EmptyPolisState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.space * 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Join a polis to see community feeds',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.space),
            TextButton(
              onPressed: () => AppNavigation.toConnections(context),
              child: const Text('Browse Connections'),
            ),
          ],
        ),
      ),
    );
  }
}
