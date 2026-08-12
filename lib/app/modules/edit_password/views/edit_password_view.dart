import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';
import 'package:seleraku/app/core/widgets/buttons/large_button.dart';
import 'package:seleraku/app/core/widgets/textfields/email.dart';
import '../controllers/edit_password_controller.dart';

class EditPasswordView extends GetView<EditPasswordController> {
  const EditPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: buttonCircle(
                    onTap: () => Get.back(),
                    icon: Icons.arrow_back,
                    left: 0,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 250,
                  child: Image.asset(
                    'assets/images/computer_lock.png',
                    filterQuality: FilterQuality.medium,
                  ),
                ),
                Text('Reset Password ?', style: AppTextStyle.heading2),
                Text(
                  'Untuk dapat mereset password, masukkan\n email yang tertaut dengan\n akun anda.',
                  style: AppTextStyle.body7,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                buildEmailField(
                  hintText: 'Email',
                  controller: controller.email,
                ),
                const SizedBox(height: 24),
                buildLargeButton(
                  label: 'Reset Password',
                  isLoading: controller.isLoading.value,
                  onTap: () {
                    controller.resetPasswordUser(controller.email.text);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
