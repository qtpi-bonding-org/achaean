import 'package:achaean_client/achaean_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../app_router.dart';
import '../../../core/services/i_key_service.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../l10n/app_localizations.dart';
import '../../agora/services/i_user_query_service.dart';
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

  bool _incomingLoading = false;
  List<TrustDeclarationRecord> _incomingTrust = [];
  List<ObserveDeclarationRecord> _incomingObserve = [];

  @override
  void initState() {
    super.initState();
    context.read<TrustCubit>().loadOwnTrust();
    context.read<ObserveCubit>().loadOwnObserve();
    _loadIncoming();
  }

  Future<void> _loadIncoming() async {
    final getIt = GetIt.instance;
    if (!getIt.isRegistered<IUserQueryService>() ||
        !getIt.isRegistered<IKeyService>()) {
      return;
    }
    setState(() => _incomingLoading = true);
    try {
      final pubkey = await getIt<IKeyService>().getPublicKeyHex();
      if (pubkey == null) return;
      final relationships =
          await getIt<IUserQueryService>().getRelationships(pubkey);
      if (mounted) {
        setState(() {
          _incomingTrust = relationships.incomingTrust;
          _incomingObserve = relationships.incomingObserve;
          _incomingLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _incomingLoading = false);
    }
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

    if (_incomingLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_segmentIndex == 0) {
      if (_incomingTrust.isEmpty) {
        return Center(child: Text(l10n.noIncomingTrust));
      }
      return ListView.builder(
        itemCount: _incomingTrust.length,
        itemBuilder: (context, index) {
          final record = _incomingTrust[index];
          return UserIdentityTile(
            pubkey: record.fromPubkey,
            onTap: () => AppNavigation.toUserDetail(
              context,
              pubkey: record.fromPubkey,
              repoUrl: '',
            ),
          );
        },
      );
    } else {
      if (_incomingObserve.isEmpty) {
        return Center(child: Text(l10n.noIncomingObserve));
      }
      return ListView.builder(
        itemCount: _incomingObserve.length,
        itemBuilder: (context, index) {
          final record = _incomingObserve[index];
          return UserIdentityTile(
            pubkey: record.fromPubkey,
            onTap: () => AppNavigation.toUserDetail(
              context,
              pubkey: record.fromPubkey,
              repoUrl: '',
            ),
          );
        },
      );
    }
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

  bool _incomingLoading = false;
  List<TrustDeclarationRecord> _incomingTrust = [];
  List<ObserveDeclarationRecord> _incomingObserve = [];

  @override
  void initState() {
    super.initState();
    context.read<TrustCubit>().loadOwnTrust();
    context.read<ObserveCubit>().loadOwnObserve();
    _loadIncoming();
  }

  Future<void> _loadIncoming() async {
    final getIt = GetIt.instance;
    if (!getIt.isRegistered<IUserQueryService>() ||
        !getIt.isRegistered<IKeyService>()) {
      return;
    }
    setState(() => _incomingLoading = true);
    try {
      final pubkey = await getIt<IKeyService>().getPublicKeyHex();
      if (pubkey == null) return;
      final relationships =
          await getIt<IUserQueryService>().getRelationships(pubkey);
      if (mounted) {
        setState(() {
          _incomingTrust = relationships.incomingTrust;
          _incomingObserve = relationships.incomingObserve;
          _incomingLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _incomingLoading = false);
    }
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

    if (_incomingLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_segmentIndex == 0) {
      if (_incomingTrust.isEmpty) {
        return Center(child: Text(l10n.noIncomingTrust));
      }
      return ListView.builder(
        itemCount: _incomingTrust.length,
        itemBuilder: (context, index) {
          final record = _incomingTrust[index];
          return UserIdentityTile(
            pubkey: record.fromPubkey,
            onTap: () => AppNavigation.toUserDetail(
              context,
              pubkey: record.fromPubkey,
              repoUrl: '',
            ),
          );
        },
      );
    } else {
      if (_incomingObserve.isEmpty) {
        return Center(child: Text(l10n.noIncomingObserve));
      }
      return ListView.builder(
        itemCount: _incomingObserve.length,
        itemBuilder: (context, index) {
          final record = _incomingObserve[index];
          return UserIdentityTile(
            pubkey: record.fromPubkey,
            onTap: () => AppNavigation.toUserDetail(
              context,
              pubkey: record.fromPubkey,
              repoUrl: '',
            ),
          );
        },
      );
    }
  }
}
