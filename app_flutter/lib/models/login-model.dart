class LoginModel {
  String login;
  String password;
  bool obscure;

  LoginModel();

  Map<String, dynamic> toJson() => {'username': login, "password": password};
}
