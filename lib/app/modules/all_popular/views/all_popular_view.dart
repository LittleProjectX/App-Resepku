import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/utils/loading_page.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';
import 'package:seleraku/app/core/widgets/global_widgets/build_resep.dart';
import 'package:seleraku/app/routes/app_pages.dart';

import '../controllers/all_popular_controller.dart';

class AllPopularView extends GetView<AllPopularController> {
  const AllPopularView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isPageLoading.value) {
        return Scaffold(body: loadingPage());
      }
      final popularFilter = controller.listAllResep;
      popularFilter.sort((a, b) => b.likes.compareTo(a.likes));
      final terbaruFilter = controller.listAllResep;
      terbaruFilter.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final allResep = controller.type.value == 'Teratas'
          ? popularFilter
          : terbaruFilter;

      if (allResep.isEmpty) {
        return SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: buttonCircle(
                  onTap: () => Get.back(),
                  icon: Icons.arrow_back,
                ),
              ),
              Center(
                child: Text(
                  controller.type.value,
                  style: AppTextStyle.heading2,
                ),
              ),
              const SizedBox(height: 24),
              Center(child: Text('Tidak ada data', style: AppTextStyle.body3)),
            ],
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
                  child: buttonCircle(
                    onTap: () => Get.back(),
                    icon: Icons.arrow_back,
                  ),
                ),
                Center(
                  child: Text(
                    controller.type.value,
                    style: AppTextStyle.heading2,
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  itemCount: allResep.length > 20 ? 20 : allResep.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final resep = allResep[index];
                    return buildResep(
                      resep.imageUrl,
                      resep.title,
                      resep.portion,
                      resep.likes,
                      () => Get.toNamed(
                        Routes.DETAIL,
                        parameters: {'rId': resep.rId},
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
