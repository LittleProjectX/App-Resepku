import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:seleraku/app/data/datasources/data_remote_datasource.dart';
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

  @override
  Stream<DocumentSnapshot> getUser(String uId) {
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
      final user = docRef.data() as Map<String, dynamic>;

      return DataUserModel.fromFirebase(user);
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
    Timestamp createdAt,
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
  Stream<List<QueryDocumentSnapshot<Object?>>> getMyResep(String uId) {
    try {
      final reseps = firestore.collection('resep');
      return reseps
          .where('uId', isEqualTo: uId)
          .snapshots()
          .map((event) => event.docs);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<QueryDocumentSnapshot<Object?>>> getAllResep() {
    try {
      return reseps.get().then((value) => value.docs);
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
  Future<List<QueryDocumentSnapshot<Object?>>> getAllUser() {
    try {
      return users.get().then((value) => value.docs);
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
            'createdAt': Timestamp.now(),
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
            'createdAt': Timestamp.now(),
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
            'createdAt': Timestamp.now(),
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
  Future<List<QueryDocumentSnapshot<Object?>>> getSavedResep(String uId) async {
    try {
      final docRef = await resepSave.where('uId', isEqualTo: uId).get();
      return docRef.docs;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<QueryDocumentSnapshot<Object?>>> getSavedResepbyListId(
    List<String> listId,
  ) async {
    try {
      final docRef = await reseps
          .where(FieldPath.documentId, whereIn: listId)
          .get();
      return docRef.docs;
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
    Timestamp createdAt,
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
  Future<List<QueryDocumentSnapshot<Object?>>> getLikedAuthor(
    String afId,
  ) async {
    try {
      final docRef = await authorLike.where('afId', isEqualTo: afId).get();
      return docRef.docs;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<QueryDocumentSnapshot<Object?>>> getMyNotification(
    String uId,
  ) async {
    try {
      final doc = await users.doc(uId).collection('notification').get();
      return doc.docs;
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
  Stream<List<QueryDocumentSnapshot<Object?>>> searchResep(String title) {
    try {
      final upperTitle = title[0].toUpperCase() + title.substring(1);
      final docRef = reseps
          .where('title', isGreaterThanOrEqualTo: upperTitle)
          .where('title', isLessThanOrEqualTo: '$upperTitle\uf8ff')
          .snapshots()
          .map((event) => event.docs);
      return docRef;
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
}
