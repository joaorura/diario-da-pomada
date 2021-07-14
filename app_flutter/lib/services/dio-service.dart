import 'package:dio/dio.dart';

class DioService {
  final Dio dio = Dio();

  void setToken(String token) {
    dio.options.headers['authorization'] = token;
  }
}
