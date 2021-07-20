import 'dart:convert';

class CalendarModel {
  final Map<DateTime, List<String>> events, holidays;
  final bool newCalendar;
  bool erro = false;

  CalendarModel(this.events, this.holidays, this.newCalendar, {this.erro});

  static Map<DateTime, List<String>> _convert(data, String value) {
    List<String> listString = jsonDecode(data);
    Map<DateTime, List<String>> result = new Map();

    for (var item in listString) {
      DateTime data = DateTime.parse(item);
      result.addAll({
        data: [value]
      });
    }

    return result;
  }

  CalendarModel.fromJson(Map<String, dynamic> json)
      : events = _convert(json['acompanhamento'], "acompanhamento"),
        holidays = _convert(json['semanal'], "semanal"),
        newCalendar = json['newCalendar'];
}
