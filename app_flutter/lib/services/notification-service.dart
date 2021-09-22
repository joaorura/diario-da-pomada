import 'package:app_flutter/main.dart';
import 'package:app_flutter/models/calendar-model.dart';
import 'package:app_flutter/models/notification-model.dart';
import 'package:app_flutter/services/calendar-service.dart';
import 'package:app_flutter/services/storage-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  FlutterLocalNotificationsPlugin? fltrNotification;

  Future<dynamic> _notificationSelected(String? payload) async {
    runApp(MyHomePage());
  }

  NotificationService() {
    var androidInitilize = new AndroidInitializationSettings('ic_launcher');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);

    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification!.initialize(initilizationsSettings,
        onSelectNotification: _notificationSelected);
  }

  void scheduleNotification(
      NotificationModel notifications, DateTime scheduledTime) async {
    if (scheduledTime.isBefore(DateTime.now())) {
      return;
    }

    var androidDetails = new AndroidNotificationDetails(
        "Diário da Pomada", "Diário da Pomada", "Diário da Pomada",
        importance: Importance.high);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    String timeZoneName = await timeZone.getTimeZoneName();
    final location = await timeZone.getLocation(timeZoneName);

    final scheduledDate = tz.TZDateTime.from(scheduledTime, location);

    fltrNotification!.zonedSchedule(notifications.id!, notifications.title,
        notifications.body, scheduledDate, generalNotificationDetails,
        payload: notifications.payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime);
  }

  int _mapNotifications(Map<DateTime, List<String>> mapData, String tipo,
      TimeOfDay timeNotification, int id) {
    for (var item in mapData.entries) {
      DateTime date = item.key;
      date = date.add(Duration(
          hours: timeNotification.hour, minutes: timeNotification.minute));

      scheduleNotification(
          NotificationModel(
              id: id,
              title: "Hora de realizar seu questionário!",
              body:
                  "O questionário $tipo do dia: ${item.key.day}/${item.key.month}",
              payload: ""),
          date);
      id += 1;
    }

    return id;
  }

  Future<void> attNotifications(
      {CalendarModel? calendarModel, TimeOfDay? timeNotification}) async {
    await clearAll();

    StorageService storageService = new StorageService();

    if (timeNotification == null) {
      timeNotification = await storageService.getTimeNotification();
    }

    if (calendarModel == null) {
      CalendarService calendarService = new CalendarService();

      calendarModel = await calendarService.getCalendar();
    }

    int id =
        _mapNotifications(calendarModel.events!, "diário", timeNotification, 1);
    _mapNotifications(calendarModel.holidays!, "semanal", timeNotification, id);
  }

  Future<void> clearAll() async {
    await fltrNotification!.cancelAll();
  }
}
