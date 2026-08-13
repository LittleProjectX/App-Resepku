import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/utils/loading_page.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';
import 'package:seleraku/app/core/widgets/texts/build_like.dart';
import 'package:seleraku/app/core/widgets/texts/eror_data.dart';
import 'package:seleraku/app/routes/app_pages.dart';

import '../controllers/author_controller.dart';

class AuthorView extends GetView<AuthorController> {
  const AuthorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return loadingPage();
      }
      final user = controller.userData.value;
      final resep = controller.listResep;

      if (user == null) {
        return errorData();
      }

      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 32,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      buttonCircle(
                        onTap: () => Get.back(),
                        icon: Icons.arrow_back,
                        left: 0,
                      ),
                      const Spacer(),

                      Obx(
                        () => buttonCircle(
                          onTap: () => controller.isAuthorLike.value
                              ? controller.fetchUnLikeAuthor(
                                  controller.afId,
                                  controller.aId,
                                  user.likes,
                                )
                              : controller.fetchLikeAuthor(
                                  controller.uId,
                                  controller.afId,
                                  user.likes + 1,
                                  user.imageUrl.toString(),
                                  'Suka',
                                  'Seseorang menyukai anda',
                                ),
                          icon: controller.isAuthorLike.value
                              ? Iconsax.heart
                              : Iconsax.heart_copy,
                          color: controller.isAuthorLike.value
                              ? AppColors.delete
                              : AppColors.textPrimary,
                          left: 0,
                        ),
                      ),
                    ],
                  ),
                  Center(child: Text('Penulis', style: AppTextStyle.heading2)),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: AppColors.surface,
                    ),

                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: user.imageUrl != null
                              ? NetworkImage(user.imageUrl.toString())
                              : AssetImage('assets/images/profile.jpg'),
                          radius: 65,
                        ),
                        const SizedBox(height: 16),
                        Text(user.name ?? '-', style: AppTextStyle.heading3),
                        const SizedBox(height: 8),
                        Text(user.email, style: AppTextStyle.body7),
                        const SizedBox(width: 4),
                        Text(user.phone ?? '-', style: AppTextStyle.body7),
                        const SizedBox(height: 8),
                        const SizedBox(width: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildLike(user.likes.toString()),
                            const SizedBox(width: 12),
                            Text('|', style: AppTextStyle.body7),
                            const SizedBox(width: 12),
                            Text(
                              '${resep.length} Resep',
                              style: AppTextStyle.body7,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ListView.builder(
                    itemCount: resep.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: InkWell(
                          onTap: () => Get.toNamed(
                            Routes.DETAIL,
                            parameters: {'rId': resep[index].rId},
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
                                    borderRadius: BorderRadiusGeometry.circular(
                                      12,
                                    ),
                                    child: resep[index].imageUrl != ''
                                        ? Image.network(
                                            resep[index].imageUrl,
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.medium,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Image.asset(
                                                    'assets/images/no_image.jpg',
                                                    fit: BoxFit.cover,
                                                    filterQuality:
                                                        FilterQuality.medium,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
