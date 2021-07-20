import 'package:app_flutter/models/daily-question-model.dart';
import 'package:app_flutter/services/dio-service.dart';

class DailyQuestionService extends DioService {
  Future<bool> save(DailyQuestionModel answers) async {
    try {
      await dio.post('/daily', data: answers);
      return true;
    } catch (error) {
      return false;
    }
  }
}
