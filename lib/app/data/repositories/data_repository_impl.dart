import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/data/datasources/data_remote_datasource.dart';
import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/data/entities/data_user_entity.dart';
import 'package:seleraku/app/domain/models/data_ingredient_model.dart';
import 'package:seleraku/app/domain/models/data_tutorial_model.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class DataRepositoryImpl implements DataRepository {
  final DataRemoteDatasource remote;
  DataRepositoryImpl(this.remote);

  @override
  Future<DataUserEntity?> getUser(String uId) async {
    return await remote.getUser(uId);
  }

  @override
  Future<String> uploadImage(File? image, String uId) async {
    return await remote.uploadImage(image, uId);
  }

  @override
  Future<void> saveImageUrl(String imageUrl, String uId) async {
    return await remote.saveImageUrl(imageUrl, uId);
  }

  @override
  Future<void> setUserProfile(
    String uId,
    String name,
    String email,
    String phone,
  ) async {
    return await remote.setUserProfile(uId, name, email, phone);
  }

  @override
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
    Timestamp createdAt,
  ) async {
    return await remote.saveResep(
      uId,
      author,
      title,
      description,
      portion,
      category,
      imageUrl,
      mainIngredient,
      additive,
      tutorial,
      likes,
      saves,
      createdAt,
    );
  }

  @override
  Stream<List<QueryDocumentSnapshot<Object?>>> getMyResep(String uId) {
    return remote.getMyResep(uId);
  }

  @override
  Future<List<QueryDocumentSnapshot<Object?>>> getAllResep() async {
    return await remote.getAllResep();
  }

  @override
  Future<void> deleteResep(String rId) async {
    return await remote.deleteResep(rId);
  }

  @override
  Future<List<QueryDocumentSnapshot<Object?>>> getAllUser() async {
    return await remote.getAllUser();
  }

  @override
  Future<DataResepEntity> getResepbyId(String rId) async {
    return await remote.getResepbyId(rId);
  }

  @override
  Future<void> saveToMyResep(String uId, String rId, int saves) {
    return remote.saveToMyResep(uId, rId, saves);
  }

  @override
  Future<void> unSaveResep(String fId, String rId, int saves) {
    return remote.unSaveResep(fId, rId, saves);
  }

  @override
  Future<void> likeResep(String uId, String rId, int likes) {
    return remote.likeResep(uId, rId, likes);
  }

  @override
  Future<void> disLikeResep(String fId, int likes, String rId) {
    return remote.disLikeResep(fId, rId, likes);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getSavebyId(
    String uId,
    String rId,
  ) {
    return remote.getSaveById(uId, rId);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getLikebyId(
    String uId,
    String rId,
  ) {
    return remote.getLikeById(uId, rId);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAuthorFav(
    String uId,
    String afId,
  ) {
    return remote.getLikeAuthor(uId, afId);
  }

  @override
  Future<void> likeAuthor(String uId, String afId, int likes) {
    return remote.likeAuthor(uId, afId, likes);
  }

  @override
  Future<void> unLikeAthor(String afId, String aId, int likes) {
    return remote.unLikeAuthor(aId, afId, likes);
  }

  @override
  Future<List<QueryDocumentSnapshot<Object?>>> getSavedResep(String uId) async {
    return await remote.getSavedResep(uId);
  }

  @override
  Future<List<QueryDocumentSnapshot<Object?>>> getSavedResepByListId(
    List<String> listId,
  ) async {
    return await remote.getSavedResepbyListId(listId);
  }

  @override
  Future<void> sendNotification(
    String senderId,
    List<String> receiverId,
    String imageUrl,
    String title,
    String msg,
    bool isRead,
    Timestamp createdAt,
  ) {
    return remote.sendNotification(
      senderId,
      receiverId,
      imageUrl,
      title,
      msg,
      isRead,
      createdAt,
    );
  }

  @override
  Future<List<QueryDocumentSnapshot<Object?>>> getLikedAuthor(String afId) {
    return remote.getLikedAuthor(afId);
  }

  @override
  Future<List<QueryDocumentSnapshot<Object?>>> getMyNotification(String uId) {
    return remote.getMyNotification(uId);
  }

  @override
  Future<void> readNotification(String uId, String notifId, bool isRead) {
    return remote.readNotification(uId, notifId, isRead);
  }
}
