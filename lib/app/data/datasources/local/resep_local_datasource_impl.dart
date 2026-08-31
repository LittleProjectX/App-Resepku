import 'package:hive_flutter/hive_flutter.dart';
import 'package:seleraku/app/data/datasources/local/resep_local_datasource.dart';
import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/domain/models/data_favorite_model.dart';
import 'package:seleraku/app/domain/models/data_resep_model.dart';

class ResepLocalDatasourceImpl implements ResepLocalDatasource {
  final Box box;
  ResepLocalDatasourceImpl(this.box);

  @override
  Future<void> saveAllResep(List<DataResepModel> listResep) async {
    try {
      print('local cek listResep $listResep');
      await box.put(
        'allResep',
        listResep.map((resep) => resep.toJson()).toList(),
      );
      final data = box.get('allResep');
      print('local cek box $data');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveListFavoritResep(
    List<DataFavoriteModel> listFavorite,
  ) async {
    try {
      await box.put(
        'favorite',
        listFavorite.map((favorite) => favorite.toJson()).toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveAllResepSaved(List<DataResepModel> listResep) async {
    try {
      await box.put(
        'savedResep',
        listResep.map((resep) => resep.toJson()).toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllResep() async {
    final data = box.get('allResep');
    if (data == null) {
      return [];
    }

    try {
      print('ALL RESEP LOCAL $data');
      final listResep = (data as List).map((resep) {
        final mapResep = Map<String, dynamic>.from(resep);
        mapResep['mainIngredient'] = (mapResep['mainIngredient'] as List? ?? [])
            .map((ingredient) => Map<String, dynamic>.from(ingredient))
            .toList();
        mapResep['additive'] = (mapResep['additive'] as List? ?? [])
            .map((ingredient) => Map<String, dynamic>.from(ingredient))
            .toList();
        mapResep['tutorial'] = (mapResep['tutorial'] as List? ?? [])
            .map((ingredient) => Map<String, dynamic>.from(ingredient))
            .toList();
        return mapResep;
      }).toList();
      return listResep;
    } catch (_) {
      return [];
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getListFavoriteResep() async {
    final data = box.get('favorite');
    print('isi list favorite local $data');

    if (data == null) {
      return [];
    }

    try {
      final listFavorite = (data as List)
          .map((favorite) => Map<String, dynamic>.from(favorite))
          .toList();
      return listFavorite;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getResepSaved() async {
    final data = box.get('savedResep');
    print('local saved resep $data');

    if (data == null) {
      return [];
    }

    final listResep = (data as List).map((resep) {
      final mapResep = Map<String, dynamic>.from(resep);
      mapResep['mainIngredient'] = (mapResep['mainIngredient'] as List? ?? [])
          .map((ingredient) => Map<String, dynamic>.from(ingredient))
          .toList();
      mapResep['additive'] = (mapResep['additive'] as List? ?? [])
          .map((ingredient) => Map<String, dynamic>.from(ingredient))
          .toList();
      mapResep['tutorial'] = (mapResep['tutorial'] as List? ?? [])
          .map((ingredient) => Map<String, dynamic>.from(ingredient))
          .toList();
      return mapResep;
    }).toList();
    print('local saved mapResep $listResep');

    try {
      return listResep;
    } catch (_) {
      return [];
    }
  }

  @override
  Future<DataResepEntity> getResepbyId(String rId) async {
    try {
      final data = box.get('allResep');
      final listResep = (data as List).map((resep) {
        final mapResep = DataResepModel.fromJson(
          Map<String, dynamic>.from(resep),
        );

        return mapResep;
      }).toList();
      print('isi local list $listResep');
      final resep = listResep.firstWhere((resep) => resep.rId == rId);
      print('isi local resep $resep');
      return resep;
    } catch (e) {
      rethrow;
    }
  }
}
