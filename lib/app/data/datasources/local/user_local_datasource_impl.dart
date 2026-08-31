import 'package:hive_flutter/hive_flutter.dart';
import 'package:seleraku/app/data/datasources/local/user_local_datasource.dart';
import 'package:seleraku/app/domain/models/data_user_model.dart';

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final Box box;
  UserLocalDatasourceImpl(this.box);

  @override
  Future<void> saveOneUser(DataUserModel user) async {
    try {
      await box.put('user', user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveAuthor(DataUserModel user) async {
    try {
      await box.put('allUser', user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveAllUser(List<DataUserModel> allUser) async {
    try {
      await box.put('allUser', allUser.map((user) => user.toJson()).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DataUserModel?> getOneUser() async {
    try {
      final data = box.get('user');
      if (data == null) {
        return null;
      }

      final user = DataUserModel.fromJson(Map<String, dynamic>.from(data));
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getUserByListId() async {
    try {
      final data = box.get('allUser');
      if (data == null) {
        return [];
      }

      final listUser = (data as List)
          .map((user) => Map<String, dynamic>.from(user))
          .toList();

      return listUser;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DataUserModel> getAuhtor(String uId) async {
    try {
      final data = box.get('allUser');
      if (data == null) {
        throw Exception('Data user tidak ditemukan di local storage');
      }
      final List<DataUserModel> listUser = (data as List)
          .map(
            (user) => DataUserModel.fromJson(Map<String, dynamic>.from(user)),
          )
          .toList();
      print('local user $listUser');

      return listUser.firstWhere((user) => user.uId == uId);
    } catch (e) {
      rethrow;
    }
  }
}
