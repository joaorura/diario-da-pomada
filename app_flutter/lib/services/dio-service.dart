import 'package:app_flutter/services/storage-service.dart';
import 'package:dio/dio.dart';

class DioService {
  static const String baseUrl = "https://gynecology.herokuapp.com";
  Dio dio;
  DioService({String token}) {
    dio = new Dio(new BaseOptions(baseUrl: baseUrl, connectTimeout: 5000));

    StorageService storageService = new StorageService();

    if (token == null) {
      token = storageService.getToken();

      if (token != null) {
        setToken(token);
      }
    } else {
      setToken(token);
    }
  }

  void setToken(String token) {
    dio.options.headers['Authorization'] = "Bearer $token";
  }
}
