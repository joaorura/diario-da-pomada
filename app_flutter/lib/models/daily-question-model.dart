import 'package:intl/intl.dart';

class DailyQuestionModel {
  bool? usouPomada;
  String? motivoNaoUsar;
  DateTime? dataDeMarcacao;
  DateTime? dataDePreenchimento;

  DailyQuestionModel();

  Map<String, dynamic> toJson() => {
        'usouPomada': usouPomada,
        'motivoNaoUsar': motivoNaoUsar,
        "dataDeMarcacao":
            DateFormat('yyyy-MM-dd').format(dataDeMarcacao as DateTime),
        "dataDePreenchimento":
            DateFormat('yyyy-MM-dd').format(dataDePreenchimento as DateTime)
      };
}
