import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/utils/loading_page.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';
import 'package:seleraku/app/core/widgets/buttons/large_button.dart';
import 'package:seleraku/app/core/widgets/textfields/multi_field.dart';
import 'package:seleraku/app/core/widgets/texts/build_label.dart';

import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isPageLoading.value) {
        return Scaffold(body: loadingPage());
      }

      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Align(
                    alignment: AlignmentGeometry.topLeft,
                    child: ButtonCircle(
                      onTap: () => Get.back(),
                      icon: Icons.arrow_back,
                      left: 12,
                    ),
                  ),
                  Center(
                    child: Text('Kritik & Saran', style: AppTextStyle.heading2),
                  ),
                  const SizedBox(height: 24),
                  // buildLabel('Saran'),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsetsGeometry.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLabel('Pesan'),
                        BuildMultiField(
                          hintText: 'ketik pesan',
                          controller: controller.msg,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Masukkan pesan";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        buildLargeButton(
                          label: 'Kirim',
                          onTap: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.callSendReport(
                                controller.uId,
                                controller.msg.text,
                              );
                              null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
