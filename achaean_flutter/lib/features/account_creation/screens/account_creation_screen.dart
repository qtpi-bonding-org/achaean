import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/ui_flow_listener.dart';
import '../../../l10n/app_localizations.dart';
import '../cubit/account_creation_cubit.dart';
import '../cubit/account_creation_state.dart';
import '../services/account_creation_message_mapper.dart';

class AccountCreationScreen extends StatefulWidget {
  const AccountCreationScreen({super.key});

  @override
  State<AccountCreationScreen> createState() => _AccountCreationScreenState();
}

class _AccountCreationScreenState extends State<AccountCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => GetIt.instance<AccountCreationCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.accountCreationTitle)),
        body: UiFlowListener<AccountCreationCubit, AccountCreationState>(
          mapper: GetIt.instance<AccountCreationMessageMapper>(),
          listener: (context, state) {
            if (state.result != null) {
              AppNavigation.toHome(context);
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
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: l10n.labelUsername,
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? l10n.validationRequired : null,
                      ),
                      SizedBox(height: AppSizes.space),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: l10n.labelEmail,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) =>
                            v == null || v.isEmpty ? l10n.validationRequired : null,
                      ),
                      SizedBox(height: AppSizes.space),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: l10n.labelPassword,
                        ),
                        obscureText: true,
                        validator: (v) =>
                            v == null || v.isEmpty ? l10n.validationRequired : null,
                      ),
                      SizedBox(height: AppSizes.space * 3),
                      FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<AccountCreationCubit>()
                                .createAccount(
                                  username: _usernameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                );
                          }
                        },
                        child: Text(l10n.accountCreationSubmit),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
