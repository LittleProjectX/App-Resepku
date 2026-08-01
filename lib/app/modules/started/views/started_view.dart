import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/routes/app_pages.dart';
import '../controllers/started_controller.dart';

class StartedView extends GetView<StartedController> {
  const StartedView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.4,
                width: double.infinity,
                child: Image.asset('assets/images/chef.png'),
              ),
              const SizedBox(height: 24),
              Text('Selamat Datang di', style: AppTextStyle.heading1),
              Text('SELERAKU', style: AppTextStyle.heading1Primary),
              const SizedBox(height: 8),
              Text(
                'Aplikasi daftar resep makanan nusantara dan internasional untuk menemani kegiatanmu di dapur.',
                style: AppTextStyle.body1,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Mulai', style: AppTextStyle.button1),
                      const SizedBox(width: 4),
                      Icon(Iconsax.arrow_right_1_copy),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
