class CalendarModel {
  final Map<DateTime, List<String>>? events, holidays;
  final bool? isNew;
  bool? erro = false;

  CalendarModel(this.events, this.holidays, this.isNew, {this.erro});

  static Map<DateTime, List<String>> _convert(
      List<dynamic> data, String value) {
    Map<DateTime, List<String>> result = new Map();
    for (var item in data) {
      DateTime data = DateTime.parse(item.toString());
      result.addAll({
        data: [value]
      });
    }

    return result;
  }

  CalendarModel.fromJson(Map<String, dynamic> json)
      : events = _convert(json['daily'], "daily"),
        holidays = _convert(json['weekly'], "weekly"),
        isNew = false;
}
