import 'package:app_flutter/services/storage-service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioService {
  static const String urlDev = "http://10.0.2.2:3000";
  static const String urlRelease = "http://10.0.2.2:3000";

  Dio dio;

  DioService({String token}) {
    String baseUrl;

    if (kReleaseMode) {
      baseUrl = urlRelease;
    } else {
      baseUrl = urlDev;
    }

    StorageService storageService = new StorageService();
    dio = new Dio(new BaseOptions(baseUrl: baseUrl, connectTimeout: 5000));

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
