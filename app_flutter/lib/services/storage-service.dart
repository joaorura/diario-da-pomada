import 'dart:convert';

import 'package:app_flutter/main.dart';
import 'package:app_flutter/models/calendar-model.dart';
import 'package:app_flutter/models/token-model.dart';
import 'package:flutter/material.dart';

String tokenDefault;

class StorageService {
  static const TimeOfDay _defaultTimeNotifcation =
      TimeOfDay(hour: 9, minute: 0);

  String getToken() {
    if (tokenDefault == null) {
      tokenDefault = prefs.getString('token');
    }

    return tokenDefault;
  }

  void saveToken(String token) {
    prefs.setString('token', token);
    tokenDefault = token;
  }

  void setTimeNotification(int hour, int minute) {
    prefs.setInt("notifications-hour", hour);
    prefs.setInt("notifications-minute", minute);
  }

  void setDefaultTimeNotification() {
    setTimeNotification(
        _defaultTimeNotifcation.hour, _defaultTimeNotifcation.minute);
  }

  TimeOfDay getTimeNotification() {
    int hour = prefs.getInt("notifications-hour");
    int minute = prefs.getInt("notifications-minute");

    if (hour == null || minute == null) {
      setDefaultTimeNotification();
      return _defaultTimeNotifcation;
    }

    TimeOfDay timeNotification = TimeOfDay(hour: hour, minute: minute);
    return timeNotification;
  }

  CalendarModel getCalendar() {
    String data = prefs.getString("calendar");

    if (data == null) {
      return CalendarModel(null, null, false, erro: true);
    }

    return CalendarModel.fromJson(jsonDecode(data));
  }

  void setCalendar(String calendar) {
    prefs.setString("calendar", calendar);
  }

  Future<void> reload() async {
    await prefs.reload();
  }

  void clearAll() {
    prefs.remove('token');
    prefs.remove('calendar');
    prefs.remove("notifications-hour");
    prefs.remove("notifications-minute");
  }
}
