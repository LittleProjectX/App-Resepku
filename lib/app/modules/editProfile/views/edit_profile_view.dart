import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            children: [
              Align(
                alignment: AlignmentGeometry.center,
                child: Text('Edit Profile', style: AppTextStyle.heading3),
              ),
              const SizedBox(height: 24),
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/cook.jpg'),
                    radius: 60,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SizedBox(
                      height: 45,
                      width: 45,
                      child: Material(
                        color: AppColors.surface,
                        shape: CircleBorder(),
                        elevation: 4,
                        child: Icon(Iconsax.camera, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
