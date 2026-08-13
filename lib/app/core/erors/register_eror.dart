import 'package:firebase_auth/firebase_auth.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';

class RegisterEror {
  void handleRegisterError(FirebaseAuthException e) {
    switch (e.code) {
      case "weak-password":
        SnackBarHelper.warning("Password too weak");
        break;
      case "email-already-in-use":
        SnackBarHelper.warning("Email already in use");
        break;
      case "invalid-email":
        SnackBarHelper.warning("Invalid email format");
        break;
      default:
        SnackBarHelper.warning("Registration failed");
    }
  }
}
