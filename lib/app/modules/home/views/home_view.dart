import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/constants/recipe_category.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/utils/loading_page.dart';
import 'package:seleraku/app/core/widgets/buttons/build_button_all.dart';
import 'package:seleraku/app/core/widgets/global_widgets/build_resep.dart';
import 'package:seleraku/app/core/widgets/texts/build_label_2.dart';
import './widgets/build_popular_card.dart';
import 'package:seleraku/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isPageLoading.value == true) {
        return loadingPage();
      }

      final user = controller.user;
      if (user.value == null) {
        return Center(child: Text('Tidak Ada data', style: AppTextStyle.body2));
      }

      final allNotificaion = controller.listNotification;
      final filterNotification = allNotificaion
          .where((notif) => notif.isRead == false)
          .toList();

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 32,
                        backgroundImage:
                            user.value?.imageUrl?.isNotEmpty == true
                            ? NetworkImage(user.value!.imageUrl!)
                            : const AssetImage('assets/images/profile.jpg'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Selamat datang', style: AppTextStyle.body7),
                          Obx(
                            () => Text(
                              user.value?.name ?? '',
                              style: AppTextStyle.heading5,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 46,
                      height: 46,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Material(
                            color: AppColors.surface,
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () => Get.toNamed(Routes.NOTIFICATION),
                              child: const SizedBox(
                                width: 46,
                                height: 46,
                                child: Icon(
                                  Iconsax.notification_bing_copy,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),

                          if (filterNotification.isNotEmpty)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${filterNotification.length}',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.body6,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Hero(
                  tag: 'search-field',
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Get.toNamed(Routes.SEARCH),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: AppColors.border),
                            const SizedBox(width: 4),
                            Text('cari resep..', style: AppTextStyle.body1),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Obx(() {
                  if (controller.listResep.isNotEmpty) {
                    final bestResep = controller.listResep.toList();
                    bestResep.sort((a, b) => b.likes.compareTo(a.likes));
                    final popularResep = bestResep.first;
                    return BuildPopularCard(
                      title: popularResep.title,
                      author: popularResep.author,
                      imageUrl: popularResep.imageUrl,
                      onTap: () => Get.toNamed(
                        Routes.DETAIL,
                        parameters: {'rId': popularResep.rId},
                      ),
                    );
                  }
                  return SizedBox();
                }),
                const SizedBox(height: 24),
                SizedBox(
                  height: 48,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: allCategory.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => InkWell(
                          onTap: () {
                            controller.currentCategory.value =
                                allCategory[index];
                          },
                          child: Container(
                            height: 48,
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  controller.currentCategory.value ==
                                      allCategory[index]
                                  ? AppColors.primary
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                allCategory[index],
                                style:
                                    controller.currentCategory.value ==
                                        allCategory[index]
                                    ? AppTextStyle.body5
                                    : AppTextStyle.body3,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),

                Obx(
                  () => controller.listResep.isEmpty
                      ? Center(
                          child: Text(
                            'Tidak ada data',
                            style: AppTextStyle.body2,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => buildLabel2(
                                    controller.currentCategory.value,
                                  ),
                                ),
                                BuildButtonAll(
                                  onTap: () => Get.toNamed(
                                    Routes.ALL_RESEP,
                                    parameters: {
                                      'category':
                                          controller.currentCategory.value,
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 160,
                              child: Obx(() {
                                var allResep = controller.listResep;

                                var filterResep = allResep.where((resep) {
                                  if (controller.currentCategory.value ==
                                      'Semua') {
                                    return true;
                                  } else {
                                    return resep.category ==
                                        controller.currentCategory.value;
                                  }
                                }).toList();

                                if (filterResep.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'Tidak ada data',
                                      style: AppTextStyle.body3,
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  itemCount:
                                      controller.currentCategory.value ==
                                          'Semua'
                                      ? allResep.length > 6
                                            ? 6
                                            : allResep.length
                                      : filterResep.length > 6
                                      ? 6
                                      : filterResep.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var lenData =
                                        controller.currentCategory.value ==
                                            'Semua'
                                        ? allResep.length
                                        : filterResep.length;

                                    var dataResep =
                                        controller.currentCategory.value ==
                                            'Semua'
                                        ? allResep[index]
                                        : filterResep[index];

                                    if (index == lenData) {
                                      return GestureDetector(
                                        onTap: () {
                                          null;
                                        },
                                        child: Container(
                                          width: 100,
                                          margin: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text("Semua"),
                                          ),
                                        ),
                                      );
                                    }
                                    return BuildResep(
                                      imageUrl: dataResep.imageUrl,
                                      title: dataResep.title,
                                      portion: dataResep.portion,
                                      likes: dataResep.likes,
                                      onTap: () => Get.toNamed(
                                        Routes.DETAIL,
                                        parameters: {'rId': dataResep.rId},
                                      ),
                                    );
                                  },
                                );
                              }),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildLabel2('Teratas'),
                                BuildButtonAll(
                                  onTap: () => Get.toNamed(
                                    Routes.ALL_POPULAR,
                                    parameters: {'type': 'Teratas'},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 160,
                              child: ListView.builder(
                                itemCount: controller.listResep.length < 6
                                    ? controller.listResep.length
                                    : 6,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final bestResep = controller.listResep
                                      .toList();
                                  bestResep.sort(
                                    (a, b) => b.likes.compareTo(a.likes),
                                  );

                                  return BuildResep(
                                    imageUrl: bestResep[index].imageUrl,
                                    title: bestResep[index].title,
                                    portion: bestResep[index].portion,
                                    likes: bestResep[index].likes,
                                    onTap: () => Get.toNamed(
                                      Routes.DETAIL,
                                      parameters: {'rId': bestResep[index].rId},
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildLabel2('Pembuat'),
                                BuildButtonAll(
                                  onTap: () => Get.toNamed(Routes.ALL_USER),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            Obx(() {
                              final allUser = controller.listFilterUser
                                  .toList();
                              allUser.sort(
                                (a, b) => b.likes.compareTo(a.likes),
                              );

                              return allUser.isNotEmpty
                                  ? SizedBox(
                                      height: 160,
                                      child: ListView.builder(
                                        itemCount: allUser.length,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () => Get.toNamed(
                                              Routes.AUTHOR,
                                              parameters: {
                                                'uId': allUser[index].uId,
                                              },
                                            ),
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                right: 12,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 8,
                                              ),
                                              height: 160,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                color: AppColors.surface,
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  allUser[index].imageUrl !=
                                                              null ||
                                                          allUser[index]
                                                                  .imageUrl ==
                                                              ''
                                                      ? CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                allUser[index]
                                                                    .imageUrl
                                                                    .toString(),
                                                              ),
                                                          radius: 44,
                                                        )
                                                      : CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                                'assets/images/profile.jpg',
                                                              ),
                                                          radius: 44,
                                                        ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    allUser[index].name
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyle.body8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Iconsax.heart,
                                                        color: AppColors
                                                            .textSecondary,
                                                        size: 12,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        allUser[index].likes
                                                            .toString(),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            AppTextStyle.body7,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'Tidak ada data',
                                        style: AppTextStyle.body3,
                                      ),
                                    );
                            }),
                            const SizedBox(height: 16),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildLabel2('Terbaru'),
                                BuildButtonAll(
                                  onTap: () => Get.toNamed(
                                    Routes.ALL_POPULAR,
                                    parameters: {'type': 'Terbaru'},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 160,
                              child: ListView.builder(
                                itemCount: controller.listResep.length > 6
                                    ? 6
                                    : controller.listResep.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Obx(() {
                                    var filterNewResep = controller.listResep
                                        .toList();
                                    filterNewResep.sort(
                                      (a, b) =>
                                          b.createdAt.compareTo(a.createdAt),
                                    );
                                    return BuildResep(
                                      imageUrl: filterNewResep[index].imageUrl,
                                      title: filterNewResep[index].title,
                                      portion: filterNewResep[index].portion,
                                      likes: filterNewResep[index].likes,
                                      onTap: () => Get.toNamed(
                                        Routes.DETAIL,
                                        parameters: {
                                          'rId': filterNewResep[index].rId,
                                        },
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),
                          ],
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
