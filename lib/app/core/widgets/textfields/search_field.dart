import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

Widget buildSearchField({
  required String label,
  required TextEditingController ctrl,
  required FocusNode focusNode,
  required VoidCallback onClear,
  required ValueChanged<String> onChange,
  bool autoFocus = false,
}) {
  return TextField(
    controller: ctrl,
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
      suffixIcon: IconButton(icon: const Icon(Icons.clear), onPressed: onClear),

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(color: Colors.transparent),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(color: Colors.orange, width: 1.5),
      ),
    ),
  );
}
