import 'package:app_flutter/login-page/base-page.dart';
import 'package:app_flutter/login-page/button-camp.dart';
import 'package:app_flutter/login-page/camp-text.dart';
import 'package:app_flutter/login-page/logo-login.dart';
import 'package:app_flutter/models/sigin-model.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/services/sigin-service.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login-page.dart';

class SiginPage extends StatefulWidget {
  final NotificationService notificationService;
  SiginPage(this.notificationService, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SiginPage();
}

class _SiginPage extends State<SiginPage> {
  final SiginService siginService = SiginService();
  String login, password;

  void sendForm() {
    SiginModel siginModel = SiginModel(login, password);
    siginService.sigin(siginModel);
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
      Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ButtonCamp(
                  theText: "Já tem uma Conta?",
                  onPressed: goPageWithoutBack(
                      context, () => LoginPage(widget.notificationService))),
              ButtonCamp(theText: "Confirmar Cadastro", onPressed: sendForm)
            ],
          )),
    ]);
  }
}
