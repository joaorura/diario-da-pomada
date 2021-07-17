import 'package:app_flutter/models/signup-model.dart';
import 'package:app_flutter/models/token-model.dart';
import 'package:app_flutter/services/dio-service.dart';
import 'package:app_flutter/services/storage-service.dart';
import 'package:dio/dio.dart';

class SiginService extends DioService {
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
}
