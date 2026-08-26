import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/widgets/textfields/search_field.dart';
import 'package:seleraku/app/core/widgets/texts/build_like.dart';
import 'package:seleraku/app/routes/app_pages.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchControllers> {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final resep = controller.listResep;

      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              children: [
                Hero(
                  tag: 'search-field',
                  child: Material(
                    color: Colors.transparent,
                    child: BuildSearchField(
                      autoFocus: true,
                      label: 'cari resep..',
                      controller: controller.search,
                      focusNode: controller.currenctFocus,
                      onClear: () {
                        controller.clearSearch();
                        Get.back();
                      },
                      onChange: (value) {
                        if (value.isNotEmpty) {
                          controller.fetchSearchResep(value);
                        } else {
                          null;
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (controller.listResep.isEmpty)
                  Center(
                    child: Text(
                      'Tidak ada resep ditemukan',
                      style: AppTextStyle.body2,
                    ),
                  )
                else
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
                                        style: AppTextStyle.body6,
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
      );
    });
  }
}
