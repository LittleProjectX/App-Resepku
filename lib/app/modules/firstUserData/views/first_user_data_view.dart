import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/widgets/avatars/edit_avatar.dart';
import 'package:seleraku/app/core/widgets/buttons/large_button.dart';
import 'package:seleraku/app/core/widgets/textfields/email.dart';
import 'package:seleraku/app/core/widgets/textfields/main_field.dart';
import 'package:seleraku/app/core/widgets/textfields/phone_field.dart';
import 'package:seleraku/app/core/widgets/texts/build_label.dart';
import 'package:seleraku/app/routes/app_pages.dart';
import '../controllers/first_user_data_controller.dart';

class FirstUserDataView extends GetView<FirstUserDataController> {
  const FirstUserDataView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Material(
                color: AppColors.surface,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(32, 24, 32, 12),
                    child: Text('Data Pengguna', style: AppTextStyle.heading5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: AlignmentGeometry.center,
              child: Obx(
                () => EditAvatar(
                  profile: controller.imageUrl.value == ''
                      ? AssetImage('assets/images/profile.jpg')
                      : NetworkImage(controller.imageUrl.value),
                  onTap: () => Get.toNamed(
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
                  BuildMainField(
                    hintText: 'Nama Pengguna',
                    controller: controller.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Silahkan masukkan username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  buildLabel('Email'),
                  BuildEmailField(
                    hintText: 'Email Pengguna',
                    controller: controller.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Silahkan masukkan username';
                      }
                      if (!value.contains('@')) {
                        return "Email tidak valid";
                      }
                      if (!value.contains(".")) {
                        return "Email tidak valid";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  buildLabel('Telepon'),
                  BuildPhoneField(
                    hintText: 'No. Telepon Pengguna',
                    controller: controller.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Silahkan masukkan telepon';
                      }
                      if (value.length < 9) {
                        return "Telepon tidak valid";
                      }
                      return null;
                    },
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
