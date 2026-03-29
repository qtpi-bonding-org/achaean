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
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../services/profile_message_mapper.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<ProfileCubit>()..loadOwnProfile(),
      child: const _EditProfileScreenBody(),
    );
  }
}

class _EditProfileScreenBody extends StatefulWidget {
  const _EditProfileScreenBody();

  @override
  State<_EditProfileScreenBody> createState() => _EditProfileScreenBodyState();
}

class _EditProfileScreenBodyState extends State<_EditProfileScreenBody> {
  final _displayNameController = TextEditingController();
  final _bioController = TextEditingController();
  bool _initialized = false;

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AchaeanScaffold(
      title: l10n.editProfile,
      onBack: () => AppNavigation.back(context),
      body: UiFlowListener<ProfileCubit, ProfileState>(
        mapper: GetIt.instance<ProfileMessageMapper>(),
        listener: (context, state) {
          if (state.isSuccess && _initialized) {
            AppNavigation.back(context);
          }
        },
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (!_initialized && !state.isIdle) {
              _displayNameController.text = state.profile.displayName ?? '';
              _bioController.text = state.profile.bio ?? '';
              _initialized = true;
            }

            return Padding(
              padding: EdgeInsets.all(AppSizes.space * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ChiseledTextField(
                    controller: _displayNameController,
                    labelText: l10n.displayNameLabel,
                    hintText: l10n.displayNameHint,
                  ),
                  SizedBox(height: AppSizes.space),
                  ChiseledTextField(
                    controller: _bioController,
                    labelText: l10n.bioLabel,
                    hintText: l10n.bioHint,
                    maxLines: 3,
                  ),
                  SizedBox(height: AppSizes.space * 3),
                  TerracottaButton(
                    label: l10n.saveProfile,
                    isLoading: state.isLoading,
                    onPressed: () {
                      context.read<ProfileCubit>().updateProfile(
                            displayName:
                                _displayNameController.text.trim().isEmpty
                                    ? null
                                    : _displayNameController.text.trim(),
                            bio: _bioController.text.trim().isEmpty
                                ? null
                                : _bioController.text.trim(),
                          );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
