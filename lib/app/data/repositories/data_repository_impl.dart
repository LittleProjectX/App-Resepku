import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/data/datasources/local/resep_local_datasource.dart';
import 'package:seleraku/app/data/datasources/local/user_local_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource.dart';
import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/domain/models/data_favorite_model.dart';
import 'package:seleraku/app/domain/models/data_ingredient_model.dart';
import 'package:seleraku/app/domain/models/data_resep_model.dart';
import 'package:seleraku/app/domain/models/data_tutorial_model.dart';
import 'package:seleraku/app/domain/models/data_user_model.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';
import 'package:seleraku/app/domain/usecases/network_usecases/is_connected_usecase.dart';

class DataRepositoryImpl implements DataRepository {
  final DataRemoteDatasource remote;
  final IsConnectedUsecase isConnection;
  final UserLocalDatasource localUser;
  final ResepLocalDatasource localResep;
  DataRepositoryImpl(
    this.remote,
    this.isConnection,
    this.localUser,
    this.localResep,
  );

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser(String uId) {
    return remote.getUser(uId);
  }

  @override
  Future<DataUserModel?> getUserOnce(String uId) async {
    final isConnected = await isConnection();
    if (isConnected) {
      try {
        final data = await remote.getUserOnce(uId);
        if (data == null) {
          return null;
        }
        await localUser.saveOneUser(data);

        return data;
      } catch (_) {
        return localUser.getOneUser();
      }
    }
    return localUser.getOneUser();
  }

  @override
  Future<DataUserModel?> getAuthor(String uId) async {
    final isConnected = await isConnection();
    if (isConnected) {
      try {
        final data = await remote.getUserOnce(uId);
        if (data == null) {
          return null;
        }

        await localUser.saveAuthor(data);

        return data;
      } catch (_) {
        final data = await localUser.getAuhtor(uId);

        return data;
      }
    }
    final data = await localUser.getAuhtor(uId);

    return data;
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
    DateTime createdAt,
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
  Stream<List<Map<String, dynamic>>> getMyResep(String uId) {
    return remote.getMyResep(uId);
  }

  @override
  Future<List<DataResepModel>> getAllResep() async {
    final isConnected = await isConnection();
    if (isConnected) {
      try {
        final data = await remote.getAllResep();

        final listResep = data
            .map((resep) => DataResepModel.fromFirebase(resep))
            .toList();
        await localResep.saveAllResep(listResep);

        return listResep;
      } catch (e) {
        final data = await localResep.getAllResep();
        final listResep = data
            .map((resep) => DataResepModel.fromJson(resep))
            .toList();

        return listResep;
      }
    }

    final data = await localResep.getAllResep();
    final listResep = data
        .map((resep) => DataResepModel.fromJson(resep))
        .toList();

    return listResep;
  }

  @override
  Future<void> deleteResep(String rId) async {
    return await remote.deleteResep(rId);
  }

  @override
  Future<List<DataUserModel>> getAllUser() async {
    final data = await remote.getAllUser();
    final listUser = data
        .map((user) => DataUserModel.fromFirebase(user))
        .toList();
    return listUser;
  }

  @override
  Future<DataResepEntity> getResepbyId(String rId) async {
    final isConnected = await isConnection();
    if (isConnected) {
      try {
        return await remote.getResepbyId(rId);
      } catch (_) {
        final data = await localResep.getResepbyId(rId);
        return data;
      }
    }
    final data = await localResep.getResepbyId(rId);
    return data;
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
  Future<List<DataFavoriteModel>> getSavedResep(String uId) async {
    final isConnected = await isConnection();
    if (isConnected) {
      try {
        final data = await remote.getSavedResep(uId);
        final listFavorite = data
            .map((resep) => DataFavoriteModel.fromFirebase(resep))
            .toList();

        await localResep.saveListFavoritResep(listFavorite);
        return listFavorite;
      } catch (_) {
        final data = await localResep.getListFavoriteResep();
        final listFavorite = data
            .map((resep) => DataFavoriteModel.fromJson(resep))
            .toList();

        await localResep.saveListFavoritResep(listFavorite);

        return listFavorite;
      }
    }

    final data = await localResep.getListFavoriteResep();

    final listFavorite = data
        .map((resep) => DataFavoriteModel.fromJson(resep))
        .toList();

    return listFavorite;
  }

  @override
  Future<List<DataResepModel>> getSavedResepByListId(
    List<String> listId,
  ) async {
    final isConnected = await isConnection();
    if (isConnected) {
      try {
        final data = await remote.getSavedResepbyListId(listId);
        final listResep = data.map((resep) {
          return DataResepModel.fromFirebase(resep);
        }).toList();
        await localResep.saveAllResepSaved(listResep);
        return listResep;
      } catch (e) {
        final data = await localResep.getResepSaved();

        final listResep = data
            .map((resep) => DataResepModel.fromJson(resep))
            .toList();
        return listResep;
      }
    }

    final data = await localResep.getResepSaved();
    final listResep = data
        .map((resep) => DataResepModel.fromJson(resep))
        .toList();
    return listResep;
  }

  @override
  Future<void> sendNotification(
    String senderId,
    List<String> receiverId,
    String imageUrl,
    String title,
    String msg,
    bool isRead,
    DateTime createdAt,
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
  Future<List<Map<String, dynamic>>> getLikedAuthor(String afId) {
    return remote.getLikedAuthor(afId);
  }

  @override
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
  ) {
    return remote.updateResep(
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
  }

  @override
  Future<List<DataUserModel>> getUserByListId(List<String> listId) async {
    final isConnected = await isConnection();

    if (isConnected) {
      try {
        final data = await remote.getUserByListId(listId);
        final allUser = data
            .map((user) => DataUserModel.fromFirebase(user))
            .toList();

        await localUser.saveAllUser(allUser);

        return allUser;
      } catch (_) {
        final data = await localUser.getUserByListId();
        final listUser = data
            .map((user) => DataUserModel.fromJson(user))
            .toList();
        return listUser;
      }
    }
    final data = await localUser.getUserByListId();
    final listUser = data.map((user) => DataUserModel.fromJson(user)).toList();
    return listUser;
  }

  @override
  Future<List<Map<String, dynamic>>> getMyNotification(String uId) {
    return remote.getMyNotification(uId);
  }

  @override
  Future<void> readNotification(String uId, String notifId, bool isRead) {
    return remote.readNotification(uId, notifId, isRead);
  }

  @override
  Stream<List<Map<String, dynamic>>> searchResep(String title) {
    return remote.searchResep(title);
  }

  @override
  Future<List<QueryDocumentSnapshot<Object?>>> getUserbyEmail(String email) {
    return remote.getUserByEmail(email);
  }

  @override
  Future<void> sendReport(String uId, String report, DateTime createdAt) {
    return remote.sendReport(uId, report, createdAt);
  }
}
