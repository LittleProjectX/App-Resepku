import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => controller.currentPage[controller.currentIndext.value],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Obx(
            () => BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: AppTextStyle.textSelectNavBar,
              unselectedLabelStyle: AppTextStyle.textUnselectNavBar,
              iconSize: 24,
              currentIndex: controller.currentIndext.value,
              onTap: (value) => controller.currentIndext.value = value,
              selectedFontSize: 32,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.home_2_copy),
                  activeIcon: Icon(Iconsax.home_2),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.save_2_copy),
                  activeIcon: Icon(Iconsax.save_2),
                  label: 'Disimpan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.folder_open_copy),
                  activeIcon: Icon(Iconsax.folder_open),
                  label: 'Pribadi',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Iconsax.user_copy),
                  activeIcon: Icon(Iconsax.user),
                  label: 'Profil',
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => controller.callLogout(),
      //   child: Icon(Icons.logout),
      // ),
    );
  }
}
