import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/utils/snacbar_helper.dart';
import 'package:seleraku/app/domain/models/data_resep_model.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/search_resep_usecase.dart';

class SearchControllers extends GetxController {
  final SearchResepUsecase searchResep;
  SearchControllers(this.searchResep);

  late TextEditingController search;
  var listResep = <DataResepModel>[].obs;
  FocusNode currenctFocus = FocusNode();
  late StreamSubscription<List<QueryDocumentSnapshot>>? _searchSubscription;

  @override
  void onInit() {
    super.onInit();
    search = TextEditingController();
    search.text = Get.parameters['value'] ?? '';
  }

  @override
  void onClose() {
    _searchSubscription?.cancel();
    super.onClose();
  }

  void clearSearch() {
    search.clear();
    Get.back();
  }

  void fetchSearchResep(String title) {
    try {
      final dataResep = searchResep.call(title);
      print("Search: $title");
      _searchSubscription = dataResep.listen(
        (snapshot) {
          listResep.value = snapshot.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return DataResepModel.fromFirebase(data);
          }).toList();
        },
        onError: (e) {
          SnackBarHelper.warning('Terjadi kesalahan ($e)');
        },
      );
    } catch (e) {
      SnackBarHelper.error('Gagal mengambil data resep ($e)');
    }
  }
}
