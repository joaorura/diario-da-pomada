class CsvModel {
  String dataCsv;

  CsvModel.fromJson(Map<String, dynamic> json) : dataCsv = json['report'];
}
