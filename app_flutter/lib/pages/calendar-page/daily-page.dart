import 'package:app_flutter/pages/default-page/default-page.dart';
import 'package:app_flutter/pages/login-page/button-camp.dart';
import 'package:app_flutter/models/daily-question-model.dart';
import 'package:app_flutter/services/daily-question-service.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyPage extends StatefulWidget {
  final NotificationService notificationService;
  final DateTime dataMarcacao;

  DailyPage(this.notificationService, this.dataMarcacao, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  DailyQuestionModel _dailyQuestionModel = DailyQuestionModel();
  final _formKey = GlobalKey<FormState>();

  void sendForm() async {
    DailyQuestionService dailyQuestionService = DailyQuestionService();
    _dailyQuestionModel.dataDePreenchimento = DateTime.now();
    _dailyQuestionModel.dataDeMarcacao = widget.dataMarcacao;
    if (await dailyQuestionService.save(_dailyQuestionModel)) {
      showSnackBar(context, "Questões enviadas!");
      goPageWithoutBack(
          context, () => DefaultPage(widget.notificationService))();
    } else {
      showSnackBar(context, "Falha ao enviar questões");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: () {
          Form.of(primaryFocus.context).save();
        },
        child: SingleChildScrollView(
            child: Column(
                children: [
              Column(
                children: [
                  Container(
                      child: Text(
                        'Conseguiu usar a pomada',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 22,
                            decoration: TextDecoration.none),
                      ),
                      margin: EdgeInsets.only(top: 20, bottom: 20)),
                  RadioListTile<bool>(
                      value: true,
                      groupValue: _dailyQuestionModel.usouPomada,
                      onChanged: (value) {
                        setState(() {
                          _dailyQuestionModel.usouPomada = value;
                        });
                      },
                      title: Text('Sim',
                          style: GoogleFonts.notoSans(
                              color: Colors.black,
                              fontSize: 19,
                              decoration: TextDecoration.none))),
                  RadioListTile<bool>(
                      value: false,
                      groupValue: _dailyQuestionModel.usouPomada,
                      onChanged: (value) {
                        setState(() {
                          _dailyQuestionModel.usouPomada = value;
                        });
                      },
                      title: Text('Não, qual o motivo?',
                          style: GoogleFonts.notoSans(
                              color: Colors.black,
                              fontSize: 19,
                              decoration: TextDecoration.none))),
                  (_dailyQuestionModel.usouPomada == null ||
                          _dailyQuestionModel.usouPomada
                      ? Container()
                      : Container(
                          child: TextField(
                            onChanged: (value) =>
                                _dailyQuestionModel.motivoNaoUsar = value,
                            decoration: InputDecoration(
                              hintText:
                                  "Qual foi o motivo, para não ter usado?",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.grey)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.pink),
                              ),
                            ),
                          ),
                          margin: EdgeInsets.only(left: 40, right: 40)))
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonCamp(
                      theText: "Enviar Questões", onPressed: sendForm))
            ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center)));
  }
}
