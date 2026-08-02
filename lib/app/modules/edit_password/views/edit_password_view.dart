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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  buttonCircle(
                    onTap: () => Get.back(),
                    icon: Icons.arrow_back,
                    left: 0,
                  ),
                  const SizedBox(width: 12),
                  Text('Ganti Password', style: AppTextStyle.heading5),
                ],
              ),
              const SizedBox(height: 24),
              buildEmailField(
                hintText: 'Email Pengguna',
                controller: controller.email,
              ),
              const SizedBox(height: 24),
              buildLargeButton(
                label: 'Reset Password',
                onTap: () {
                  controller.resetPasswordUser(controller.email.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
