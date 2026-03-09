import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/ui_flow_listener.dart';
import '../../../l10n/app_localizations.dart';
import '../cubit/post_creation_cubit.dart';
import '../cubit/post_creation_state.dart';
import '../services/post_creation_message_mapper.dart';
import '../widgets/post_form.dart';

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({super.key});

  @override
  State<PostCreationScreen> createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => GetIt.instance<PostCreationCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.postCreationTitle)),
        body: UiFlowListener<PostCreationCubit, PostCreationState>(
          mapper: GetIt.instance<PostCreationMessageMapper>(),
          listener: (context, state) {
            if (state.result != null) {
              AppNavigation.back(context);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(AppSizes.space * 2),
            child: Form(
              key: _formKey,
              child: PostForm(
                textController: _textController,
                titleController: _titleController,
                onSubmit: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<PostCreationCubit>().submitPost(
                          text: _textController.text.trim(),
                          title: _titleController.text.trim().isEmpty
                              ? null
                              : _titleController.text.trim(),
                        );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
