import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/widgets/avatars/edit_avatar.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';
import 'package:seleraku/app/core/widgets/buttons/large_button.dart';
import 'package:seleraku/app/core/widgets/textfields/email.dart';
import 'package:seleraku/app/core/widgets/textfields/main_field.dart';
import 'package:seleraku/app/core/widgets/textfields/phone_field.dart';
import 'package:seleraku/app/core/widgets/texts/build_label.dart';
import 'package:seleraku/app/routes/app_pages.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Row(
                children: [
                  buttonCircle(
                    onTap: () => Get.back(),
                    icon: Icons.arrow_back,
                    left: 24,
                  ),
                  const SizedBox(width: 12),
                  Text('Ganti Profil', style: AppTextStyle.heading5),
                ],
              ),
              const SizedBox(height: 24),
              Align(
                alignment: AlignmentGeometry.center,
                child: Obx(
                  () => editAvatar(
                    controller.imageUrl.value == ''
                        ? AssetImage('assets/images/profile.jpg')
                        : NetworkImage(controller.imageUrl.value),
                    () => Get.toNamed(
                      Routes.LOAD_IMAGE,
                      parameters: {
                        'imageUrl': controller.imageUrl.value,
                        'uId': controller.uId,
                      },
                    ),
                  ),
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
                    buildLabel('Nama'),
                    buildMainField(
                      hintText: 'Nama Pengguna',
                      controller: controller.name,
                    ),
                    const SizedBox(height: 24),
                    buildLabel('Email'),
                    buildEmailField(
                      hintText: 'Email Pengguna',
                      controller: controller.email,
                    ),
                    const SizedBox(height: 24),
                    buildLabel('Telepon'),
                    buildPhoneField(
                      hintText: 'No. Telepon Pengguna',
                      controller: controller.phone,
                    ),
                    const SizedBox(height: 32),
                    buildLargeButton(
                      label: 'Simpan',
                      isLoading: controller.isLoading.value,
                      onTap: () {
                        controller.setUser(
                          controller.uId,
                          controller.name.text,
                          controller.email.text,
                          controller.phone.text,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () => Get.back(),
                        child: Text('Batal', style: AppTextStyle.button2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
