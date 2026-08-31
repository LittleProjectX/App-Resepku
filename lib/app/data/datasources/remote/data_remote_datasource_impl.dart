import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource.dart';
import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/domain/models/data_ingredient_model.dart';
import 'package:seleraku/app/domain/models/data_resep_model.dart';
import 'package:seleraku/app/domain/models/data_tutorial_model.dart';
import 'package:seleraku/app/domain/models/data_user_model.dart';

class DataRemoteDatasourceImpl implements DataRemoteDatasource {
  final FirebaseFirestore firestore;
  DataRemoteDatasourceImpl(this.firestore);

  late final CollectionReference<Map<String, dynamic>> users = firestore
      .collection('users');
  late final CollectionReference<Map<String, dynamic>> reseps = firestore
      .collection('resep');
  late final CollectionReference<Map<String, dynamic>> resepLikes = firestore
      .collection('resepLikes');
  late final CollectionReference<Map<String, dynamic>> resepSave = firestore
      .collection('resepSave');
  late final CollectionReference<Map<String, dynamic>> authorLike = firestore
      .collection('authorLike');
  late final CollectionReference<Map<String, dynamic>> reports = firestore
      .collection('report');

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser(String uId) {
    try {
      final result = users.doc(uId).snapshots();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DataUserModel?> getUserOnce(String uId) async {
    try {
      final docRef = await users.doc(uId).get();
      final data = docRef.data();

      if (data == null) {
        return null;
      }

      final user = DataUserModel.fromFirebase(data);

      final box = Hive.box('user');
      await box.put('currentUser', user.toJson());

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DataUserModel> getAuthor(String uId) async {
    try {
      final docRef = await users.doc(uId).get();
      final data = docRef.data();

      final user = DataUserModel.fromFirebase(data!);

      final box = Hive.box('user');
      await box.put('currentUser', user.toJson());

      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> uploadImage(File? image, String uId) async {
    try {
      final fileName =
          'users/$uId/${DateTime.now().millisecondsSinceEpoch}.jpg';

      final ref = FirebaseStorage.instance.ref().child(fileName);

      await ref.putFile(image!);
      return await ref.getDownloadURL();
    } catch (e) {
      return '';
    }
  }

  @override
  Future<void> saveImageUrl(String imageUrl, String uId) async {
    try {
      await users.doc(uId).update({'imageUrl': imageUrl});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setUserProfile(
    String uId,
    String name,
    String email,
    String phone,
  ) async {
    try {
      await users.doc(uId).update({
        'name': name,
        'email': email,
        'phone': phone,
        'isProfileComplete': true,
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveResep(
    String uId,
    String author,
    String title,
    String description,
    String category,
    String imageUrl,
    String portion,
    List<DataIngredientModel> mainIngredient,
    List<DataIngredientModel> additive,
    List<DataTutorialModel> tutorial,
    int likes,
    int save,
    DateTime createdAt,
  ) async {
    try {
      final docRef = reseps.doc();
      String idDoc = docRef.id;
      final dataIngredient = mainIngredient.map((e) => e.toJson()).toList();
      final dataAdditive = additive.map((e) => e.toJson()).toList();
      final dataTutorial = tutorial.map((e) => e.toJson()).toList();
      final upperTitle = title[0].toUpperCase() + title.substring(1);

      await docRef.set({
        'rId': idDoc,
        'uId': uId,
        'author': author,
        'title': upperTitle,
        'description': description,
        'portion': portion,
        'category': category,
        'imageUrl': imageUrl,
        'mainIngredient': dataIngredient,
        'additive': dataAdditive,
        'tutorial': dataTutorial,
        'likes': likes,
        'save': save,
        'createdAt': createdAt,
      });
    } catch (e) {
      rethrow;
    }
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
  ) async {
    try {
      final dataIngredient = mainIngredient.map((e) => e.toJson()).toList();
      final dataAdditive = additive.map((e) => e.toJson()).toList();
      final dataTutorial = tutorial.map((e) => e.toJson()).toList();
      final upperTitle = title[0].toUpperCase() + title.substring(1);

      await reseps.doc(rId).set({
        'title': upperTitle,
        'description': description,
        'portion': portion,
        'category': category,
        'imageUrl': imageUrl,
        'mainIngredient': dataIngredient,
        'additive': dataAdditive,
        'tutorial': dataTutorial,
        'createdAt': createdAt,
      }, SetOptions(merge: true));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getUserByListId(
    List<String> listId,
  ) async {
    try {
      final docRef = await users
          .where(FieldPath.documentId, whereIn: listId)
          .get();

      final result = docRef.docs;
      final listUser = result.map((e) {
        final data = e.data();
        return data;
      }).toList();
      return listUser;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> getMyResep(String uId) {
    try {
      final reseps = firestore.collection('resep');
      return reseps.where('uId', isEqualTo: uId).snapshots().map((event) {
        return event.docs.map((doc) {
          return doc.data();
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllResep() async {
    try {
      final docRef = await reseps.limit(50).get();

      final listResep = docRef.docs.map((e) {
        final data = e.data();

        return data;
      }).toList();

      return listResep;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteResep(String rId) async {
    try {
      await reseps.doc(rId).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllUser() {
    try {
      return users.get().then((value) {
        return value.docs.map((doc) {
          return doc.data();
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DataResepEntity> getResepbyId(String rId) async {
    try {
      final result = await reseps.doc(rId).get();
      final data = result.data();

      if (data == null) {
        throw Exception('Resep tidak ditemukan');
      }
      return DataResepModel.fromFirebase(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveToMyResep(String uId, String rId, int saves) async {
    try {
      final docRef = resepSave.doc();
      final idDoc = docRef.id;

      await docRef
          .set({
            'fId': idDoc,
            'rId': rId,
            'uId': uId,
            'createdAt': DateTime.now(),
          })
          .then((value) {
            reseps.doc(rId).set({'save': saves}, SetOptions(merge: true));
          });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> unSaveResep(String fId, String rId, int saves) async {
    try {
      await resepSave.doc(fId).delete().then((value) {
        reseps.doc(rId).set({'save': saves}, SetOptions(merge: true));
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> likeResep(String uId, String rId, int likes) async {
    try {
      final docRef = resepLikes.doc();
      final idDoc = docRef.id;
      await docRef
          .set({
            'fId': idDoc,
            'uId': uId,
            'rId': rId,
            'createdAt': DateTime.now(),
          })
          .then((value) {
            reseps.doc(rId).set({'likes': likes}, SetOptions(merge: true));
          });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> disLikeResep(String fId, String rId, int likes) async {
    try {
      await resepLikes.doc(fId).delete().then((value) {
        reseps.doc(rId).set({'likes': likes}, SetOptions(merge: true));
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getLikeById(
    String uId,
    String rId,
  ) {
    try {
      final docRef = resepLikes
          .where('rId', isEqualTo: rId)
          .where('uId', isEqualTo: uId)
          .snapshots();

      return docRef;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getSaveById(
    String uId,
    String rId,
  ) {
    try {
      final docRef = resepSave
          .where('uId', isEqualTo: uId)
          .where('rId', isEqualTo: rId)
          .snapshots();
      return docRef;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getLikeAuthor(
    String uId,
    String afId,
  ) {
    try {
      final docRef = authorLike
          .where('afId', isEqualTo: afId)
          .where('uId', isEqualTo: uId)
          .snapshots();
      return docRef;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> likeAuthor(String uId, String afId, int likes) async {
    try {
      final docRef = authorLike.doc();
      final docId = docRef.id;

      await docRef
          .set({
            'aId': docId,
            'uId': uId,
            'afId': afId,
            'createdAt': DateTime.now(),
          })
          .then((value) {
            users.doc(afId).set({'likes': likes}, SetOptions(merge: true));
          });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> unLikeAuthor(String aId, String afId, int likes) async {
    try {
      await authorLike.doc(aId).delete().then((value) {
        users.doc(afId).set({'likes': likes}, SetOptions(merge: true));
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSavedResep(String uId) async {
    try {
      final docRef = await resepSave.where('uId', isEqualTo: uId).get();
      final listResep = docRef.docs.map((e) {
        return e.data();
      }).toList();
      return listResep;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSavedResepbyListId(
    List<String> listId,
  ) async {
    try {
      final docRef = await reseps
          .where(FieldPath.documentId, whereIn: listId)
          .get();
      final listResep = docRef.docs.map((e) {
        return e.data();
      }).toList();
      return listResep;
    } catch (e) {
      rethrow;
    }
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
  ) async {
    try {
      for (final recId in receiverId) {
        final docRef = users.doc(recId).collection('notification').doc();
        final docId = docRef.id;

        await docRef.set({
          'docId': docId,
          'senderId': senderId,
          'receiverId': recId,
          'imageUrl': imageUrl,
          'title': title,
          'msg': msg,
          'isRead': isRead,
          'createdAt': createdAt,
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getLikedAuthor(String afId) async {
    try {
      final docRef = await authorLike.where('afId', isEqualTo: afId).get();
      return docRef.docs.map((doc) {
        return doc.data();
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getMyNotification(String uId) async {
    try {
      final docRef = await users.doc(uId).collection('notification').get();
      final listNotif = docRef.docs.map((e) {
        return e.data();
      }).toList();
      return listNotif;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> readNotification(String uId, String notifId, bool isRead) async {
    try {
      await users.doc(uId).collection('notification').doc(notifId).set({
        'isRead': isRead,
      }, SetOptions(merge: true));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> searchResep(String title) {
    try {
      final upperTitle = title[0].toUpperCase() + title.substring(1);
      final docRef = reseps
          .where('title', isGreaterThanOrEqualTo: upperTitle)
          .where('title', isLessThanOrEqualTo: '$upperTitle\uf8ff')
          .snapshots()
          .map((event) => event.docs);

      final listResep = docRef.map((event) {
        return event.map((doc) {
          return doc.data();
        }).toList();
      });
      return listResep;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<QueryDocumentSnapshot>> getUserByEmail(String email) async {
    try {
      final docRef = await users.where('email', isEqualTo: email).get();
      return docRef.docs;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendReport(String uId, String report, DateTime createdAt) async {
    try {
      final docRef = reports.doc();
      String docId = docRef.id;

      docRef.set({
        'dId': docId,
        'uId': uId,
        'report': report,
        'createdAt': createdAt,
      });
    } catch (e) {
      rethrow;
    }
  }
}
