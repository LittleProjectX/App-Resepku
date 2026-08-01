import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

class UnknowPage extends StatelessWidget {
  const UnknowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset('assets/icons/unknow_page.png'),
              ),
              const SizedBox(height: 12),
              Text(
                'Halaman tidak diketahui, silahkan kembali ke halaman sebelumnya',
                textAlign: TextAlign.center,
                style: AppTextStyle.body1,
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  '<< Halaman sebelumnya',
                  style: AppTextStyle.button2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
