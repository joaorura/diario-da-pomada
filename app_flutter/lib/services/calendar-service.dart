import 'package:app_flutter/models/calendar-model.dart';
import 'package:app_flutter/services/dio-service.dart';

class CalendarService extends DioService {
  CalendarModel getCalendar() {
    return CalendarModel();
  }
}
