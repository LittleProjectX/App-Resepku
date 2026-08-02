import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                buttonCircle(
                  onTap: () => Get.back(),
                  icon: Icons.arrow_back,
                  left: 24,
                ),
                const SizedBox(width: 12),
                Text('Tentang Aplikasi', style: AppTextStyle.heading5),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.surface,
              ),
              child: Text(
                '''SELERAKU adalah aplikasi yang dibuat oleh tim pengembang LITTLE PROJEXT yang menyediakan berbagai kumpulan resep masakan, mulai dari makanan, kue, minuman, hingga berbagai hidangan lainnya. Aplikasi ini dirancang untuk membantu pengguna menemukan inspirasi memasak dengan mudah melalui koleksi resep yang lengkap dan mudah dipahami.

Selain membaca resep yang tersedia, pengguna juga dapat berkontribusi dengan menambahkan resep baru ke dalam aplikasi. Dengan demikian, SELERAKU menjadi wadah berbagi inspirasi dan pengalaman memasak bagi seluruh pengguna.

Mari temukan resep favorit Anda, coba berbagai hidangan baru, dan bagikan kreasi terbaik Anda bersama komunitas SELERAKU.
''',
                style: AppTextStyle.body3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
