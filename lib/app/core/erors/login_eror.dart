import 'package:firebase_auth/firebase_auth.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';

class LoginEror {
  void handleLoginError(FirebaseAuthException e) {
    switch (e.code) {
      case "user-not-found":
        SnackBarHelper.warning("Email belum di verifikasi");
        break;
      case "wrong-password":
        SnackBarHelper.warning("Password salah");
        break;
      case "invalid-email":
        SnackBarHelper.warning("Format email salah");
        break;
      case "user-disabled":
        SnackBarHelper.warning("Akun telah dinonaktifkan");
        break;
      case 'invalid-credential':
        SnackBarHelper.warning('Email atau password salah');
        break;
      default:
        SnackBarHelper.warning("Login failed");
    }
  }
}
