import 'package:flutter/material.dart';
import '../primitives/app_sizes.dart';
import '../theme/app_theme.dart';

/// Text input with stone border and terracotta focus highlight.
///
/// Wraps [TextField] with consistent Athenian civic styling.
/// Square corners, no rounded pills.
class ChiseledTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final int maxLines;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  const ChiseledTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.maxLines = 1,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: obscureText ? 1 : maxLines,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      enabled: enabled,
      style: context.textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.tertiary,
        ),
        hintStyle: context.textTheme.bodyMedium?.copyWith(
          color: context.colorScheme.tertiary.withValues(alpha: 0.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          borderSide: BorderSide(color: context.colorScheme.tertiary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          borderSide: BorderSide(color: context.colorScheme.tertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          borderSide: BorderSide(
            color: context.colorScheme.primary,
            width: AppSizes.borderWidthThick,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          borderSide: BorderSide(color: context.colorScheme.error),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.space * 2,
          vertical: AppSizes.space * 1.5,
        ),
      ),
    );
  }
}
