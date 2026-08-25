import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/utils/loading_page.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';

import '../controllers/all_user_controller.dart';

class AllUserView extends GetView<AllUserController> {
  const AllUserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isPageLoading.value) {
        return Scaffold(body: loadingPage());
      }

      final allUser = controller.listAllUser;
      allUser.sort((a, b) => b.likes.compareTo(a.likes));

      if (allUser.isEmpty) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: ButtonCircle(
                    onTap: () => Get.back(),
                    icon: Icons.arrow_back,
                  ),
                ),
                Center(child: Text('Pembuat', style: AppTextStyle.heading2)),
                const SizedBox(height: 24),
                Center(
                  child: Text('Tidak ada data', style: AppTextStyle.body3),
                ),
              ],
            ),
          ),
        );
      }

      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: ButtonCircle(
                    onTap: () => Get.back(),
                    icon: Icons.arrow_back,
                  ),
                ),
                Center(child: Text('Pembuat', style: AppTextStyle.heading2)),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GridView.builder(
                    itemCount: allUser.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        height: 160,
                        width: 120,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            allUser[index].imageUrl != null ||
                                    allUser[index].imageUrl == ''
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      allUser[index].imageUrl.toString(),
                                    ),
                                    radius: 44,
                                  )
                                : CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'assets/images/profile.jpg',
                                    ),
                                    radius: 44,
                                  ),
                            const SizedBox(height: 8),
                            Text(
                              allUser[index].name.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.body8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.heart,
                                  color: AppColors.textSecondary,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  allUser[index].likes.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.body7,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
