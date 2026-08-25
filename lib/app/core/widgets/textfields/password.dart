import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

class BuildPasswordField extends StatelessWidget {
  const BuildPasswordField({
    super.key,
    this.maxLines = 1,
    required this.hintText,
    required this.eyeTap,
    required this.isObs,
    required this.controller,
    required this.validator,
  });

  final int maxLines;
  final String hintText;
  final VoidCallback eyeTap;
  final bool isObs;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        style: AppTextStyle.body2,
        keyboardType: TextInputType.text,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: isObs ? 1 : maxLines,
        obscureText: isObs,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: AppTextStyle.body7,
          errorStyle: AppTextStyle.fieldEror,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),

          suffixIcon: IconButton(
            onPressed: eyeTap,
            icon: Icon(
              isObs ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              size: 20,
              color: AppColors.primary,
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
