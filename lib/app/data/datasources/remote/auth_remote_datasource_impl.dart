import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/data/datasources/remote/auth_remote_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/data/entities/data_user_entity.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRemoteDatasourceImpl(this.auth, this.firestore);

  @override
  Future<UserCredential> login(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = credential.user;

      if (user == null) {
        throw Exception('Akun tidak ditemukan');
      }

      await user.reload();
      user = auth.currentUser;

      if (user != null && !user.emailVerified) {
        throw Exception('Email belum di verifikasi');
      }

      return credential;
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DataUserEntity?> register(String email, String password) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw Exception('Registrasi gagal');
      }

      await user.sendEmailVerification();
      await firestore.collection('users').doc(user.uid).set({
        'uId': user.uid,
        'email': email,
        'isProfileComplete': false,
        'likes': 0,
        'createdAt': DateTime.now(),
      });
      await auth.signOut();

      return null;
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) {
    try {
      return auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() {
    try {
      return auth.signOut();
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<User?> getStream() {
    try {
      return auth.authStateChanges();
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  String getCurrentUid() {
    try {
      return auth.currentUser!.uid;
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential?> loginWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final user = userCredential.user;

      await firestore.collection('users').doc(user?.uid).set({
        'uId': user?.uid,
        'email': user?.email,
        'isProfileComplete': false,
        'likes': 0,
        'createdAt': DateTime.now(),
      });

      return userCredential;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }

      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      await auth.currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> resendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return;
      }

      if (user.emailVerified) {
        SnackBarHelper.success('Email sudah terverifikasi');
        return;
      }

      await user.sendEmailVerification();

      SnackBarHelper.success('Email verifikasi berhasil dikirim ulang');
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
