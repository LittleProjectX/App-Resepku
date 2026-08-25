import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';
import 'package:seleraku/app/core/widgets/buttons/large_button.dart';
import 'package:seleraku/app/core/widgets/textfields/email.dart';
import 'package:seleraku/app/core/widgets/textfields/password.dart';
import 'package:seleraku/app/core/widgets/texts/build_label.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: height * 0.35,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.vertical(
                bottom: Radius.circular(80),
              ),
              child: Image.asset(
                'assets/images/food.jpg',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsetsGeometry.only(top: 12),
                      child: ButtonCircle(
                        onTap: () => Get.back(),
                        icon: Icons.arrow_back,
                        left: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.15 - 65),
                  Container(
                    margin: EdgeInsets.all(24),
                    padding: EdgeInsetsGeometry.symmetric(
                      horizontal: 32,
                      vertical: 24,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Daftarkan akun anda',
                          style: AppTextStyle.heading8,
                        ),
                        Text(
                          'Satu langkah untuk memulai\n pengalaman baru',
                          style: AppTextStyle.body7,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: buildLabel('Email'),
                        ),
                        BuildEmailField(
                          hintText: 'cth : agus@gmail.com',
                          controller: controller.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Harap mengisi email";
                            }
                            if (!value.contains("@")) {
                              return "Email tidak valid";
                            }
                            if (!value.contains(".")) {
                              return "Email tidak valid";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: buildLabel('Password'),
                        ),
                        Obx(
                          () => BuildPasswordField(
                            hintText: 'Password',
                            eyeTap: () => controller.isPasswordObs.toggle(),
                            isObs: controller.isPasswordObs.value,
                            controller: controller.password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Harap mengisi password";
                              }
                              if (value.length < 6) {
                                return "Password lemah, minimal 6 karakter";
                              }
                              if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
                                return 'Password harus mengandung huruf';
                              }
                              if (!RegExp(r'[0-9]').hasMatch(value)) {
                                return 'Password harus mengandung angka';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: buildLabel('Ulangi Password'),
                        ),
                        Obx(
                          () => BuildPasswordField(
                            hintText: 'Ulangi Password',
                            eyeTap: () =>
                                controller.isConfirmPasswordObs.toggle(),
                            isObs: controller.isConfirmPasswordObs.value,
                            controller: controller.confirmPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Harap mengisi ulang password";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        Obx(
                          () => buildLargeButton(
                            label: 'Daftar',
                            isLoading: controller.isLoading.value,
                            onTap: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.isLoading.value
                                    ? null
                                    : controller.callRegister(
                                        controller.email.text,
                                        controller.password.text,
                                        controller.confirmPassword.text,
                                      );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sudah memiliki akun?',
                              style: AppTextStyle.body2,
                            ),
                            TextButton(
                              onPressed: () => Get.back(),
                              child: Text(
                                'Masuk',
                                style: AppTextStyle.textButton,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
