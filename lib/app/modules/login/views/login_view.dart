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
                    padding: EdgeInsetsGeometry.only(top: 8),
                    child: buttonCircle(
                      onTap: () => Get.back(),
                      icon: Icons.arrow_back,
                      left: 24,
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
                      padding: EdgeInsetsGeometry.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Masuk', style: AppTextStyle.heading8),
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
                          buildEmailField(
                            hintText: 'Email',
                            controller: controller.email,
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: AlignmentGeometry.centerLeft,
                            child: buildLabel('Password'),
                          ),
                          Obx(
                            () => buildPasswordField(
                              hintText: 'Password',
                              eyeTap: () => controller.isObs.toggle(),
                              isObs: controller.isObs.value,
                              controller: controller.password,
                            ),
                          ),
                          Align(
                            alignment: AlignmentGeometry.centerRight,
                            child: TextButton(
                              onPressed: () =>
                                  Get.toNamed(Routes.EDIT_PASSWORD),
                              child: Text(
                                'Lupa Password ?',
                                style: AppTextStyle.textButton,
                              ),
                            ),
                          ),
                          Obx(
                            () => buildLargeButton(
                              label: 'Masuk',
                              isLoading: controller.isLoading.value,
                              onTap: () => controller.callLogin(
                                controller.email.text,
                                controller.password.text,
                              ),
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
                                  style: AppTextStyle.body3,
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
                                side: BorderSide(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                              onPressed: () =>
                                  controller.callSigninWithGoogle(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 24,
                                    child: Image.asset(
                                      'assets/icons/google.png',
                                    ),
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
