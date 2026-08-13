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
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: height * 0.5,
            child: Image.asset(
              'assets/images/food.jpg',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.medium,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(top: 12),
                    child: buttonCircle(
                      onTap: () => Get.back(),
                      icon: Icons.arrow_back,
                      left: 32,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.15 - 53),
                SizedBox(
                  width: double.infinity,
                  height: height * 0.85,
                  child: Material(
                    color: AppColors.background,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Daftar Akun', style: AppTextStyle.heading8),
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
                          buildEmailField(
                            hintText: 'Email',
                            controller: controller.email,
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: buildLabel('Password'),
                          ),
                          Obx(
                            () => buildPasswordField(
                              hintText: 'Password',
                              eyeTap: () => controller.isPasswordObs.toggle(),
                              isObs: controller.isPasswordObs.value,
                              controller: controller.password,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: buildLabel('Ulangi Password'),
                          ),
                          Obx(
                            () => buildPasswordField(
                              hintText: 'Ulangi Password',
                              eyeTap: () =>
                                  controller.isConfirmPasswordObs.toggle(),
                              isObs: controller.isConfirmPasswordObs.value,
                              controller: controller.confirmPassword,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Obx(
                            () => buildLargeButton(
                              label: 'Daftar',
                              isLoading: controller.isLoading.value,
                              onTap: () => controller.isLoading.value
                                  ? null
                                  : controller.callRegister(
                                      controller.email.text,
                                      controller.password.text,
                                      controller.confirmPassword.text,
                                    ),
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
