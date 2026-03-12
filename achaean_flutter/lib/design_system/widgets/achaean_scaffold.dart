import 'package:flutter/material.dart';
import '../accessibility/accessible_widget.dart';

/// App scaffold — stone background with Cinzel-titled app bar.
///
/// Every screen should use this instead of raw [Scaffold].
/// Provides consistent app bar styling, background color,
/// and optional actions.
class AchaeanScaffold extends StatelessWidget with AccessibleWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBack;

  @override
  final bool decorative;
  @override
  final String? semanticLabel;

  const AchaeanScaffold({
    super.key,
    this.title,
    required this.body,
    this.actions,
    this.showBackButton = true,
    this.onBack,
    this.decorative = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return buildAccessible(child: Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
              automaticallyImplyLeading: showBackButton,
              leading: showBackButton && onBack != null
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: onBack,
                    )
                  : null,
              actions: actions,
            )
          : null,
      body: SafeArea(
        top: title == null,
        child: body,
      ),
    ));
  }
}
