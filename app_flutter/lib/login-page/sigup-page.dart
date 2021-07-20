import 'package:app_flutter/calendar-page/calendar-page.dart';
import 'package:app_flutter/configuration-page/configuration-page.dart';
import 'package:app_flutter/login-page/base-page.dart';
import 'package:app_flutter/login-page/button-camp.dart';
import 'package:app_flutter/login-page/camp-text.dart';
import 'package:app_flutter/login-page/logo-login.dart';
import 'package:app_flutter/models/signup-model.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/services/signup-service.dart';
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
  final bool edit;

  SignupPage(this.notificationService, {Key key, this.previousData, this.edit})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupModel _data;
  String _secondPassword;
  bool _edit;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.previousData == null) {
      _data = SignupModel("", DateTime.now(), "", "", "", "");
    } else {
      _data = widget.previousData;
    }
    _edit = widget.edit != null && widget.edit;

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
      SignupService service = new SignupService();
      if (_edit) {
        if (await service.attUser(_data)) {
          showSnackBar(context, "Falha ao atualizar o cadastro.");
        } else {
          showSnackBar(context, "Cadastro atualizado.");
        }

        goPageWithoutBack(
            context, () => ConfigurationPage(widget.notificationService))();
      } else {
        if (await service.signUp(_data)) {
          goPageWithoutBack(
              context, () => CalendarPage(widget.notificationService))();
        } else {
          showSnackBar(context, "Falha ao realizar o cadastro.");
        }
      }
    }
  }

  Widget buildFuture(BuildContext context) {
    Widget editText;

    if (_edit) {
      editText = Container(
          padding: EdgeInsetsDirectional.only(bottom: 30),
          child: Text("Atualizando Cadastro",
              style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)));
    } else {
      editText = Container();
    }

    return BasePage(children: [
      LogonLogin(),
      Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: () {
            Form.of(primaryFocus.context).save();
          },
          child: Column(children: [
            editText,
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
                  if (_data.password != _secondPassword) {
                    return "Senhas digitadas não são iguais.";
                  }
                  return null;
                } else {
                  return 'Senha não nos conformes.';
                }
              },
              dataCamp: _data.password,
              obcure: true,
            ),
            CampText(
              "Repita a senha",
              (String password) => _secondPassword = password,
              inputs: [new LengthLimitingTextInputFormatter(128)],
              validate: (value) {
                if (RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                    .hasMatch(value)) {
                  if (_data.password != _secondPassword) {
                    return "Senhas digitadas não são iguais.";
                  }
                  return null;
                } else {
                  return 'Senha não nos conformes.';
                }
              },
              dataCamp: _data.password,
              obcure: true,
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

  @override
  Widget build(BuildContext context) {
    if (_edit) {
      SignupService service = new SignupService();

      return FutureBuilder(
          future: service.getUser(),
          builder: (context, data) {
            if (data.hasData) {
              if (data.data == null) {
                showSnackBar(context, "Error ao carregar dados do usuário.");
                goPageWithoutBack(
                    context, () => CalendarPage(widget.notificationService))();
              }
              this._data = data.data;
              return buildFuture(context);
            } else {
              return Container();
            }
          });
    } else {
      return buildFuture(context);
    }
  }
}
