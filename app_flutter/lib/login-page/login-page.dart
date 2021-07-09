import 'package:app_flutter/default-page/default-page.dart';
import 'package:app_flutter/login-page/base-page.dart';
import 'package:app_flutter/login-page/button-camp.dart';
import 'package:app_flutter/login-page/camp-text.dart';
import 'package:app_flutter/login-page/logo-login.dart';
import 'package:app_flutter/login-page/sigin-page.dart';
import 'package:app_flutter/models/login-model.dart';
import 'package:app_flutter/services/login-service.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final NotificationService notificationService;
  LoginPage(this.notificationService, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final LoginService loginService = new LoginService();
  String login, password;

  void sendForm() {
    LoginModel loginModel = new LoginModel(login, password);
    loginService.login(loginModel);
    goPageWithoutBack(context, () => DefaultPage(widget.notificationService))();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(children: [
      LogonLogin(),
      CampText(
          nameCamp: "Login", getData: (String login) => this.login = login),
      CampText(
          nameCamp: "Senha",
          getData: (String password) => this.password = password),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonCamp(
            theText: "Cadastre-se",
            onPressed: goPageWithoutBack(
                context, () => SiginPage(widget.notificationService)),
          ),
          ButtonCamp(theText: "Login", onPressed: sendForm)
        ],
      )
    ]);
  }
}
