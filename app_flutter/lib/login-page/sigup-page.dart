import 'package:app_flutter/default-page/default-page.dart';
import 'package:app_flutter/login-page/base-page.dart';
import 'package:app_flutter/login-page/button-camp.dart';
import 'package:app_flutter/login-page/camp-text.dart';
import 'package:app_flutter/login-page/logo-login.dart';
import 'package:app_flutter/models/signup-model.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/services/sigin-service.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cpfcnpj/cpfcnpj.dart';
import 'login-page.dart';

class SignupPage extends StatefulWidget {
  final NotificationService notificationService;
  final SignupModel previousData;

  SignupPage(this.notificationService, {Key key, this.previousData})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignupPage();
}

class _SignupPage extends State<SignupPage> {
  final Pattern patternPassword =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  SignupModel _data;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.previousData == null) {
      _data = SignupModel("", DateTime.now(), "", "", "", "");
    } else {
      _data = widget.previousData;
    }

    super.initState();
  }

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _data.birthDate,
        firstDate: DateTime.now().subtract(const Duration(days: 365000)),
        lastDate: DateTime.now());
    if (picked != null && picked != _data.birthDate) {
      _data.birthDate = picked;
      goPageWithoutBack(context,
          () => SignupPage(widget.notificationService, previousData: _data))();
    }
  }

  void sendForm() async {
    if (_formKey.currentState.validate()) {
      SiginService service = new SiginService();
      if (await service.signUp(_data)) {
        goPageWithoutBack(
            context, () => DefaultPage(widget.notificationService))();
      } else {
        showSnackBar(context, "Falha ao realizar o cadastro!");
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
                _data.email = email;
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
              dataCamp: _data.email,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                child: Text("Data de Nascimento",
                    style: GoogleFonts.notoSans(color: Colors.white)),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.1,
                margin: EdgeInsets.only(top: 20, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  child: Text(
                    UtilData.obterDataDDMMAAAA(_data.birthDate),
                    style: TextStyle(color: Colors.pink),
                  ),
                ),
              )
            ]),
            CampText(
              "Nome Completo",
              (String fullName) => _data.fullName = fullName,
              inputs: [new LengthLimitingTextInputFormatter(128)],
              dataCamp: _data.fullName,
            ),
            CampText(
              "Senha",
              (String password) => _data.password = password,
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
              dataCamp: _data.password,
            ),
            CampText(
              "Cartão do SUS",
              (String heathCard) => _data.heathCard = heathCard,
              inputs: [
                FilteringTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(15),
              ],
              dataCamp: _data.heathCard,
            ),
            CampText(
              "CPF",
              (String nationalCard) => _data.nationalCard = nationalCard,
              inputs: [
                FilteringTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(11)
              ],
              validate: (value) {
                if (CPF.isValid(value)) {
                  return null;
                } else {
                  return 'CPF Inválido.';
                }
              },
              dataCamp: _data.nationalCard,
            )
          ])),
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
