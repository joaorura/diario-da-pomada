import 'package:app_flutter/calendar-page/accompaniment-page.dart';
import 'package:app_flutter/calendar-page/week-page.dart';
import 'package:app_flutter/utils/material-app-custom.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarPage();
}

class _CalendarPage extends State<CalendarPage> {
  CalendarController _calendarController;
  Map<DateTime, List<String>> _events = Map<DateTime, List<String>>();
  Map<DateTime, List<String>> _holidays = Map<DateTime, List<String>>();

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Map<DateTime, List<String>> _createEvents() {
    return {
      DateTime(2021, 3, 12): ['semanal']
    };
  }

  Map<DateTime, List<String>> _createHolidays() {
    return {
      DateTime(2021, 3, 11): ['acompanhamento']
    };
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
        goPageWithBack(context,
            () => MaterialAppCustom(AccompanimentPage(), 'Acompanhamento'))();
        break;

      case 'semanal':
        goPageWithBack(
            context, () => MaterialAppCustom(WeekPage(), 'Semanal'))();
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        child: TableCalendar(
      events: _events,
      holidays: _holidays,
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
    )));
  }
}
