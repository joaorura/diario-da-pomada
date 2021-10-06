import 'package:app_flutter/services/storage-service.dart';
import 'package:dio/dio.dart';

class DioService {
  static const String baseUrl = "https://gynecology.herokuapp.com/";
  String? _token;
  bool tokenUnset = true;
  Dio? dio;

  DioService({String? token}) {
    dio = new Dio(new BaseOptions(baseUrl: baseUrl, connectTimeout: 5000));
    _token = token;
  }

  void setToken(String? token) {
    tokenUnset = false;
    dio!.options.headers['Authorization'] = "Bearer $token";
  }

  Future<void> loadAuthentication() async {
    if (_token == null) {
      StorageService storageService = new StorageService();
      _token = await storageService.getToken();

      if (_token != null) {
        setToken(_token);
      }
    } else {
      setToken(_token);
    }
  }
}
