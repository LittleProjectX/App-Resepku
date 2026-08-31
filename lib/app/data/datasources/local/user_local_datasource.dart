import 'package:seleraku/app/domain/models/data_user_model.dart';

abstract class UserLocalDatasource {
  Future<void> saveOneUser(DataUserModel user);
  Future<void> saveAuthor(DataUserModel user);
  Future<void> saveAllUser(List<DataUserModel> allUser);
  Future<DataUserModel?> getOneUser();
  Future<List<Map<String, dynamic>>> getUserByListId();
  Future<DataUserModel> getAuhtor(String uId);
}
