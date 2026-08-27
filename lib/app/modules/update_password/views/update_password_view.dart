import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/utils/loading_page.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';
import 'package:seleraku/app/core/widgets/buttons/large_button.dart';
import 'package:seleraku/app/core/widgets/textfields/password.dart';
import 'package:seleraku/app/core/widgets/texts/build_label.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  const UpdatePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.pageLoading.value) {
        return Scaffold(body: loadingPage());
      }
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentGeometry.topLeft,
                      child: ButtonCircle(
                        onTap: () => Get.back(),
                        icon: Icons.arrow_back,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Center(
                      child: Text(
                        'Ubah Password',
                        style: AppTextStyle.heading2,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabel('Password Lama'),
                          Obx(
                            () => BuildPasswordField(
                              hintText: 'Password Lama',
                              eyeTap: () =>
                                  controller.isOldPasswordObs.toggle(),
                              isObs: controller.isOldPasswordObs.value,
                              controller: controller.oldPassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Harap mengisi password";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          buildLabel('Password Baru'),
                          Obx(
                            () => BuildPasswordField(
                              hintText: 'Password Baru',
                              eyeTap: () =>
                                  controller.isNewPasswordObs.toggle(),
                              isObs: controller.isNewPasswordObs.value,
                              controller: controller.newPassword,
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
                          const SizedBox(height: 24),
                          buildLabel('Konfirmasi Password'),
                          Obx(
                            () => BuildPasswordField(
                              hintText: 'Konfirmasi Password',
                              eyeTap: () =>
                                  controller.isConfirmPasswordObs.toggle(),
                              isObs: controller.isConfirmPasswordObs.value,
                              controller: controller.confirmPassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Harap mengisi password";
                                }
                                if (value != controller.newPassword.text) {
                                  return "Password tidak sesuai";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 32),
                          buildLargeButton(
                            label: 'Update',
                            isLoading: controller.buttonLoading.value,
                            onTap: () {
                              if (controller.dataUser.value == null ||
                                  controller.pageLoading.value == true) {
                                null;
                              }
                              if (controller.formKey.currentState!.validate()) {
                                controller.callUpdatePassword(
                                  controller.dataUser.value!.email,
                                  controller.oldPassword.text,
                                  controller.newPassword.text,
                                  controller.confirmPassword.text,
                                );
                              }
                              null;
                            },
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () => Get.back(),
                              child: Text('Batal', style: AppTextStyle.button3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
