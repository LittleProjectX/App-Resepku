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
              const SizedBox(width: 24),
              Center(child: Text('Tentang', style: AppTextStyle.heading2)),
              Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.surface,
                ),
                child: Column(
                  children: [
                    Text(
                      '''SELERAKU adalah aplikasi yang dibuat oleh tim pengembang LITTLE PROJEXT yang menyediakan berbagai kumpulan resep masakan, mulai dari makanan, kue, minuman, hingga berbagai hidangan lainnya. Aplikasi ini dirancang untuk membantu pengguna menemukan inspirasi memasak dengan mudah melalui koleksi resep yang lengkap dan mudah dipahami.

Selain membaca resep yang tersedia, pengguna juga dapat berkontribusi dengan menambahkan resep baru ke dalam aplikasi. Dengan demikian, SELERAKU menjadi wadah berbagi inspirasi dan pengalaman memasak bagi seluruh pengguna.

Mari temukan resep favorit Anda, coba berbagai hidangan baru, dan bagikan kreasi terbaik Anda bersama komunitas SELERAKU.
''',
                      style: AppTextStyle.body3,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 160,
                      width: 160,
                      child: Image.asset(
                        'assets/images/qr_dna.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('Traktir secangkir Kopi', style: AppTextStyle.body3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
