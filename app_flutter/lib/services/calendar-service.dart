import 'package:app_flutter/models/calendar-model.dart';
import 'package:app_flutter/models/date-model.dart';
import 'package:app_flutter/services/dio-service.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/services/storage-service.dart';
import 'package:dio/dio.dart';

class CalendarService extends DioService {
  Future<CalendarModel> getCalendar(
      {NotificationService notificationService, bool attNotifications}) async {
    CalendarModel result;
    StorageService storageService = new StorageService();
    await storageService.reload();

    try {
      Response response =
          await dio.post("/calendary", data: DateNowModel(DateTime.now()));
      result = CalendarModel.fromJson(response.data);

      storageService.setCalendar(response.data);

      if (notificationService != null &&
          (result.newCalendar ||
              (attNotifications != null && attNotifications))) {
        notificationService.attNotifications(calendarModel: result);
      }
    } catch (error) {
      result = storageService.getCalendar();
      result.erro = true;
    }

    storageService.reload();
    return result;
  }
}
