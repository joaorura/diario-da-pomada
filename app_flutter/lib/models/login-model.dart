class LoginModel {
  String email;
  String password;
  bool obscure;

  LoginModel();

  Map<String, dynamic> toJson() => {'username': email, "password": password};
}
