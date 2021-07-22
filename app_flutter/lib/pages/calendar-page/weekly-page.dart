import 'package:app_flutter/pages/default-page/default-page.dart';
import 'package:app_flutter/pages/login-page/button-camp.dart';
import 'package:app_flutter/models/week-question-model.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/services/week-question-service.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_field/date_field.dart';

class WeeklyPage extends StatefulWidget {
  final NotificationService notificationService;
  final DateTime dataMarcacao;

  WeeklyPage(this.notificationService, this.dataMarcacao, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeeklyPageState();
}

class _WeeklyPageState extends State<WeeklyPage> {
  WeekQuestionModel _weekQuestionModel;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _weekQuestionModel = new WeekQuestionModel();
    super.initState();
  }

  void sendForm() async {
    if (_formKey.currentState.validate()) {
      WeekQuestionService weekQuestionService = WeekQuestionService();
      _weekQuestionModel.dataDePreenchimento = DateTime.now();
      _weekQuestionModel.dataDeMarcacao = widget.dataMarcacao;
      if (!_weekQuestionModel.validate()) {
        showSnackBar(context, "Preencha todas as questões.");
        return;
      }

      _weekQuestionModel.removeAllOther();
      if (await weekQuestionService.save(_weekQuestionModel)) {
        showSnackBar(context, "Fórmulario enviado.");

        goPageWithoutBack(
            context, () => DefaultPage(widget.notificationService))();
      } else {
        showSnackBar(context, "Erro ao enviar formulário.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        onChanged: () {
          FormState form = Form.of(primaryFocus.context);

          if (form != null) {
            form.save();
          }
        },
        child: SingleChildScrollView(
            child: Container(
                child: Column(
          children: [
            Column(
              children: [
                Container(
                    child: Text(
                      'Teve Alguma Dificuldade Na Introdução',
                      style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 22,
                          decoration: TextDecoration.none),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 20, left: 20)),
                RadioListTile<bool>(
                    value: true,
                    groupValue: _weekQuestionModel.dificuldadeIntroducao,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.dificuldadeIntroducao = value;
                      });
                    },
                    title: Text('Sim',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                RadioListTile<bool>(
                    value: false,
                    groupValue: _weekQuestionModel.dificuldadeIntroducao,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.dificuldadeIntroducao = value;
                      });
                    },
                    title: Text('Não',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none)))
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Column(
              children: [
                Container(
                    child: Text(
                      'Seguiu a remomendação de aplicar na hora de dormir e após relações sexuais?',
                      style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 22,
                          decoration: TextDecoration.none),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 20, left: 20)),
                RadioListTile<bool>(
                    value: true,
                    groupValue: _weekQuestionModel.aplicouDormirSexo,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.aplicouDormirSexo = value;
                      });
                    },
                    title: Text('Sim',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                RadioListTile<bool>(
                    value: false,
                    groupValue: _weekQuestionModel.aplicouDormirSexo,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.aplicouDormirSexo = value;
                      });
                    },
                    title: Text('Não',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none)))
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Column(
              children: [
                Container(
                    child: Text(
                      'Sentiu algum incomodo?',
                      style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 22,
                          decoration: TextDecoration.none),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 20, left: 20)),
                RadioListTile<bool>(
                    value: false,
                    groupValue: _weekQuestionModel.sentiuIncomodo,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.sentiuIncomodo = value;
                      });
                    },
                    title: Text('Não',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                RadioListTile<bool>(
                    value: true,
                    groupValue: _weekQuestionModel.sentiuIncomodo,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.sentiuIncomodo = value;
                      });
                    },
                    title: Text('Sim, qual?',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                (_weekQuestionModel.sentiuIncomodo == null ||
                        !_weekQuestionModel.sentiuIncomodo
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(bottom: 20, left: 40),
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    top: 20, bottom: 20, left: 20)),
                            RadioListTile<String>(
                                value: 'Ardência',
                                groupValue: _weekQuestionModel.tipoIncomodo,
                                onChanged: (value) {
                                  setState(() {
                                    _weekQuestionModel.tipoIncomodo = value;
                                  });
                                },
                                title: Text('Ardência',
                                    style: GoogleFonts.notoSans(
                                        color: Colors.black,
                                        fontSize: 19,
                                        decoration: TextDecoration.none))),
                            RadioListTile<String>(
                                value: 'Inchaço',
                                groupValue: _weekQuestionModel.tipoIncomodo,
                                onChanged: (value) {
                                  setState(() {
                                    _weekQuestionModel.tipoIncomodo = value;
                                  });
                                },
                                title: Text('Inchaço',
                                    style: GoogleFonts.notoSans(
                                        color: Colors.black,
                                        fontSize: 19,
                                        decoration: TextDecoration.none))),
                            RadioListTile<String>(
                                value: 'Vermelhidão',
                                groupValue: _weekQuestionModel.tipoIncomodo,
                                onChanged: (value) {
                                  setState(() {
                                    _weekQuestionModel.tipoIncomodo = value;
                                  });
                                },
                                title: Text('Vermelhidão',
                                    style: GoogleFonts.notoSans(
                                        color: Colors.black,
                                        fontSize: 19,
                                        decoration: TextDecoration.none))),
                            RadioListTile<String>(
                                value: 'Coceira',
                                groupValue: _weekQuestionModel.tipoIncomodo,
                                onChanged: (value) {
                                  setState(() {
                                    _weekQuestionModel.tipoIncomodo = value;
                                  });
                                },
                                title: Text('Coceira',
                                    style: GoogleFonts.notoSans(
                                        color: Colors.black,
                                        fontSize: 19,
                                        decoration: TextDecoration.none))),
                            RadioListTile<String>(
                                value: 'Outros',
                                groupValue: _weekQuestionModel.tipoIncomodo,
                                onChanged: (value) {
                                  setState(() {
                                    _weekQuestionModel.tipoIncomodo = value;
                                  });
                                },
                                title: Text('Outros',
                                    style: GoogleFonts.notoSans(
                                        color: Colors.black,
                                        fontSize: 19,
                                        decoration: TextDecoration.none))),
                            (_weekQuestionModel.tipoIncomodo == null ||
                                    _weekQuestionModel.tipoIncomodo != 'Outros'
                                ? Container()
                                : Container(
                                    child: TextFormField(
                                      onSaved: (value) {
                                        setState(() {
                                          _weekQuestionModel.outroTipoIncomodo =
                                              value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Incomodo...",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black),
                                        enabledBorder: new UnderlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.grey)),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.pink),
                                        ),
                                      ),
                                    ),
                                    margin:
                                        EdgeInsets.only(left: 50, right: 40)))
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                      ))
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Column(
              children: [
                Container(
                    child: Text(
                      'Como a calcinha ficou suja?',
                      style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 22,
                          decoration: TextDecoration.none),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 20, left: 20)),
                RadioListTile<String>(
                    value: 'Pastosa',
                    groupValue: _weekQuestionModel.tipoSujeiraCalcinha,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.tipoSujeiraCalcinha = value;
                      });
                    },
                    title: Text('Pastosa',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                RadioListTile<String>(
                    value: 'Líquida',
                    groupValue: _weekQuestionModel.tipoSujeiraCalcinha,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.tipoSujeiraCalcinha = value;
                      });
                    },
                    title: Text('Líquida',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                RadioListTile<String>(
                    value: 'Grumosa',
                    groupValue: _weekQuestionModel.tipoSujeiraCalcinha,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.tipoSujeiraCalcinha = value;
                      });
                    },
                    title: Text('Grumosa',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                RadioListTile<String>(
                    value: 'Outra',
                    groupValue: _weekQuestionModel.tipoSujeiraCalcinha,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.tipoSujeiraCalcinha = value;
                      });
                    },
                    title: Text('Outra',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                (_weekQuestionModel.tipoSujeiraCalcinha == null ||
                        _weekQuestionModel.tipoSujeiraCalcinha != 'Outra'
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(left: 50, right: 40),
                        child: TextFormField(
                          onSaved: (value) {
                            setState(() {
                              _weekQuestionModel.outroTipoSujeiraCalcinha =
                                  value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Sujeira...",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink),
                            ),
                          ),
                        ))),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Column(
              children: [
                Container(
                    child: Text(
                      'Que cor fica na calcinha??',
                      style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 22,
                          decoration: TextDecoration.none),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 20, left: 20)),
                RadioListTile<String>(
                    value: 'Amarronzada',
                    groupValue: _weekQuestionModel.tipoCorResiduoCalcinha,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.tipoCorResiduoCalcinha = value;
                      });
                    },
                    title: Text('Amarronzada',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                RadioListTile<String>(
                    value: 'Amarelada',
                    groupValue: _weekQuestionModel.tipoCorResiduoCalcinha,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.tipoCorResiduoCalcinha = value;
                      });
                    },
                    title: Text('Amarelada',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                RadioListTile<String>(
                    value: 'Esverdeada',
                    groupValue: _weekQuestionModel.tipoCorResiduoCalcinha,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.tipoCorResiduoCalcinha = value;
                      });
                    },
                    title: Text('Esverdeada',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                RadioListTile<String>(
                    value: 'Outra',
                    groupValue: _weekQuestionModel.tipoCorResiduoCalcinha,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.tipoCorResiduoCalcinha = value;
                      });
                    },
                    title: Text('Outra',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                (_weekQuestionModel.tipoCorResiduoCalcinha == null ||
                        _weekQuestionModel.tipoCorResiduoCalcinha != 'Outra')
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(left: 50, right: 40),
                        child: TextFormField(
                          onSaved: (value) {
                            setState(() {
                              _weekQuestionModel.outroTipoCorResiduoCalcinha =
                                  value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Cor...",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink),
                            ),
                          ),
                        )),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Column(
              children: [
                Container(
                    child: Text(
                      'Percebeu saída de sangue?',
                      style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 22,
                          decoration: TextDecoration.none),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 20, left: 20)),
                RadioListTile<bool>(
                    value: true,
                    groupValue: _weekQuestionModel.sanguePresente,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.sanguePresente = value;
                      });
                    },
                    title: Text('Sim',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                RadioListTile<bool>(
                    value: false,
                    groupValue: _weekQuestionModel.sanguePresente,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.sanguePresente = value;
                      });
                    },
                    title: Text('Não',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none)))
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Column(
              children: [
                Container(
                    child: Text(
                      'Dificultou na relação sexual?',
                      style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 22,
                          decoration: TextDecoration.none),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 20, left: 20)),
                RadioListTile<bool>(
                    value: false,
                    groupValue: _weekQuestionModel.dificuldadeSexo,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.dificuldadeSexo = value;
                      });
                    },
                    title: Text('Não',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                RadioListTile<bool>(
                    value: true,
                    groupValue: _weekQuestionModel.dificuldadeSexo,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.dificuldadeSexo = value;
                      });
                    },
                    title: Text('Sim, como?',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                (_weekQuestionModel.dificuldadeSexo == null ||
                        !_weekQuestionModel.dificuldadeSexo
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(left: 50, right: 40),
                        child: TextFormField(
                          onSaved: (value) {
                            setState(() {
                              _weekQuestionModel.tipoDificuldadeSexo = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Causou...",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink),
                            ),
                          ),
                        )))
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Column(
              children: [
                Container(
                    child: Text(
                      'Menstruou por essses dias?',
                      style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 22,
                          decoration: TextDecoration.none),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 20, left: 20)),
                RadioListTile<bool>(
                    value: false,
                    groupValue: _weekQuestionModel.menstruouRecentemente,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.menstruouRecentemente = value;
                      });
                    },
                    title: Text('Não',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                RadioListTile<bool>(
                    value: true,
                    groupValue: _weekQuestionModel.menstruouRecentemente,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.menstruouRecentemente = value;
                      });
                    },
                    title: Text('Sim, Quando?',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                (_weekQuestionModel.menstruouRecentemente == null ||
                        !_weekQuestionModel.menstruouRecentemente
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(left: 50, right: 40),
                        child: DateTimeFormField(
                          onSaved: (value) {
                            setState(() {
                              _weekQuestionModel.dataMenstruacao = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.event_note),
                            labelText: 'Data da menstruação',
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (e) {
                            if (e == null) {
                              return 'Data precisa ser preenchida.';
                            }

                            if (e != null && e.isBefore(DateTime.now())) {
                              return null;
                            } else {
                              return 'Data precisa ser menor do que a de hoje.';
                            }
                          },
                        )))
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Column(
              children: [
                Container(
                    child: Text(
                      'A menstruação foi como antes?',
                      style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 22,
                          decoration: TextDecoration.none),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 20, left: 20)),
                RadioListTile<bool>(
                    value: true,
                    groupValue: _weekQuestionModel.mestruacaoIgualAnterior,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.mestruacaoIgualAnterior = value;
                      });
                    },
                    title: Text('Sim',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                RadioListTile<bool>(
                    value: false,
                    groupValue: _weekQuestionModel.mestruacaoIgualAnterior,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.mestruacaoIgualAnterior = value;
                      });
                    },
                    title: Text('Não, qual a diferença?',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                (_weekQuestionModel.mestruacaoIgualAnterior == null ||
                        _weekQuestionModel.mestruacaoIgualAnterior
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(left: 50, right: 40),
                        child: TextFormField(
                          onSaved: (value) {
                            setState(() {
                              _weekQuestionModel.tipoMestruacaoDiferente =
                                  value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Foi...",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink),
                            ),
                          ),
                        )))
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Column(
              children: [
                Container(
                    child: Text(
                      'Parou o uso por algum motivo?',
                      style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 22,
                          decoration: TextDecoration.none),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 20, left: 20)),
                RadioListTile<bool>(
                    value: false,
                    groupValue: _weekQuestionModel.parouUso,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.parouUso = value;
                      });
                    },
                    title: Text('Não',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                RadioListTile<bool>(
                    value: true,
                    groupValue: _weekQuestionModel.parouUso,
                    onChanged: (value) {
                      setState(() {
                        _weekQuestionModel.parouUso = value;
                      });
                    },
                    title: Text('Sim, porque?',
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 19,
                            decoration: TextDecoration.none))),
                (_weekQuestionModel.parouUso == null ||
                        !_weekQuestionModel.parouUso
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(left: 50, right: 40),
                        child: TextFormField(
                          onSaved: (value) {
                            setState(() {
                              _weekQuestionModel.motivoParadaUso = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Causou...",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink),
                            ),
                          ),
                        )))
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child:
                    ButtonCamp(theText: "Enviar Questões", onPressed: sendForm))
          ],
        ))));
  }
}
