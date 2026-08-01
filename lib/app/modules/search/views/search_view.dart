import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/widgets/textfields/search_field.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchControllers> {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            children: [
              buildSearchField(
                label: 'cari buku',
                ctrl: controller.search,
                focusNode: controller.currenctFocus,
                onClear: controller.clearSearch,
                onChange: (value) {
                  if (value.isEmpty) {
                    Get.back();
                  }
                },
                autoFocus: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
