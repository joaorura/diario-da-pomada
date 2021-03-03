import 'package:app_flutter/models/login-model.dart';
import 'package:app_flutter/services/dio-service.dart';

class LoginService extends DioService {
  void login(LoginModel login) {
    print("Enviado Login");
  }
}
