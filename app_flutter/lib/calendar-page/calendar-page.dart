import 'package:app_flutter/calendar-page/daily-page.dart';
import 'package:app_flutter/calendar-page/week-page.dart';
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
  CalendarPage(this.notificationService, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _calendarController = CalendarController();

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    String eventDay = events.length == 0 ? '' : events.first;
    String holidayDay = holidays.length == 0 ? '' : holidays.first;
    String typeDay;

    if (eventDay.isEmpty) {
      if (holidayDay.isEmpty) {
        return;
      } else {
        typeDay = holidayDay;
      }
    } else if (holidayDay.isEmpty) {
      typeDay = eventDay;
    } else {
      typeDay = holidayDay;
    }

    typeDay = typeDay.toLowerCase();

    switch (typeDay) {
      case 'acompanhamento':
        goPageWithBack(
            context,
            () => MaterialAppCustom(
                DailyPage(widget.notificationService), 'Acompanhamento'))();
        break;

      case 'semanal':
        goPageWithBack(
            context,
            () => MaterialAppCustom(
                WeekPage(widget.notificationService), 'Semanal'))();
        break;

      default:
        break;
    }
  }

  Widget buildFuture(BuildContext context, AsyncSnapshot<CalendarModel> data) {
    if (data.data.erro) {
      showSnackBar(context, "Erro de conexão.");
    }

    return TableCalendar(
      events: data.data.events,
      holidays: data.data.holidays,
      weekendDays: [],
      calendarStyle: CalendarStyle(
          selectedColor: Colors.pink[400],
          todayColor: Colors.pink[200],
          markersColor: Colors.red[300],
          outsideDaysVisible: false,
          eventDayStyle: TextStyle(
              fontWeight: FontWeight.w700, color: Colors.pink.shade200),
          holidayStyle: TextStyle(
              fontWeight: FontWeight.w900, color: Colors.pinkAccent.shade700)),
      headerStyle: HeaderStyle(
        titleTextStyle: GoogleFonts.notoSans(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none),
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.pink[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      calendarController: this._calendarController,
      locale: 'pt_br',
      availableCalendarFormats: const {
        CalendarFormat.month: "1 Semana",
        CalendarFormat.twoWeeks: '4 Semanas',
        CalendarFormat.week: '2 Semanas'
      },
      onDaySelected: _onDaySelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    CalendarService calendarService = CalendarService();
    Future<CalendarModel> futureCalendarModel = calendarService.getCalendar(
        notificationService: widget.notificationService);
    return FutureBuilder(
        future: futureCalendarModel,
        initialData: CalendarModel(null, null, false),
        builder: buildFuture);
  }
}
