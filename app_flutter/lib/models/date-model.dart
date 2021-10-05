import 'package:intl/intl.dart';

class DateNowModel {
  final DateTime date;

  DateNowModel(this.date);

  Map<String, dynamic> toJson() =>
      {'currentDate': DateFormat('yyyy-MM-dd').format(date)};
}
