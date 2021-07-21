import 'package:app_flutter/pages/default-page/default-page.dart';
import 'package:app_flutter/pages/login-page/base-page.dart';
import 'package:app_flutter/pages/login-page/button-camp.dart';
import 'package:app_flutter/pages/login-page/camp-text.dart';
import 'package:app_flutter/pages/login-page/logo-login.dart';
import 'package:app_flutter/pages/login-page/sigup-page.dart';
import 'package:app_flutter/models/login-model.dart';
import 'package:app_flutter/services/login-service.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  final NotificationService notificationService;
  final LoginModel loginModel;

  LoginPage(this.notificationService, {Key key, this.loginModel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginModel _loginModel;

  void sendForm() async {
    if (_formKey.currentState.validate()) {
      LoginService loginService = new LoginService();
      if (await loginService.login(_loginModel, widget.notificationService)) {
        goPageWithoutBack(
            context, () => DefaultPage(widget.notificationService))();
      } else {
        showSnackBar(context, "Erro ao realizar login.");
      }
    }
  }

  void initState() {
    if (widget.loginModel == null) {
      _loginModel = LoginModel();
      _loginModel.obscure = true;
    } else {
      _loginModel = widget.loginModel;
    }

    super.initState();
  }

  void _toggle() {
    _loginModel.obscure = !_loginModel.obscure;
    goPageWithoutBack(context,
        () => LoginPage(widget.notificationService, loginModel: _loginModel))();
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
                _loginModel.email = email;
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
              dataCamp: _loginModel.email,
            ),
            Container(
              child: Column(
                children: [
                  CampText(
                    "Senha",
                    (String password) => _loginModel.password = password,
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
                    dataCamp: _loginModel.password,
                    icon: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: const Icon(Icons.lock)),
                    obcure: _loginModel.obscure,
                  ),
                  TextButton(
                      onPressed: _toggle,
                      child: new Text(
                          _loginModel.obscure ? "Exibir" : "Esconder",
                          style: TextStyle(color: Colors.white)))
                ],
              ),
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
