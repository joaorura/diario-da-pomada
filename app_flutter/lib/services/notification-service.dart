import 'package:app_flutter/main.dart';
import 'package:app_flutter/models/notification-model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin fltrNotification;

  Future _notificationSelected(String payload) async {
    return new MyHomePage();
  }

  NotificationService() {
    var androidInitilize = new AndroidInitializationSettings('ic_launcher');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);

    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: _notificationSelected);
  }

  void scheduleNotification(
      NotificationModel notifications, DateTime scheduledTime) async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer", "This is my channel",
        importance: Importance.high);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    fltrNotification.zonedSchedule(notifications.id, notifications.title,
        notifications.body, scheduledTime, generalNotificationDetails,
        payload: notifications.payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime);
  }
}
