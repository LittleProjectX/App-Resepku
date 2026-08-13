import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/domain/models/data_ingredient_model.dart';
import 'package:seleraku/app/domain/models/data_tutorial_model.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_resep_byid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/update_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/upload_image_usecase.dart';
import 'package:seleraku/app/routes/app_pages.dart';

class UpdateResepController extends GetxController {
  final UploadImageUsecase uploadImage;
  final UpdateResepUsecase updateResep;
  final GetResepByidUsecase getResepbyId;
  UpdateResepController(this.uploadImage, this.updateResep, this.getResepbyId);

  late TextEditingController title;
  late TextEditingController description;
  late TextEditingController portion;
  late TextEditingController mainIngredient;
  late TextEditingController mainIngredientAmount;
  late TextEditingController additive;
  late TextEditingController additiveAmount;
  late TextEditingController tutorial;

  RxBool pageLoading = false.obs;
  RxBool isLoading = false.obs;
  RxBool isNewImage = false.obs;
  RxBool isMainIng = false.obs;
  RxBool isAddittive = false.obs;
  RxBool isTutorial = false.obs;

  late int mainIndex = 0;
  late int additiveIndex = 0;
  late int tutorialIndex = 0;

  late Timestamp mainTime = Timestamp.now();
  late Timestamp additiveTime = Timestamp.now();
  late Timestamp tutorialTime = Timestamp.now();

  Rx<File?> selectedFile = Rx<File?>(null);
  late String rId = '';
  late String longestImage = '';
  RxString category = 'Makanan Utama'.obs;
  final listMainIngredient = <DataIngredientModel>[].obs;
  final listAdditiveIngredient = <DataIngredientModel>[].obs;
  final listTutorial = <DataTutorialModel>[].obs;
  var resepData = Rxn<DataResepEntity>();

  @override
  void onInit() {
    super.onInit();
    title = TextEditingController();
    description = TextEditingController();
    portion = TextEditingController();
    mainIngredient = TextEditingController();
    mainIngredientAmount = TextEditingController();
    additive = TextEditingController();
    additiveAmount = TextEditingController();
    tutorial = TextEditingController();
    rId = Get.parameters['rId'].toString();
    fetchResep(rId);
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    portion.dispose();
    mainIngredient.dispose();
    mainIngredientAmount.dispose();
    additive.dispose();
    additiveAmount.dispose();
    tutorial.dispose();
    super.dispose();
  }

  void clearField() {
    selectedFile.value = null;
    title.clear();
    description.clear();
    portion.clear();
    mainIngredient.clear();
    mainIngredientAmount.clear();
    additive.clear();
    additiveAmount.clear();
    tutorial.clear();
    Get.back();
  }

  void clearTutorial() {
    tutorial.clear();
  }

  void clearAdditive() {
    additive.clear();
    additiveAmount.clear();
  }

  void clearMainIngredient() {
    mainIngredient.clear();
    mainIngredientAmount.clear();
  }

  void updateMainIngredient(
    int index,
    String mainIngridient,
    String amount,
    Timestamp createdAt,
  ) {
    listMainIngredient[index] = DataIngredientModel(
      ingredient: mainIngridient,
      amount: amount,
      createdAt: createdAt,
    );
    clearMainIngredient();
  }

  void updateAdditive(
    int index,
    String additive,
    String amount,
    Timestamp createdAt,
  ) {
    listAdditiveIngredient[index] = DataIngredientModel(
      ingredient: additive,
      amount: amount,
      createdAt: createdAt,
    );
    clearAdditive();
  }

  void updateTutorial(int index, String tutorial, Timestamp createdAt) {
    listTutorial[index] = DataTutorialModel(
      tutorial: tutorial,
      createdAt: createdAt,
    );
    clearTutorial();
  }

  Future<void> fetchResep(String rId) async {
    try {
      pageLoading.value = true;

      final result = await getResepbyId(rId);
      resepData.value = result;

      longestImage = result.imageUrl;
      title.text = result.title;
      category.value = result.category;
      portion.text = result.portion;
      description.text = result.description;
      listMainIngredient.value = result.mainIngredient;
      listAdditiveIngredient.value = result.additive;
      listTutorial.value = result.tutorial;
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan: $e');
    } finally {
      pageLoading.value = false;
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
        isNewImage.value = true;
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
        quality: 70,
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

  Future<void> updateReseptoFirebase(
    String uId,
    String rId,
    String title,
    String description,
    String category,
    String portion,
    List<DataIngredientModel> mainIngredient,
    List<DataIngredientModel> additive,
    List<DataTutorialModel> tutorial,
    List<String> receiverIds,
  ) async {
    try {
      isLoading.value = true;
      if (title.trim().isEmpty ||
          category.trim().isEmpty ||
          portion.trim().isEmpty ||
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
      final Timestamp createdAt = Timestamp.now();

      await updateResep.call(
        rId,
        title,
        description,
        portion,
        category,
        imageUrl,
        mainIngredient,
        additive,
        tutorial,
        createdAt,
      );

      SnackBarHelper.success('Berhasil menyimpan resep');
      clearField();
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
        createdAt: Timestamp.now(),
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
        createdAt: Timestamp.now(),
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
      DataTutorialModel(tutorial: tutorialText, createdAt: Timestamp.now()),
    );
    tutorial.clear();
  }

  void removeTutorial(int index) {
    listTutorial.removeAt(index);
  }
}
