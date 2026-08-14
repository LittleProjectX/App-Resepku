import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/send_report_usecase.dart';
import 'package:seleraku/app/routes/app_pages.dart';

class ReportController extends GetxController {
  final GetCurrentUidUsecase getUid;
  final SendReportUsecase sendReport;
  ReportController(this.getUid, this.sendReport);

  late TextEditingController msg;
  late String uId = '';
  RxBool isPageLoading = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    msg = TextEditingController();
    fetchUid();
  }

  @override
  void dispose() {
    msg.dispose();
    super.dispose();
  }

  void fetchUid() {
    try {
      isPageLoading.value = true;
      uId = getUid();
    } catch (e) {
      SnackBarHelper.error('Terjadi Kesalahan : $e');
    } finally {
      isPageLoading.value = false;
    }
  }

  Future<void> callSendReport(String uId, String report) async {
    try {
      isLoading.value = true;
      if (report.trim().isEmpty) {
        SnackBarHelper.warning('Harap mengisi pesan');
        return;
      }

      Timestamp createdAt = Timestamp.now();
      sendReport.call(uId, report, createdAt);
      SnackBarHelper.success('Berhasil mengirim pesan');
      Get.offAllNamed(Routes.MAIN);
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan : $e');
    } finally {
      isLoading.value = false;
    }
  }
}
