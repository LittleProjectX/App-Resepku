import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchControllers extends GetxController {
  late TextEditingController search;
  FocusNode currenctFocus = FocusNode();

  @override
  void onInit() {
    super.onInit();
    search = TextEditingController();
    search.text = Get.parameters['value'] ?? '';
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  void clearSearch() {
    search.clear();
    Get.back();
  }
}
