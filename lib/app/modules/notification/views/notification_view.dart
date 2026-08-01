import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';
import 'package:seleraku/app/routes/app_pages.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.listNotification.isEmpty) {
        return Scaffold(
          body: Center(
            child: Text('Tidak ada notifikasi', style: AppTextStyle.body3),
          ),
        );
      }

      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 8),
                  child: Row(
                    children: [
                      buttonCircle(
                        onTap: () => Get.back(),
                        icon: Icons.arrow_back,
                      ),
                      const SizedBox(width: 12),
                      Text('Notifikasi', style: AppTextStyle.heading5),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  itemCount: controller.listNotification.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final notification = controller.listNotification[index];
                    bool isNotifRead = notification.isRead;

                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: SizedBox(
                        width: 60,
                        height: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(8),
                          child:
                              notification.imageUrl == '' ||
                                  notification.imageUrl.isEmpty
                              ? Image.asset(
                                  'assets/images/no_image.jpg',
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  notification.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      tileColor: isNotifRead
                          ? AppColors.background
                          : AppColors.primaryLight,
                      title: Text(
                        notification.title,
                        style: AppTextStyle.label1,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                      subtitle: Text(
                        notification.msg,
                        style: AppTextStyle.body7,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                      onTap: () {
                        controller.fetchReadNotification(
                          controller.uId,
                          notification.docId,
                        );
                        isNotifRead = true;
                        Get.toNamed(
                          Routes.AUTHOR,
                          parameters: {'uId': notification.senderId},
                        );
                      },
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
