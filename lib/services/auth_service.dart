import '../models/user_data.dart';

class AuthService {
  static UserData? currentUser;

  static bool login(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      currentUser = UserData(
        name: 'Dwi Ajeng',
        email: email,
      );

      return true;
    }

    return false;
  }

  static void logout() {
    currentUser = null;
  }
}