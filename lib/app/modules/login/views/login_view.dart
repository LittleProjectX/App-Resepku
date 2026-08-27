import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';
import 'package:seleraku/app/core/widgets/buttons/large_button.dart';
import 'package:seleraku/app/core/widgets/textfields/email.dart';
import 'package:seleraku/app/core/widgets/textfields/password.dart';
import 'package:seleraku/app/core/widgets/texts/build_label.dart';
import 'package:seleraku/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
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
                      horizontal: 24,
                      vertical: 32,
                    ),
                    width: double.infinity,
                    // height: height * 0.85,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(30),
                          offset: Offset(2, 2),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Masuk ke akun anda',
                          style: AppTextStyle.heading8,
                        ),
                        Text(
                          'Masuk untuk dapat mulai menggunakan\n aplikasi seleraku',
                          style: AppTextStyle.body7,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Align(
                          alignment: AlignmentGeometry.centerLeft,
                          child: buildLabel('Email'),
                        ),
                        BuildEmailField(
                          hintText: 'cth: agus@gmail.com',
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
                          alignment: AlignmentGeometry.centerLeft,
                          child: buildLabel('Password'),
                        ),
                        Obx(
                          () => BuildPasswordField(
                            hintText: 'Password',
                            eyeTap: () => controller.isObs.toggle(),
                            isObs: controller.isObs.value,
                            controller: controller.password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Harap mengisi password";
                              }
                              return null;
                            },
                          ),
                        ),
                        Align(
                          alignment: AlignmentGeometry.centerRight,
                          child: TextButton(
                            onPressed: () => Get.toNamed(Routes.EDIT_PASSWORD),
                            child: Text(
                              'Lupa Password ?',
                              style: AppTextStyle.textButton,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => buildLargeButton(
                            label: 'Masuk',
                            isLoading: controller.isLoading.value,
                            onTap: () {
                              if (controller.isLoading.value) return;
                              if (!controller.formKey.currentState!
                                  .validate()) {
                                return;
                              }
                              controller.callLogin(
                                controller.email.text,
                                controller.password.text,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Belum memiliki akun?',
                              style: AppTextStyle.body2,
                            ),
                            TextButton(
                              onPressed: () => Get.toNamed(Routes.REGISTER),
                              child: Text(
                                'Daftar',
                                style: AppTextStyle.textButton,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 2,
                                color: AppColors.strongBorder,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                'atau Login dengan',
                                style: AppTextStyle.body9,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 2,
                                color: AppColors.strongBorder,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.surface,
                            ),
                            onPressed: () {
                              if (controller.isLoading.value) {
                                null;
                              } else {
                                controller.callSigninWithGoogle();
                              }
                            },

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 24,
                                  child: Image.asset('assets/icons/google.png'),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'masuk dengan Google',
                                  style: AppTextStyle.body2,
                                ),
                              ],
                            ),
                          ),
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
