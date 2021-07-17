import 'package:app_flutter/default-page/default-page.dart';
import 'package:app_flutter/login-page/base-page.dart';
import 'package:app_flutter/login-page/button-camp.dart';
import 'package:app_flutter/login-page/camp-text.dart';
import 'package:app_flutter/login-page/logo-login.dart';
import 'package:app_flutter/login-page/sigup-page.dart';
import 'package:app_flutter/models/login-model.dart';
import 'package:app_flutter/services/login-service.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  final NotificationService notificationService;
  LoginPage(this.notificationService, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String email, password;
  final _formKey = GlobalKey<FormState>();

  void sendForm() async {
    if (_formKey.currentState.validate()) {
      LoginService loginService = new LoginService();
      LoginModel loginModel = new LoginModel(email, password);

      if (await loginService.login(loginModel)) {
        goPageWithoutBack(
            context, () => DefaultPage(widget.notificationService))();
      } else {
        showSnackBar(context, "Erro ao realizar login.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(children: [
      LogonLogin(),
      Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          onChanged: () {
            Form.of(primaryFocus.context).save();
          },
          child: Column(children: [
            CampText(
              "Email",
              (String email) {
                this.email = email;
              },
              inputs: [new LengthLimitingTextInputFormatter(128)],
              validate: (value) {
                if (RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return null;
                } else {
                  return 'Email não nos conformes.';
                }
              },
            ),
            CampText(
              "Senha",
              (String password) => this.password = password,
              inputs: [new LengthLimitingTextInputFormatter(128)],
              validate: (value) {
                if (RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                    .hasMatch(value)) {
                  return null;
                } else {
                  return 'Senha não nos conformes.';
                }
              },
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    ButtonCamp(
                        theText: "Crie uma conta!",
                        onPressed: goPageWithoutBack(context,
                            () => SignupPage(widget.notificationService))),
                    ButtonCamp(theText: "Entrar", onPressed: sendForm)
                  ],
                ))
          ])),
    ]);
  }
}
