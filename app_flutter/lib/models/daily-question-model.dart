import 'package:intl/intl.dart';

class DailyQuestionModel {
  bool usouPomada;
  String motivoNaoUsar;
  DateTime dataAtual;

  DailyQuestionModel();

  Map<String, dynamic> toJson() => {
        'usouPomada': usouPomada,
        'motivoNaoUsar': motivoNaoUsar,
        "dataAtual": DateFormat('yyyy-MM-dd').format(dataAtual)
      };
}
