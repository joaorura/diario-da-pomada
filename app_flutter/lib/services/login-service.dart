import 'package:app_flutter/models/login-model.dart';
import 'package:app_flutter/models/token-model.dart';
import 'package:app_flutter/services/dio-service.dart';
import 'package:app_flutter/services/storage-service.dart';
import 'package:dio/dio.dart';

class LoginService extends DioService {
  Future<bool> login(LoginModel login) async {
    try {
      Response response = await dio.post("/auth/signin", data: login);
      TokenModel token = TokenModel.fromJson(response.data);

      StorageService storageService = StorageService();
      storageService.saveToken(token.acessToken);
    } catch (error) {
      return false;
    }

    return true;
  }

  void logOff() {
    StorageService storageSerivice = new StorageService();
    storageSerivice.removeToken();
  }

  bool loged() {
    StorageService storageService = new StorageService();

    String token = storageService.getToken();

    if (token == '') {
      return false;
    } else {
      return true;
    }
  }
}
