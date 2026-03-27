import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/inscription_tile.dart';
import '../../../design_system/widgets/stone_divider.dart';
import '../../agora/cubit/polis_discovery_cubit.dart';
import '../../agora/cubit/polis_discovery_state.dart';
import '../../polis/cubit/polis_cubit.dart';
import '../../polis/cubit/polis_state.dart';

/// Embeddable body for the Polis tab in ConnectionsScreen.
///
/// Shows "Your Poleis" (from [PolisCubit]) and "Browse Poleis" (from
/// [PolisDiscoveryCubit]) in a single scrollable view.
class PolisContent extends StatefulWidget {
  const PolisContent({super.key});

  @override
  State<PolisContent> createState() => _PolisContentState();
}

class _PolisContentState extends State<PolisContent> {
  @override
  void initState() {
    super.initState();
    context.read<PolisCubit>().loadOwnPoleis();
    context.read<PolisDiscoveryCubit>().loadPoleis();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _SectionHeader(title: 'Your Poleis'),
        BlocBuilder<PolisCubit, PolisState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (state.poleis.isEmpty) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.space * 2,
                    vertical: AppSizes.space * 2,
                  ),
                  child: Text(
                    'You have not joined any poleis yet.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final polis = state.poleis[index];
                  return InscriptionTile(
                    title: polis.name,
                    subtitle: polis.repo,
                    onTap: () => AppNavigation.toPolisDetail(
                      context,
                      repoUrl: polis.repo,
                      name: polis.name,
                    ),
                  );
                },
                childCount: state.poleis.length,
              ),
            );
          },
        ),
        SliverToBoxAdapter(
          child: StoneDivider(
            verticalPadding: AppSizes.space,
          ),
        ),
        _SectionHeader(title: 'Browse Poleis'),
        BlocBuilder<PolisDiscoveryCubit, PolisDiscoveryState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (state.poleis.isEmpty) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.space * 2,
                    vertical: AppSizes.space * 2,
                  ),
                  child: Text(
                    'No poleis found.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final polis = state.poleis[index];
                  return InscriptionTile(
                    title: polis.name,
                    subtitle: polis.description,
                    onTap: () => AppNavigation.toPolisDetail(
                      context,
                      repoUrl: polis.repoUrl,
                      name: polis.name,
                    ),
                  );
                },
                childCount: state.poleis.length,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.space * 2,
          vertical: AppSizes.space,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
