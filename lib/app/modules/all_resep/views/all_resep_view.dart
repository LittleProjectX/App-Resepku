import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/utils/loading_page.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';
import 'package:seleraku/app/core/widgets/global_widgets/build_resep.dart';
import 'package:seleraku/app/routes/app_pages.dart';

import '../controllers/all_resep_controller.dart';

class AllResepView extends GetView<AllResepController> {
  const AllResepView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isPageLoading.value) {
        return Scaffold(body: loadingPage());
      }

      final allResep = controller.listAllResep;
      final filterResep = allResep.where((resep) {
        if (controller.category.value == 'Semua') {
          return true;
        } else {
          return resep.category == controller.category.value;
        }
      }).toList();
      if (filterResep.isEmpty) {
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
                const SizedBox(width: 24),
                Center(
                  child: Obx(
                    () => Text(
                      controller.category.value,
                      style: AppTextStyle.heading2,
                    ),
                  ),
                ),
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
                const SizedBox(width: 24),
                Center(
                  child: Obx(
                    () => Text(
                      controller.category.value,
                      style: AppTextStyle.heading2,
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  itemCount: filterResep.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final resep = filterResep[index];

                    return Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(12),
                              child: Image.network(
                                resep.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            resep.title,
                            style: AppTextStyle.body2,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.ramen_dining,
                                size: 12,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                resep.portion,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.body7,
                              ),
                              const SizedBox(width: 4),
                              Text('|', style: AppTextStyle.body7),
                              const SizedBox(width: 4),
                              Icon(
                                Iconsax.heart,
                                color: AppColors.textSecondary,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                resep.likes.toString(),
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
              ],
            ),
          ),
        ),
      );
    });
  }
}

// return BuildResep(
//                       imageUrl: resep.imageUrl,
//                       title: resep.title,
//                       portion: resep.portion,
//                       likes: resep.likes,
//                       onTap: () => Get.toNamed(
//                         Routes.DETAIL,
//                         parameters: {'rId': resep.rId},
//                       ),
//                     );
