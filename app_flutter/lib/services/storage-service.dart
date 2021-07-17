import 'package:app_flutter/main.dart';

class StorageService {
  void removeToken() {
    prefs.setString('token', '');
  }

  String getToken() {
    String token = prefs.getString('token');

    return token;
  }

  void saveToken(String token) {
    prefs.setString('token', token);
  }
}
