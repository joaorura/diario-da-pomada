import 'package:intl/intl.dart';

class SignupModel {
  String email;
  DateTime birthDate;
  String fullName;
  String password;
  String heathCard;
  String nationalCard;

  SignupModel(this.email, this.birthDate, this.fullName, this.heathCard,
      this.password, this.nationalCard);

  Map<String, dynamic> toJson() => {
        "email": email,
        "birthDate": DateFormat('yyyy-MM-dd').format(birthDate),
        "fullName": fullName,
        "password": password,
        "healthCard": heathCard,
        "nationalCard": nationalCard
      };
}
