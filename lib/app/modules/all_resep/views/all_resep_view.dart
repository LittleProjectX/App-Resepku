import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
                  ),
                  itemBuilder: (context, index) {
                    final resep = filterResep[index];

                    return BuildResep(
                      imageUrl: resep.imageUrl,
                      title: resep.title,
                      portion: resep.portion,
                      likes: resep.likes,
                      onTap: () => Get.toNamed(
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
