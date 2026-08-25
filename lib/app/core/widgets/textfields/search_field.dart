import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

class BuildSearchField extends StatelessWidget {
  const BuildSearchField({
    super.key,
    this.autoFocus = false,
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.onClear,
    required this.onChange,
  });

  final bool autoFocus;
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onClear;
  final ValueChanged<String> onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChange,
      style: AppTextStyle.body1,
      focusNode: focusNode,
      autofocus: autoFocus,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: label,
        hintStyle: AppTextStyle.body1,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: onClear,
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Colors.transparent),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
