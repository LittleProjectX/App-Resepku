import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/widgets/buttons/large_button.dart';

import '../controllers/load_image_controller.dart';

class LoadImageView extends GetView<LoadImageController> {
  const LoadImageView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Material(
              color: AppColors.surface,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 32, 12),
                  child: Row(
                    children: [
                      BackButton(),
                      Text('Data Pengguna', style: AppTextStyle.heading5),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => SizedBox(
              height: height * 0.5,
              width: double.infinity,
              child: controller.selectedFile.value == null
                  ? Image.asset('assets/images/no_image.jpg')
                  : Image.file(
                      controller.selectedFile.value!,
                      fit: BoxFit.fitWidth,
                    ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 120,
                child: buildLargeButton(
                  label: 'Pilih',
                  onTap: () {
                    controller.pickImage();
                  },
                ),
              ),
              SizedBox(
                width: 120,
                child: buildLargeButton(
                  label: 'Simpan',
                  isLoading: controller.isLoading.value,
                  onTap: () {
                    if (controller.selectedFile.value != null) {
                      controller.saveProfileImage(controller.uId);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Batal', style: AppTextStyle.textButton),
          ),
        ],
      ),
    );
  }
}
