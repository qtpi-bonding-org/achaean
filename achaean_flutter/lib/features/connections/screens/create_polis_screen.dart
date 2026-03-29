import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/achaean_scaffold.dart';
import '../../../design_system/widgets/chiseled_text_field.dart';
import '../../../design_system/widgets/terracotta_button.dart';
import '../../../design_system/widgets/ui_flow_listener.dart';
import '../../../l10n/app_localizations.dart';
import '../../polis/cubit/polis_cubit.dart';
import '../../polis/cubit/polis_state.dart';

class CreatePolisScreen extends StatelessWidget {
  const CreatePolisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<PolisCubit>(),
      child: const _CreatePolisScreenBody(),
    );
  }
}

class _CreatePolisScreenBody extends StatefulWidget {
  const _CreatePolisScreenBody();

  @override
  State<_CreatePolisScreenBody> createState() => _CreatePolisScreenBodyState();
}

class _CreatePolisScreenBodyState extends State<_CreatePolisScreenBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _normsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _normsController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<PolisCubit>().createPolis(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          norms: _normsController.text.trim().isEmpty
              ? null
              : _normsController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AchaeanScaffold(
      title: l10n.createPolisTitle,
      onBack: () => AppNavigation.back(context),
      body: SimpleUiFlowListener<PolisCubit, PolisState>(
        showSuccessToasts: true,
        child: BlocListener<PolisCubit, PolisState>(
          listenWhen: (previous, current) =>
              previous.createdPolis != current.createdPolis &&
              current.createdPolis != null,
          listener: (context, state) {
            AppNavigation.back(context);
          },
          child: BlocBuilder<PolisCubit, PolisState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(AppSizes.space * 2),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ChiseledTextField(
                        controller: _nameController,
                        labelText: l10n.polisNameLabel,
                        hintText: l10n.polisNameHint,
                        enabled: !state.isLoading,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return l10n.polisNameLabel;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSizes.space * 2),
                      ChiseledTextField(
                        controller: _descriptionController,
                        labelText: l10n.polisDescriptionLabel,
                        hintText: l10n.polisDescriptionHint,
                        maxLines: 4,
                        enabled: !state.isLoading,
                      ),
                      SizedBox(height: AppSizes.space * 2),
                      ChiseledTextField(
                        controller: _normsController,
                        labelText: l10n.polisNormsLabel,
                        hintText: l10n.polisNormsHint,
                        maxLines: 4,
                        enabled: !state.isLoading,
                      ),
                      SizedBox(height: AppSizes.space * 3),
                      TerracottaButton(
                        label: l10n.createPolisButton,
                        isLoading: state.isLoading,
                        onPressed: () => _submit(context),
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
