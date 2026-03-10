import 'package:flutter/material.dart';

/// App scaffold — stone background with Cinzel-titled app bar.
///
/// Every screen should use this instead of raw [Scaffold].
/// Provides consistent app bar styling, background color,
/// and optional actions.
class AchaeanScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBack;

  const AchaeanScaffold({
    super.key,
    this.title,
    required this.body,
    this.actions,
    this.showBackButton = true,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
