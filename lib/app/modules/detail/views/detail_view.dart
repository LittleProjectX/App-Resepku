import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/utils/loading_page.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';
import 'package:seleraku/app/routes/app_pages.dart';
import './widgets/detail_recipe_label.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Obx(() {
      final c = Get.find<DetailController>();
      if (c.isLoading.value = true) {
        loadingPage();
      }
      final resep = c.dataResep.value;
      final author = c.dataAuthor.value;

      if (resep == null || author == null) {
        return Scaffold(
          body: Center(
            child: Text('Tidak ada data', style: AppTextStyle.body2),
          ),
        );
      }

      return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: height * 0.35,
                width: double.infinity,
                child: resep.imageUrl.isEmpty
                    ? Image.asset(
                        'assets/images/oblok.jpg',
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.medium,
                      )
                    : Image.network(
                        resep.imageUrl,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/no_image.jpg',
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.low,
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
              ),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          ButtonCircle(
                            onTap: () => Get.back(),
                            icon: Icons.arrow_back,
                          ),
                          const Spacer(),
                          Obx(
                            () => ButtonCircle(
                              onTap: () => c.isResepSave.value
                                  ? c.fetchUnsaveResep(
                                      c.saveId,
                                      c.rId,
                                      resep.saves,
                                    )
                                  : c.fetchSaveResep(
                                      c.uId,
                                      c.rId,
                                      resep.saves + 1,
                                    ),
                              icon: c.isResepSave.value
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline,
                              color: c.isResepSave.value
                                  ? AppColors.warning
                                  : AppColors.textPrimary,
                            ),
                          ),
                          Obx(
                            () => ButtonCircle(
                              onTap: () {
                                final List<String> receiverId = [];
                                receiverId.add(author.uId);
                                c.isResepLike.value
                                    ? c.fetchUnLikeResep(
                                        c.uId,
                                        c.likeId,
                                        c.rId,
                                        resep.likes,
                                      )
                                    : c.fetchLikeResep(
                                        c.uId,
                                        c.rId,
                                        resep.likes + 1,
                                        receiverId,
                                        resep.imageUrl,
                                        'Suka',
                                        'Seseorang menyukai resep anda',
                                      );
                              },
                              icon: c.isResepLike.value
                                  ? Iconsax.heart
                                  : Iconsax.heart_copy,
                              color: c.isResepLike.value
                                  ? AppColors.delete
                                  : AppColors.textPrimary,
                              left: 16,
                            ),
                          ),
                          const SizedBox(width: 32),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.2),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(resep.title, style: AppTextStyle.heading8),
                          Text(resep.category, style: AppTextStyle.body7),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.ramen_dining,
                                size: 12,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(resep.portion, style: AppTextStyle.body7),
                              const SizedBox(width: 8),
                              Text('|', style: AppTextStyle.body7),
                              const SizedBox(width: 8),
                              Icon(
                                Iconsax.heart,
                                size: 12,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                resep.likes.toString(),
                                style: AppTextStyle.body7,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          buildRecipeLabel('Deskripsi'),
                          Text(resep.description, style: AppTextStyle.body7),
                          const SizedBox(height: 16),
                          InkWell(
                            onTap: () => Get.toNamed(
                              Routes.AUTHOR,
                              parameters: {'uId': author.uId},
                            ),
                            child: Container(
                              height: 65,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(40),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: const Offset(4, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: author.imageUrl == null
                                        ? AssetImage(
                                            'assets/images/profile.jpg',
                                          )
                                        : NetworkImage(
                                            author.imageUrl.toString(),
                                          ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Penulis',
                                          style: AppTextStyle.body6,
                                        ),
                                        Text(
                                          author.name.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          style: AppTextStyle.body5,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Material(
                                      color: AppColors.surface,
                                      shape: CircleBorder(),
                                      child: Icon(Icons.arrow_right),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          buildRecipeLabel('Bahan Utama'),
                          const SizedBox(height: 4),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: resep.mainIngredient.length,
                            itemBuilder: (context, index) {
                              final ingredientFilter = resep.mainIngredient
                                  .toList();
                              ingredientFilter.sort(
                                (a, b) => a.createdAt.compareTo(b.createdAt),
                              );
                              final mainIngredient = ingredientFilter[index];

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: Text(
                                  '${index + 1}. ${mainIngredient.ingredient} ${mainIngredient.amount}',
                                  style: AppTextStyle.body3,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          if (resep.additive.isNotEmpty)
                            buildRecipeLabel('Bahan Tambahan'),
                          const SizedBox(height: 4),
                          if (resep.additive.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: resep.additive.length,
                              itemBuilder: (context, index) {
                                final additiveFilter = resep.additive.toList();
                                additiveFilter.sort(
                                  (a, b) => a.createdAt.compareTo(b.createdAt),
                                );
                                final additive = additiveFilter[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: Text(
                                    '${index + 1}. ${additive.ingredient} ${additive.amount}',
                                    style: AppTextStyle.body3,
                                  ),
                                );
                              },
                            ),
                          const SizedBox(height: 16),
                          buildRecipeLabel('Cara Pembuatan'),
                          const SizedBox(height: 4),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: resep.tutorial.length,
                            itemBuilder: (context, index) {
                              final tutorialFilter = resep.tutorial.toList();
                              tutorialFilter.sort(
                                (a, b) => a.createdAt.compareTo(b.createdAt),
                              );
                              final tutorial = tutorialFilter[index];

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: Text(
                                  '${index + 1}. ${tutorial.tutorial}',
                                  style: AppTextStyle.body3,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
