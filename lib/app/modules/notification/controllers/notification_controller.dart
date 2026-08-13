import 'package:get/get.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/domain/models/data_notification_model.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_my_notification_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/read_notification_usecase.dart';

class NotificationController extends GetxController {
  final GetCurrentUidUsecase getUid;
  final GetMyNotificationUsecase getMyNotification;
  final ReadNotificationUsecase readNotification;
  NotificationController(
    this.getUid,
    this.getMyNotification,
    this.readNotification,
  );
  var listNotification = <DataNotificationModel>[].obs;
  late String uId = '';

  @override
  void onInit() {
    super.onInit();
    uId = getUid();
    fetchGetMyNotification(uId);
  }

  Future<void> fetchGetMyNotification(String uId) async {
    try {
      final dataNotification = await getMyNotification(uId);
      listNotification.value = dataNotification.map((e) {
        final data = e.data() as Map<String, dynamic>;
        return DataNotificationModel.fromFirebase(data);
      }).toList();
    } catch (e) {
      SnackBarHelper.error('Gagal mendapatkan data ($e)');
    }
  }

  void fetchReadNotification(String uId, String notifId) {
    try {
      final isRead = true;
      readNotification(uId, notifId, isRead);
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan ($e)');
    }
  }
}
