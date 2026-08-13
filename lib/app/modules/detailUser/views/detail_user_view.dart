import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/widgets/texts/eror_data.dart';
import 'package:seleraku/app/core/utils/loading_page.dart';
import 'package:seleraku/app/core/widgets/global_widgets/build_list_resep.dart';
import 'package:seleraku/app/core/widgets/texts/build_like.dart';
import 'package:seleraku/app/routes/app_pages.dart';
import '../controllers/detail_user_controller.dart';

class DetailUserView extends GetView<DetailUserController> {
  const DetailUserView({super.key});
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
      return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                const SizedBox(height: 32),
                Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: SizedBox(
                    width: 160,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (user.name != null || user.name != '') {
                          Get.toNamed(
                            Routes.ADD_RESEP,
                            parameters: {'author': user.name ?? ''},
                          );
                        } else {
                          SnackBarHelper.info(
                            'Lengkapi profil anda untuk dapat menambah resep',
                          );
                        }
                      },
                      child: Text('Tambah Resep', style: AppTextStyle.body5),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                resep.isEmpty
                    ? errorData(text: 'Tidak ada data')
                    : ListView.builder(
                        itemCount: resep.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: buildListResep(
                              () => Get.toNamed(
                                Routes.UPDATE_RESEP,
                                parameters: {'rId': resep[index].rId},
                              ),
                              resep[index].imageUrl,
                              resep[index].title,
                              resep[index].likes,
                              resep[index].description,
                              () {
                                controller.fetchDeleteResep(resep[index].rId);
                              },
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
