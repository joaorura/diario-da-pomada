import 'package:app_flutter/models/week-question-model.dart';
import 'package:app_flutter/services/dio-service.dart';

class WeekQuestionService extends DioService {
  Future<bool> save(WeekQuestionModel answers) async {
    if (tokenUnset) {
      await loadAuthentication();
    }

    try {
      await dio!.post('/questions/weekly', data: answers);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
