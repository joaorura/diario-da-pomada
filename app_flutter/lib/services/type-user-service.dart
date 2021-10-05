import 'package:app_flutter/models/type-user-model.dart';
import 'package:app_flutter/services/dio-service.dart';
import 'package:dio/dio.dart';

class TypeUserService extends DioService {
  Future<TypeUserModel?> getTypeUser() async {
    if (tokenUnset) {
      await loadAuthentication();
    }

    try {
      Response response = await dio!.get("/user/role");
      TypeUserModel result = TypeUserModel.fromJson(response.data);
      return result;
    } on Exception catch (_) {
      return null;
    }
  }
}
