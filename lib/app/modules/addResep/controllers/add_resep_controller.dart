import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/domain/models/data_author_favorite_model.dart';
import 'package:seleraku/app/domain/models/data_ingredient_model.dart';
import 'package:seleraku/app/domain/models/data_tutorial_model.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_liked_author_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/save_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/send_notification_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/upload_image_usecase.dart';
import 'package:seleraku/app/routes/app_pages.dart';

class AddResepController extends GetxController {
  final GetCurrentUidUsecase getUid;
  final UploadImageUsecase uploadImage;
  final SaveResepUsecase saveResep;
  final GetLikedAuthorUsecase getLikedAuthor;
  final SendNotificationUsecase sendNotification;
  AddResepController(
    this.uploadImage,
    this.saveResep,
    this.getUid,
    this.getLikedAuthor,
    this.sendNotification,
  );

  late TextEditingController title;
  late TextEditingController description;
  late TextEditingController mainIngredient;
  late TextEditingController mainIngredientAmount;
  late TextEditingController additive;
  late TextEditingController additiveAmount;
  late TextEditingController tutorial;

  Rx<File?> selectedFile = Rx<File?>(null);
  RxBool isLoading = false.obs;
  late String uId = '';
  late String author = '';
  RxInt intPortion = 1.obs;
  RxString category = 'Makanan Utama'.obs;
  final listMainIngredient = <DataIngredientModel>[].obs;
  final listAdditiveIngredient = <DataIngredientModel>[].obs;
  final listTutorial = <DataTutorialModel>[].obs;
  var listLikedAuthor = <DataAuthorFavoriteModel>[].obs;
  late List<String> receiverId = [];
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    title = TextEditingController();
    description = TextEditingController();
    mainIngredient = TextEditingController();
    mainIngredientAmount = TextEditingController();
    additive = TextEditingController();
    additiveAmount = TextEditingController();
    tutorial = TextEditingController();
    uId = getUid();
    author = Get.parameters['author'] ?? '';
    fetchGetLikedAuthor(uId);
  }

  @override
  void onClose() {
    title.dispose();
    description.dispose();
    mainIngredient.dispose();
    mainIngredientAmount.dispose();
    additive.dispose();
    additiveAmount.dispose();
    tutorial.dispose();
    super.onClose();
  }

  void clearField() {
    selectedFile.value = null;
    title.clear();
    description.clear();
    mainIngredient.clear();
    mainIngredientAmount.clear();
    additive.clear();
    additiveAmount.clear();
    tutorial.clear();
    intPortion.value = 1;
    Get.back();
  }

  Future<void> fetchGetLikedAuthor(String afId) async {
    try {
      final allAuthor = await getLikedAuthor(afId);
      listLikedAuthor.value = allAuthor.map((e) {
        return DataAuthorFavoriteModel.fromFirebase(e);
      }).toList();
      receiverId = listLikedAuthor.map((element) {
        final id = element.uId;
        return id;
      }).toList();
    } catch (e) {
      SnackBarHelper.warning('Gagal mengambil data ($e)');
    }
  }

  Future<bool> requestGalleryPermission() async {
    Permission permission;

    if (Platform.isAndroid) {
      permission = Permission.photos;
    } else {
      permission = Permission.photos;
    }

    final status = await permission.request();
    return status.isGranted;
  }

  Future<void> pickImage() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        selectedFile.value = File(result.files.single.path!);
      }
    } catch (e) {
      Get.snackbar('File Picker Error', e.toString());
    }
  }

  Future<File?> compressImage(File file) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final targetPath = path.join(
        tempDir.path,
        'compressed_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      final compressed = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 70, // 60–70 ideal untuk foto profil
        minWidth: 1080,
        minHeight: 1080,
        format: CompressFormat.jpeg,
      );

      return compressed != null ? File(compressed.path) : null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> uploadToFirebaseStorage(File? image, String docId) async {
    try {
      final imageUrl = await uploadImage.call(image, docId);
      return imageUrl;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveReseptoFirebase(
    String uId,
    String author,
    String title,
    String description,
    String category,
    String portion,
    List<DataIngredientModel> mainIngredient,
    List<DataIngredientModel> additive,
    List<DataTutorialModel> tutorial,
    List<String> receiverIds,
    String titleMsg,
    String msg,
  ) async {
    try {
      isLoading.value = true;
      if (title.trim().isEmpty ||
          category.trim().isEmpty ||
          description.trim().isEmpty ||
          mainIngredient.isEmpty ||
          tutorial.isEmpty) {
        SnackBarHelper.warning('Mohon untuk tidak mengosongkan field');
        return;
      }

      // 🔥 compress dulu
      final compressedFile = await compressImage(selectedFile.value!);
      if (compressedFile == null) {
        Get.snackbar('Error', 'Gagal mengompres gambar');
        return;
      }

      // 🚀 upload
      final imageUrl = await uploadToFirebaseStorage(compressedFile, uId);

      if (imageUrl == null) {
        Get.snackbar('Upload gagal', 'Tidak dapat mengupload gambar');
        return;
      }

      // 💾 simpan ke firestore
      final int likes = 0;
      final int saves = 0;
      final DateTime createdAt = DateTime.now();
      final bool isRead = false;

      await saveResep.call(
        uId,
        author,
        title,
        description,
        category,
        imageUrl,
        portion,
        mainIngredient,
        additive,
        tutorial,
        likes,
        saves,
        createdAt,
      );
      if (listLikedAuthor.isNotEmpty) {
        sendNotification.call(
          uId,
          receiverIds,
          imageUrl,
          titleMsg,
          msg,
          isRead,
          createdAt,
        );
      }
      SnackBarHelper.success('Berhasil menyimpan resep');

      Get.offAllNamed(Routes.MAIN);
    } catch (e) {
      SnackBarHelper.error('Gagal menyimpan resep ($e)');
    } finally {
      isLoading.value = false;
    }
  }

  void addMainIngredient(String ingredient, String amount) {
    if (ingredient.isEmpty || amount.isEmpty) {
      SnackBarHelper.warning('Bahan atau jumlah bahan belum diisi');
      return;
    }
    listMainIngredient.add(
      DataIngredientModel(
        ingredient: ingredient,
        amount: amount,
        createdAt: DateTime.now(),
      ),
    );
    mainIngredient.clear();
    mainIngredientAmount.clear();
  }

  void deleteListMainIngredient(int index) {
    listMainIngredient.removeAt(index);
  }

  void addAdditive(String additiveIngredient, String amount) {
    if (additiveIngredient.isEmpty || amount.isEmpty) {
      SnackBarHelper.warning('Bahan atau jumlah bahan belum diisi');
    }
    listAdditiveIngredient.add(
      DataIngredientModel(
        ingredient: additiveIngredient,
        amount: amount,
        createdAt: DateTime.now(),
      ),
    );
    additive.clear();
    additiveAmount.clear();
  }

  void deleteListAdditive(int index) {
    listAdditiveIngredient.removeAt(index);
  }

  void addTutorial(String tutorialText) {
    if (tutorialText.isEmpty) {
      SnackBarHelper.warning('Harap mengisi field tutorial');
    }
    listTutorial.add(
      DataTutorialModel(tutorial: tutorialText, createdAt: DateTime.now()),
    );
    tutorial.clear();
  }

  void removeTutorial(int index) {
    listTutorial.removeAt(index);
  }
}
