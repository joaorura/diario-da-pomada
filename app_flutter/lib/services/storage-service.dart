import 'dart:convert';

import 'package:app_flutter/models/calendar-model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? tokenDefault;

class StorageService {
  static const TimeOfDay DefaultTimeNotifcation = TimeOfDay(hour: 9, minute: 0);

  Future<String?> getToken() async {
    if (tokenDefault == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      tokenDefault = prefs.getString('token');
    }

    return tokenDefault;
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('token', token);
    tokenDefault = token;
  }

  Future<void> setTimeNotification(int hour, int minute) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("notifications-hour", hour);
    prefs.setInt("notifications-minute", minute);
  }

  void setDefaultTimeNotification() {
    setTimeNotification(
        DefaultTimeNotifcation.hour, DefaultTimeNotifcation.minute);
  }

  Future<TimeOfDay> getTimeNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int? hour = prefs.getInt("notifications-hour");
    int? minute = prefs.getInt("notifications-minute");

    if (hour == null || minute == null) {
      setDefaultTimeNotification();
      return DefaultTimeNotifcation;
    }

    TimeOfDay timeNotification = TimeOfDay(hour: hour, minute: minute);
    return timeNotification;
  }

  Future<CalendarModel> getCalendar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString("calendar");

    if (data == null) {
      return CalendarModel(null, null, false, erro: true);
    }

    return CalendarModel.fromJson(jsonDecode(data));
  }

  Future<void> setCalendar(String calendar) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("calendar", calendar);
  }

  Future<void> reload() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.reload();
  }

  Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
