import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../app_router.dart';
import '../../../core/config/app_config.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/ui_flow_listener.dart';
import '../../../l10n/app_localizations.dart';
import '../cubit/account_creation_cubit.dart';
import '../cubit/account_creation_state.dart';
import '../services/account_creation_message_mapper.dart';

class AccountCreationScreen extends StatelessWidget {
  const AccountCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<AccountCreationCubit>(),
      child: const _AccountCreationScreenBody(),
    );
  }
}

class _AccountCreationScreenBody extends StatefulWidget {
  const _AccountCreationScreenBody();

  @override
  State<_AccountCreationScreenBody> createState() =>
      _AccountCreationScreenBodyState();
}

class _AccountCreationScreenBodyState
    extends State<_AccountCreationScreenBody> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _indexUrlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    _indexUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.accountCreationConnectTitle)),
      body: UiFlowListener<AccountCreationCubit, AccountCreationState>(
        mapper: GetIt.instance<AccountCreationMessageMapper>(),
        listener: (context, state) {
          if (state.result != null) {
            AppRouter.setHasAccount(true);
            AppNavigation.toFeed(context);
          }
        },
        child: BlocBuilder<AccountCreationCubit, AccountCreationState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(AppSizes.space * 2),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _indexUrlController,
                      decoration: InputDecoration(
                        labelText: l10n.labelIndexServerUrl,
                        hintText: l10n.indexServerUrlHint,
                      ),
                      keyboardType: TextInputType.url,
                      autocorrect: false,
                      validator: (v) =>
                          v == null || v.trim().isEmpty
                              ? l10n.validationRequired
                              : null,
                    ),
                    SizedBox(height: AppSizes.space),
                    TextFormField(
                      controller: _urlController,
                      decoration: InputDecoration(
                        labelText: l10n.labelGitServerUrl,
                        hintText: l10n.accountCreationUrlHint,
                      ),
                      keyboardType: TextInputType.url,
                      autocorrect: false,
                      validator: (v) =>
                          v == null || v.trim().isEmpty
                              ? l10n.validationRequired
                              : null,
                    ),
                    SizedBox(height: AppSizes.space * 3),
                    FilledButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<AccountCreationCubit>()
                                    .connectAccount(
                                      serverUrl: _urlController.text,
                                      indexServerUrl:
                                          _indexUrlController.text,
                                    );
                              }
                            },
                      child: Text(
                        state.isLoading
                            ? l10n.accountCreationConnecting
                            : l10n.accountCreationConnect,
                      ),
                    ),
                    SizedBox(height: AppSizes.space),
                    OutlinedButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<AccountCreationCubit>()
                                    .openSignupPage(
                                      _urlController.text,
                                    );
                              }
                            },
                      child: Text(l10n.accountCreationSignup),
                    ),
                    if (AppConfig.hasGuestMode) ...[
                      SizedBox(height: AppSizes.space * 2),
                      TextButton(
                        onPressed: state.isLoading
                            ? null
                            : () {
                                AppRouter.setIsGuest(true);
                                AppNavigation.toFeed(context);
                              },
                        child: Text(l10n.accountCreationGuest),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
