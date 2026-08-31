import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/save_imageurl_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/upload_image_usecase.dart';
import 'package:seleraku/app/routes/app_pages.dart';

class LoadImageController extends GetxController {
  late UploadImageUsecase uploadImage;
  late SaveImageurlUsecase saveImageUrl;
  LoadImageController(this.uploadImage, this.saveImageUrl);

  String imageUrl = '';
  String url = '';
  String uId = '';
  Rx<File?> selectedFile = Rx<File?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    imageUrl = Get.parameters['imageUrl'] ?? '';
    uId = Get.parameters['uId'] ?? '';
  }

  // =============================
  // PICK IMAGE
  // =============================
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
      SnackBarHelper.error('Gagal memuat gambar');
    }
  }

  // =============================
  // COMPRESS IMAGE
  // =============================
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

  // =============================
  // UPLOAD TO FIREBASE STORAGE
  // =============================
  Future<String?> uploadToFirebaseStorage(File? image, String docId) async {
    try {
      final imageUrl = await uploadImage.call(image, docId);
      return imageUrl;
    } catch (e) {
      return null;
    }
  }

  // =============================
  // SAVE IMAGE URL TO FIRESTORE
  // =============================
  Future<void> saveProfileImage(String docId) async {
    try {
      isLoading.value = true;

      // 🔥 compress dulu
      final compressedFile = await compressImage(selectedFile.value!);
      if (compressedFile == null) {
        SnackBarHelper.error('Gagal mengupload gambar');
        return;
      }

      // 🚀 upload
      final imageUrl = await uploadToFirebaseStorage(compressedFile, docId);

      if (imageUrl == null) {
        Get.snackbar('Upload gagal', 'Tidak dapat mengupload gambar');
        return;
      }

      // 💾 simpan ke firestore
      saveImageUrl.call(imageUrl, uId);

      SnackBarHelper.success('Berhasil mengupload gambar');
      Get.offAllNamed(Routes.FIRST_USER_DATA);
    } catch (e) {
      SnackBarHelper.error('Gagal mengupload gambar ($e)');
    } finally {
      isLoading.value = false;
    }
  }
}
