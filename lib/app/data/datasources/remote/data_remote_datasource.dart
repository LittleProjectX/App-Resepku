import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/domain/models/data_ingredient_model.dart';
import 'package:seleraku/app/domain/models/data_tutorial_model.dart';
import 'package:seleraku/app/domain/models/data_user_model.dart';

abstract class DataRemoteDatasource {
  Future<DataUserModel?> getUserOnce(String uId);
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser(String uId);
  Future<String> uploadImage(File? image, String uId);
  Future<void> saveImageUrl(String imageUrl, String uId);
  Future<void> setUserProfile(
    String uId,
    String name,
    String email,
    String phone,
  );
  Future<void> saveResep(
    String uId,
    String author,
    String title,
    String description,
    String portion,
    String category,
    String imageUrl,
    List<DataIngredientModel> mainIngredient,
    List<DataIngredientModel> additive,
    List<DataTutorialModel> tutorial,
    int likes,
    int saves,
    DateTime createdAt,
  );
  Stream<List<QueryDocumentSnapshot>> getMyResep(String uId);
  Future<List<Map<String, dynamic>>> getAllResep();
  Future<void> deleteResep(String rId);
  Future<List<QueryDocumentSnapshot>> getAllUser();
  Future<DataResepEntity> getResepbyId(String rId);
  Future<void> saveToMyResep(String uId, String rId, int saves);
  Future<void> unSaveResep(String fId, String rId, int saves);
  Future<void> likeResep(String uId, String rId, int likes);
  Future<void> disLikeResep(String fId, String rId, int likes);
  Stream<QuerySnapshot<Map<String, dynamic>>> getSaveById(
    String uId,
    String rId,
  );
  Stream<QuerySnapshot<Map<String, dynamic>>> getLikeById(
    String uId,
    String rId,
  );
  Stream<QuerySnapshot<Map<String, dynamic>>> getLikeAuthor(
    String uId,
    String afId,
  );
  Future<void> likeAuthor(String uId, String afId, int likes);
  Future<void> unLikeAuthor(String aId, String afId, int likes);
  Future<List<QueryDocumentSnapshot>> getSavedResep(String uId);
  Future<List<QueryDocumentSnapshot>> getSavedResepbyListId(
    List<String> listId,
  );
  Future<void> sendNotification(
    String senderId,
    List<String> receiverId,
    String imageUrl,
    String title,
    String msg,
    bool isRead,
    DateTime createdAt,
  );
  Future<List<QueryDocumentSnapshot>> getLikedAuthor(String afId);
  Future<List<QueryDocumentSnapshot>> getMyNotification(String uId);
  Future<void> readNotification(String uId, String notifId, bool isRead);
  Stream<List<QueryDocumentSnapshot>> searchResep(String title);
  Future<List<QueryDocumentSnapshot>> getUserByEmail(String email);
  Future<List<QueryDocumentSnapshot>> getUserByListId(List<String> listId);
  Future<void> updateResep(
    String rId,
    String title,
    String description,
    String portion,
    String category,
    String imageUrl,
    List<DataIngredientModel> mainIngredient,
    List<DataIngredientModel> additive,
    List<DataTutorialModel> tutorial,
    DateTime createdAt,
  );
  Future<void> sendReport(String uId, String report, DateTime createdAt);
}
