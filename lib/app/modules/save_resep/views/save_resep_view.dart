import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/utils/loading_page.dart';
import 'package:seleraku/app/core/widgets/texts/build_like.dart';

import 'package:seleraku/app/routes/app_pages.dart';
import '../controllers/save_resep_controller.dart';

class SaveResepView extends GetView<SaveResepController> {
  const SaveResepView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return loadingPage();
      }
      final resep = controller.listResep;

      if (controller.listFavorite.isEmpty) {
        return Center(child: Text('Tidak ada data', style: AppTextStyle.body2));
      }

      return Padding(
        padding: const EdgeInsets.all(24),
        child: ListView.builder(
          itemCount: resep.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () => Get.toNamed(
                  Routes.DETAIL,
                  parameters: {'rId': 'resep[index].rId'},
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12),
                          child: resep[index].imageUrl != ''
                              ? Image.network(
                                  resep[index].imageUrl,
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.medium,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/no_image.jpg',
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.medium,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/images/no_image.jpg',
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.medium,
                                ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              resep[index].title,
                              style: AppTextStyle.body2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              resep[index].description,
                              style: AppTextStyle.body7,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            buildLike(resep[index].likes.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
