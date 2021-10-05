import 'package:app_flutter/models/file-model.dart';
import 'package:app_flutter/services/dio-service.dart';
import 'package:dio/dio.dart';

class ReportService extends DioService {
  Future<FileModel?> getGeneralReport() async {
    if (tokenUnset) {
      await loadAuthentication();
    }

    try {
      Response response = await dio!.get("/reports/general");
      FileModel result = FileModel.fromJson(response.data);

      return result;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<FileModel?> getEspecificReport(String? healthCard) async {
    if (tokenUnset) {
      await loadAuthentication();
    }

    try {
      Response response = await dio!
          .post("/reports/specific", data: {"healthCard": healthCard});
      FileModel result = FileModel.fromJson(response.data);

      return result;
    } on Exception catch (_) {
      return null;
    }
  }
}
