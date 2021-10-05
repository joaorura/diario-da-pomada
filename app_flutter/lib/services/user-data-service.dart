import 'package:app_flutter/models/user-data-model.dart';
import 'package:app_flutter/services/dio-service.dart';
import 'package:dio/dio.dart';

class UserDataService extends DioService {
  Future<UserDataModel?> getUserData() async {
    if (tokenUnset) {
      await loadAuthentication();
    }

    try {
      Response response = await dio!.get("/user/specific-reports");
      UserDataModel result = UserDataModel.fromJson(response.data);

      return result;
    } on Exception catch (_) {
      return null;
    }
  }
}
