import 'package:app_flutter/models/calendar-model.dart';
import 'package:app_flutter/models/login-model.dart';
import 'package:app_flutter/models/token-model.dart';
import 'package:app_flutter/services/calendar-service.dart';
import 'package:app_flutter/services/dio-service.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/services/storage-service.dart';
import 'package:dio/dio.dart';

class LoginService extends DioService {
  Future<bool> login(
      LoginModel login, NotificationService notificationService) async {
    if (tokenUnset) {
      await loadAuthentication();
    }

    StorageService storageService = StorageService();

    try {
      Response response = await dio!.post("/auth/signin", data: login);
      TokenModel token = TokenModel.fromJson(response.data);

      storageService.clearAll();
      storageService.saveToken(token.acessToken);
      await storageService.reload();

      CalendarService calendarService = new CalendarService();
      CalendarModel calendarModel = await calendarService.getCalendar(
          notificationService: notificationService, attNotifications: true);

      if (calendarModel.erro == true) {
        storageService.clearAll();
        storageService.reload();

        return false;
      }

      storageService.reload();
    } on Exception catch (_) {
      storageService.clearAll();
      storageService.reload();

      return false;
    }

    return true;
  }

  Future<void> logOff() async {
    if (tokenUnset) {
      await loadAuthentication();
    }

    StorageService storageSerivice = new StorageService();
    storageSerivice.clearAll();
    await storageSerivice.reload();
    NotificationService notificationService = new NotificationService();
    await notificationService.clearAll();
  }

  Future<bool> loged() async {
    if (tokenUnset) {
      await loadAuthentication();
    }

    StorageService storageService = new StorageService();

    String? token = await storageService.getToken();

    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
}
