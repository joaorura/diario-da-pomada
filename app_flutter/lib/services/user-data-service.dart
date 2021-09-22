import 'package:app_flutter/models/file-model.dart';
import 'package:app_flutter/models/user-data-model.dart';
import 'package:app_flutter/services/dio-service.dart';
import 'package:dio/dio.dart';

class UserDataService extends DioService {
  Future<UserDataModel> getUserData() async {
    try {
      Response response = await dio.get("/users");
      UserDataModel result = UserDataModel.fromJson(response.data);

      return result;
    } on Exception catch (erro) {
      return null;
    }
  }
}
