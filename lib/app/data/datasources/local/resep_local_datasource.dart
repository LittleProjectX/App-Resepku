import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/domain/models/data_favorite_model.dart';
import 'package:seleraku/app/domain/models/data_resep_model.dart';

abstract class ResepLocalDatasource {
  Future<void> saveAllResep(List<DataResepModel> listResep);
  Future<void> saveListFavoritResep(List<DataFavoriteModel> listFavorite);
  Future<void> saveAllResepSaved(List<DataResepModel> listResep);
  Future<List<Map<String, dynamic>>> getAllResep();
  Future<DataResepEntity> getResepbyId(String rId);
  Future<List<Map<String, dynamic>>> getListFavoriteResep();
  Future<List<Map<String, dynamic>>> getResepSaved();
}
