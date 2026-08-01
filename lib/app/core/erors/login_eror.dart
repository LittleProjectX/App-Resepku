import 'package:firebase_auth/firebase_auth.dart';
import 'package:seleraku/app/core/utils/snacbar_helper.dart';

class LoginEror {
  void handleLoginError(FirebaseAuthException e) {
    switch (e.code) {
      case "user-not-found":
        SnackBarHelper.cautionSnacbar("Email belum di verifikasi");
        break;
      case "wrong-password":
        SnackBarHelper.cautionSnacbar("Password salah");
        break;
      case "invalid-email":
        SnackBarHelper.cautionSnacbar("Format email salah");
        break;
      case "user-disabled":
        SnackBarHelper.cautionSnacbar("Akun telah dinonaktifkan");
        break;
      case 'invalid-credential':
        SnackBarHelper.cautionSnacbar('Email atau password salah');
        break;
      default:
        SnackBarHelper.cautionSnacbar("Login failed");
    }
  }
}
