import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/routes/app_pages.dart';
import '../controllers/started_controller.dart';

class StartedView extends GetView<StartedController> {
  const StartedView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: double.infinity,
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.3,
                    width: double.infinity,
                    child: Image.asset('assets/images/chef.png'),
                  ),
                  const SizedBox(height: 24),
                  Text('Selamat Datang di', style: AppTextStyle.heading8),
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/icons/seleraku_teks.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aplikasi aneka resep makanan nusantara dan internasional untuk menemani kegiatanmu di dapur.',
                    style: AppTextStyle.body1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: height * 0.09),
                  SizedBox(
                    width: width * 0.6,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentGeometry.center,
                            child: Text('Mulai', style: AppTextStyle.button1),
                          ),
                          Align(
                            alignment: AlignmentGeometry.centerRight,
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: Material(
                                shape: CircleBorder(),
                                color: AppColors.surface,
                                child: Icon(
                                  Iconsax.arrow_right_1_copy,
                                  color: AppColors.primary,
                                  weight: 4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
