import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../app_router.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../agora/cubit/polis_discovery_cubit.dart';
import '../../observe/cubit/observe_cubit.dart';
import '../../people/widgets/people_content.dart';
import '../../polis/cubit/polis_cubit.dart';
import '../../trust/cubit/trust_cubit.dart';
import '../widgets/polis_content.dart';

class ConnectionsScreen extends StatelessWidget {
  const ConnectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.instance<TrustCubit>()),
        BlocProvider(create: (_) => GetIt.instance<ObserveCubit>()),
        BlocProvider(create: (_) => GetIt.instance<PolisCubit>()),
        BlocProvider(create: (_) => GetIt.instance<PolisDiscoveryCubit>()),
      ],
      child: const _ConnectionsScreenBody(),
    );
  }
}

class _ConnectionsScreenBody extends StatefulWidget {
  const _ConnectionsScreenBody();

  @override
  State<_ConnectionsScreenBody> createState() => _ConnectionsScreenBodyState();
}

class _ConnectionsScreenBodyState extends State<_ConnectionsScreenBody>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AchaeanScaffold(
      title: 'Connections',
      showBackButton: false,
      actions: [
        ListenableBuilder(
          listenable: _tabController,
          builder: (context, _) {
            if (_tabController.index != 1) return const SizedBox.shrink();
            return IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Create Polis',
              onPressed: () => AppNavigation.toCreatePolis(context),
            );
          },
        ),
      ],
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'People'),
              Tab(text: 'Polis'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                PeopleContent(),
                PolisContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
