import 'package:flutter/material.dart';

import '../../../design_system/primitives/app_sizes.dart';
import '../../../l10n/app_localizations.dart';

class PostForm extends StatelessWidget {
  final TextEditingController textController;
  final TextEditingController titleController;
  final VoidCallback onSubmit;

  const PostForm({
    super.key,
    required this.textController,
    required this.titleController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: l10n.postCreationTitleHint,
          ),
        ),
        SizedBox(height: AppSizes.space),
        TextFormField(
          controller: textController,
          decoration: InputDecoration(
            labelText: l10n.postCreationTextHint,
          ),
          maxLines: 8,
          validator: (v) => v == null || v.isEmpty ? l10n.validationRequired : null,
        ),
        SizedBox(height: AppSizes.space * 3),
        FilledButton(
          onPressed: onSubmit,
          child: Text(l10n.postCreationSubmit),
        ),
      ],
    );
  }
}
