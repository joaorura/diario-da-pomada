import 'package:app_flutter/models/signup-model.dart';
import 'package:app_flutter/models/token-model.dart';
import 'package:app_flutter/services/dio-service.dart';
import 'package:app_flutter/services/storage-service.dart';
import 'package:dio/dio.dart';

class SignupService extends DioService {
  Future<bool> signUp(SignupModel sigupModel) async {
    try {
      Response response = await dio.post("/auth/signup", data: sigupModel);
      TokenModel tokenModel = TokenModel.fromJson(response.data);

      StorageService storageService = new StorageService();
      storageService.saveToken(tokenModel.acessToken);
    } catch (erro) {
      return false;
    }

    return true;
  }

  Future<SignupModel> getUser() async {
    try {
      Response response = await dio.get("/user");
      SignupModel result = SignupModel.fromJson(response.data);
      return result;
    } catch (erro) {
      return null;
    }
  }

  Future<bool> attUser(SignupModel sigupModel) async {
    try {
      dio.post("/auth/signup", data: sigupModel);
      return true;
    } catch (erro) {
      return false;
    }
  }
}
