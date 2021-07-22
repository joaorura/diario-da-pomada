import 'package:app_flutter/models/csv-model.dart';
import 'package:app_flutter/services/dio-service.dart';
import 'package:dio/dio.dart';

class CsvService extends DioService {
  Future<CsvModel> getCsv() async {
    try {
      Response response = await dio.get("/csv");
      CsvModel result = CsvModel.fromJson(response.data);

      return result;
    } on Exception catch (erro) {
      return null;
    }
  }
}
