class LoginModel {
  final String email;
  final String password;

  LoginModel(this.email, this.password);

  Map<String, dynamic> toJson() => {'username': email, "password": password};
}
