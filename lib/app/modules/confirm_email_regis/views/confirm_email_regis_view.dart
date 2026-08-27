import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/widgets/buttons/large_button.dart';
import 'package:seleraku/app/routes/app_pages.dart';

import '../controllers/confirm_email_regis_controller.dart';

class ConfirmEmailRegisView extends GetView<ConfirmEmailRegisController> {
  const ConfirmEmailRegisView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset('assets/images/email.png'),
              ),
              Text('Cek Email', style: AppTextStyle.heading2),
              Obx(
                () => Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Silahkan periksa Kotak Masuk/Spam\n email ',
                        style: AppTextStyle.body2,
                      ),
                      TextSpan(
                        text: controller.email.value,
                        style: AppTextStyle.textButton,
                      ),
                      TextSpan(
                        text: ' untuk mengubah password',
                        style: AppTextStyle.body2,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 32),
              buildLargeButton(
                label: 'Selesai',
                onTap: () => Get.offAllNamed(Routes.LOGIN),
              ),
              const SizedBox(height: 24),
              Text(
                'Belum menerima email? kirim ulang dalam',
                style: AppTextStyle.body2,
                textAlign: TextAlign.center,
              ),
              Obx(
                () => controller.isLoading.value
                    ? Text(controller.countdownText, style: AppTextStyle.body3)
                    : TextButton(
                        onPressed: () => controller.resendEmail(),
                        child: Text(
                          'Kirim Ulang',
                          style: AppTextStyle.textButton,
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
