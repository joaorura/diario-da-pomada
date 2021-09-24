import 'dart:async';

import 'package:app_flutter/pages/calendar-page/daily-page.dart';
import 'package:app_flutter/pages/calendar-page/weekly-page.dart';
import 'package:app_flutter/models/calendar-model.dart';
import 'package:app_flutter/services/calendar-service.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/utils/material-app-custom.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  final NotificationService notificationService;
  final bool? answer;
  final CalendarModel? testData;

  CalendarPage(this.notificationService, {Key? key, this.answer, this.testData})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarPageState(answer);
}

class Event {
  final String title;

  Event(this.title);

  String toString() => this.title;
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  bool answer = false;

  _CalendarPageState(bool? answerRec) {
    if (answerRec != null) {
      answer = answerRec;
    }
  }
  void _onDaySelected(DateTime day, Map<DateTime, List<String>>? mapEvents,
      Map<DateTime, List<String>>? holidays) {
    int typeDay;

    if (!isSameDay(day, _selectedDay)) {
      setState(() {
        _selectedDay = day;
      });
    }

    day = DateTime(day.year, day.month, day.day);

    if (holidays!.containsKey(day)) {
      typeDay = 0;
    } else if (mapEvents!.containsKey(day)) {
      typeDay = 1;
    } else {
      typeDay = 2;
    }

    if (answer && DateTime.now().isBefore(day)) {
      return;
    }

    switch (typeDay) {
      case 0:
        goPageWithBack(
            context,
            () => MaterialAppCustom(
                WeeklyPage(widget.notificationService, day), 'Semanal'))();
        break;

      case 1:
        goPageWithBack(
            context,
            () => MaterialAppCustom(DailyPage(widget.notificationService, day),
                'Acompanhamento'))();
        break;

      default:
        break;
    }
  }

  List<Event> _eventLoader(
      Map<DateTime, List<String>>? mapEvents, DateTime dateTime) {
    List<Event> result = [];

    if (mapEvents == null) {
      return result;
    }

    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if (mapEvents.containsKey(dateTime)) {
      for (String data in mapEvents[dateTime]!) {
        result.add(Event(data));
      }
    }

    return result;
  }

  bool _holidayPredicate(
      Map<DateTime, List<String>>? holidays, DateTime dateTime) {
    if (holidays == null) {
      return false;
    }

    return holidays
        .containsKey(DateTime(dateTime.year, dateTime.month, dateTime.day));
  }

  Widget buildFuture(BuildContext context, AsyncSnapshot<CalendarModel> data) {
    if ((data.data?.erro) as bool) {
      WidgetsBinding.instance?.addPostFrameCallback(
          (_) => showSnackBar(context, "Erro de conexão."));
    }

    return TableCalendar(
      firstDay: DateTime.now().subtract(Duration(days: 365)),
      lastDay: DateTime.now().add(Duration(days: 365)),
      focusedDay: _selectedDay,
      eventLoader: (DateTime date) => _eventLoader(data.data?.events, date),
      holidayPredicate: (DateTime date) =>
          _holidayPredicate(data.data?.holidays, date),
      weekendDays: [],
      calendarStyle: CalendarStyle(
          selectedTextStyle: TextStyle(color: Colors.white),
          selectedDecoration: BoxDecoration(
            color: Colors.pink[300],
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(color: Colors.pink[200]),
          markerDecoration:
              BoxDecoration(color: Colors.red[900], shape: BoxShape.circle),
          outsideDaysVisible: false,
          holidayTextStyle:
              TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
          holidayDecoration: BoxDecoration(
              color: Colors.red[500]!.withAlpha(150), shape: BoxShape.circle)),
      headerStyle: HeaderStyle(
        titleTextStyle: GoogleFonts.notoSans(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none),
        formatButtonTextStyle: TextStyle(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.pink[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      locale: 'pt_br',
      availableCalendarFormats: const {
        CalendarFormat.month: 'Mês',
      },
      calendarFormat: CalendarFormat.month,
      currentDay: _selectedDay,
      selectedDayPredicate: (DateTime day) => isSameDay(day, _selectedDay),
      onDaySelected: (DateTime selected, DateTime focused) =>
          _onDaySelected(selected, data.data!.events, data.data!.holidays),
    );
  }

  @override
  Widget build(BuildContext context) {
    CalendarService calendarService = CalendarService();

    Future<CalendarModel> futureCalendarModel;

    if (widget.testData == null) {
      futureCalendarModel = calendarService.getCalendar(
          notificationService: widget.notificationService);
    } else {
      futureCalendarModel = () async {
        return widget.testData!;
      }();
    }

    return FutureBuilder(
        future: futureCalendarModel,
        initialData: CalendarModel(null, null, false, erro: false),
        builder: buildFuture);
  }
}
