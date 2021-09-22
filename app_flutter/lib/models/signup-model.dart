import 'package:intl/intl.dart';

class SignupModel {
  String? email;
  DateTime? birthDate;
  String? fullName;
  String? password;
  String? heathCard;
  String? nationalCard;

  SignupModel(this.email, this.birthDate, this.fullName, this.heathCard,
      this.password, this.nationalCard);

  Map<String, dynamic> toJson() => {
        "email": email,
        "birthDate": DateFormat('yyyy-MM-dd').format(birthDate!),
        "fullName": fullName,
        "password": password,
        "healthCard": heathCard,
        "nationalCard": nationalCard
      };

  Map<String, dynamic> toJsonAtt() => {
        "email": email,
        "birthDate": DateFormat('yyyy-MM-dd').format(birthDate!),
        "fullName": fullName,
        "healthCard": heathCard,
        "nationalCard": nationalCard
      };

  SignupModel.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        birthDate = DateTime.parse(json['birthDate']),
        fullName = json['fullName'],
        password = json['password'],
        heathCard = json['healthCard'],
        nationalCard = json['nationalCard'];

  SignupModel.fromJsonAtt(Map<String, dynamic> json)
      : email = json['email'],
        birthDate = DateTime.parse(json['birthDate']),
        fullName = json['fullName'],
        heathCard = json['healthCard'],
        nationalCard = json['nationalCard'];
}
