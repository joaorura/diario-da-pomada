class LoginModel {
  String? login;
  String? password;
  bool? obscure;

  LoginModel(this.login, this.password, this.obscure);

  Map<String, dynamic> toJson() => {'username': login, "password": password};
}
