import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/modules/profile/views/widgets/build_listtile_profile.dart';
import 'package:seleraku/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          buildListTileProfile(
            Iconsax.user_copy,
            'Profil',
            'ubah profil dan data anda',
            () => Get.toNamed(Routes.EDIT_PROFILE),
          ),
          buildListTileProfile(
            Iconsax.lock_1_copy,
            'Password',
            'ubah password anda',
            () => Get.toNamed(Routes.UPDATE_PASSWORD),
          ),
          const SizedBox(height: 10),
          buildListTileProfile(
            Iconsax.info_circle_copy,
            'Tentang',
            'penjelasan mengenai aplikasi',
            () => Get.toNamed(Routes.ABOUT),
          ),
          buildListTileProfile(
            Iconsax.document_copy,
            'Panduan',
            'petunjuk penggunaan aplikasi',
            () => Get.toNamed(Routes.INSTRUCTION),
          ),
          const SizedBox(height: 10),
          buildListTileProfile(
            Iconsax.logout_1_copy,
            'Logout',
            'keluar dari aplikasi',
            () {
              controller.logout();
            },
          ),
          const SizedBox(height: 32),
          Text('Seleraku v1.0.0', style: AppTextStyle.body6),
          Text('@LittleProjext', style: AppTextStyle.body6),
        ],
      ),
    );
  }
}
