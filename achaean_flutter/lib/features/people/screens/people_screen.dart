import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../l10n/app_localizations.dart';
import '../../trust/cubit/trust_cubit.dart';
import '../../trust/cubit/trust_state.dart';
import '../../observe/cubit/observe_cubit.dart';
import '../../observe/cubit/observe_state.dart';
import '../widgets/user_identity_tile.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  int _segmentIndex = 0; // 0 = Trust, 1 = Observe
  bool _showIncoming = false;

  @override
  void initState() {
    super.initState();
    context.read<TrustCubit>().loadOwnTrust();
    context.read<ObserveCubit>().loadOwnObserve();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AchaeanScaffold(
      title: l10n.peopleTitle,
      showBackButton: false,
      body: Column(
        children: [
          // Segment control: Trust | Observe
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.space * 2,
              vertical: AppSizes.space,
            ),
            child: SegmentedButton<int>(
              segments: [
                ButtonSegment(value: 0, label: Text(l10n.trustSegment)),
                ButtonSegment(value: 1, label: Text(l10n.observeSegment)),
              ],
              selected: {_segmentIndex},
              onSelectionChanged: (selected) {
                setState(() {
                  _segmentIndex = selected.first;
                  _showIncoming = false;
                });
              },
            ),
          ),
          // Direction toggle: Outgoing / Incoming
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.space * 2),
            child: Row(
              children: [
                ChoiceChip(
                  label: Text(l10n.outgoingToggle),
                  selected: !_showIncoming,
                  onSelected: (_) => setState(() => _showIncoming = false),
                ),
                SizedBox(width: AppSizes.space),
                ChoiceChip(
                  label: Text(l10n.incomingToggle),
                  selected: _showIncoming,
                  onSelected: (_) => setState(() => _showIncoming = true),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSizes.space),
          // List
          Expanded(
            child: _showIncoming
                ? _buildIncomingList(context)
                : _buildOutgoingList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildOutgoingList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_segmentIndex == 0) {
      return BlocBuilder<TrustCubit, TrustState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.declarations.isEmpty) {
            return Center(child: Text(l10n.noTrustRelationships));
          }
          return ListView.builder(
            itemCount: state.declarations.length,
            itemBuilder: (context, index) {
              final decl = state.declarations[index];
              return UserIdentityTile(
                pubkey: decl.subject,
                onTap: () => AppNavigation.toUserDetail(
                  context,
                  pubkey: decl.subject,
                  repoUrl: decl.repo,
                ),
              );
            },
          );
        },
      );
    } else {
      return BlocBuilder<ObserveCubit, ObserveState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.declarations.isEmpty) {
            return Center(child: Text(l10n.noObserveRelationships));
          }
          return ListView.builder(
            itemCount: state.declarations.length,
            itemBuilder: (context, index) {
              final decl = state.declarations[index];
              return UserIdentityTile(
                pubkey: decl.subject,
                onTap: () => AppNavigation.toUserDetail(
                  context,
                  pubkey: decl.subject,
                  repoUrl: decl.repo,
                ),
              );
            },
          );
        },
      );
    }
  }

  Widget _buildIncomingList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final emptyMessage = _segmentIndex == 0
        ? l10n.noIncomingTrust
        : l10n.noIncomingObserve;
    return Center(child: Text(emptyMessage));
  }
}

/// Embeddable body of the People screen (no scaffold wrapper).
/// Can be placed inside another screen, e.g. ConnectionsScreen.
class PeopleContent extends StatefulWidget {
  const PeopleContent({super.key});

  @override
  State<PeopleContent> createState() => _PeopleContentState();
}

class _PeopleContentState extends State<PeopleContent> {
  int _segmentIndex = 0; // 0 = Trust, 1 = Observe
  bool _showIncoming = false;

  @override
  void initState() {
    super.initState();
    context.read<TrustCubit>().loadOwnTrust();
    context.read<ObserveCubit>().loadOwnObserve();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        // Segment control: Trust | Observe
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.space * 2,
            vertical: AppSizes.space,
          ),
          child: SegmentedButton<int>(
            segments: [
              ButtonSegment(value: 0, label: Text(l10n.trustSegment)),
              ButtonSegment(value: 1, label: Text(l10n.observeSegment)),
            ],
            selected: {_segmentIndex},
            onSelectionChanged: (selected) {
              setState(() {
                _segmentIndex = selected.first;
                _showIncoming = false;
              });
            },
          ),
        ),
        // Direction toggle: Outgoing / Incoming
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.space * 2),
          child: Row(
            children: [
              ChoiceChip(
                label: Text(l10n.outgoingToggle),
                selected: !_showIncoming,
                onSelected: (_) => setState(() => _showIncoming = false),
              ),
              SizedBox(width: AppSizes.space),
              ChoiceChip(
                label: Text(l10n.incomingToggle),
                selected: _showIncoming,
                onSelected: (_) => setState(() => _showIncoming = true),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSizes.space),
        // List
        Expanded(
          child: _showIncoming
              ? _buildIncomingList(context)
              : _buildOutgoingList(context),
        ),
      ],
    );
  }

  Widget _buildOutgoingList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_segmentIndex == 0) {
      return BlocBuilder<TrustCubit, TrustState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.declarations.isEmpty) {
            return Center(child: Text(l10n.noTrustRelationships));
          }
          return ListView.builder(
            itemCount: state.declarations.length,
            itemBuilder: (context, index) {
              final decl = state.declarations[index];
              return UserIdentityTile(
                pubkey: decl.subject,
                onTap: () => AppNavigation.toUserDetail(
                  context,
                  pubkey: decl.subject,
                  repoUrl: decl.repo,
                ),
              );
            },
          );
        },
      );
    } else {
      return BlocBuilder<ObserveCubit, ObserveState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.declarations.isEmpty) {
            return Center(child: Text(l10n.noObserveRelationships));
          }
          return ListView.builder(
            itemCount: state.declarations.length,
            itemBuilder: (context, index) {
              final decl = state.declarations[index];
              return UserIdentityTile(
                pubkey: decl.subject,
                onTap: () => AppNavigation.toUserDetail(
                  context,
                  pubkey: decl.subject,
                  repoUrl: decl.repo,
                ),
              );
            },
          );
        },
      );
    }
  }

  Widget _buildIncomingList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final emptyMessage = _segmentIndex == 0
        ? l10n.noIncomingTrust
        : l10n.noIncomingObserve;
    return Center(child: Text(emptyMessage));
  }
}
