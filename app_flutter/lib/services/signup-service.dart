import 'package:app_flutter/models/signup-model.dart';
import 'package:app_flutter/models/token-model.dart';
import 'package:app_flutter/services/dio-service.dart';
import 'package:app_flutter/services/storage-service.dart';
import 'package:dio/dio.dart';

class SignupService extends DioService {
  Future<bool> signUp(SignupModel sigupModel) async {
    if (tokenUnset) {
      await loadAuthentication();
    }

    StorageService storageService = new StorageService();

    try {
      Response response = await dio!.post("/auth/signup", data: sigupModel);
      TokenModel tokenModel = TokenModel.fromJson(response.data);

      storageService.saveToken(tokenModel.acessToken);
      storageService.reload();
      return true;
    } on Exception catch (erro) {
      storageService.clearAll();
      storageService.reload();
      print(erro);
      return false;
    }
  }

  Future<SignupModel?> getUser() async {
    if (tokenUnset) {
      await loadAuthentication();
    }

    try {
      Response response = await dio!.get("/user");
      SignupModel result = SignupModel.fromJsonAtt(response.data);
      return result;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<bool> attUser(SignupModel sigupModel) async {
    if (tokenUnset) {
      await loadAuthentication();
    }

    try {
      await dio!.patch("/user", data: sigupModel.toJsonAtt());
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
