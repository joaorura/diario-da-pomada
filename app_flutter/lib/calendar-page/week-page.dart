import 'package:app_flutter/models/question-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_field/date_field.dart';

class WeekPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeekPage();
}

class _WeekPage extends State<WeekPage> {
  List<QuestionModel> _listQuestions = []..length = 10;
  List<TextEditingController> _otherValues = []..length = 6;

  _WeekPage() {
    for (int i = 0; i < 10; i++) {
      this._listQuestions[i] = QuestionModel(null, null, null, null);
    }

    for (int i = 0; i < 6; i++) {
      this._otherValues[i] = TextEditingController();
    }
  }

  Function _onChangedQuestions(int element, int index) {
    return (value) => (setState(() {
          this._listQuestions[index].setValues(element, value);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                groupValue: this._listQuestions[0].boolResult,
                onChanged: this._onChangedQuestions(0, 0),
                title: Text('Sim',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            RadioListTile<bool>(
                value: false,
                groupValue: this._listQuestions[0].boolResult,
                onChanged: this._onChangedQuestions(0, 0),
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
                groupValue: this._listQuestions[1].boolResult,
                onChanged: this._onChangedQuestions(0, 1),
                title: Text('Sim',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            RadioListTile<bool>(
                value: false,
                groupValue: this._listQuestions[1].boolResult,
                onChanged: this._onChangedQuestions(0, 1),
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
                value: true,
                groupValue: this._listQuestions[2].boolResult,
                onChanged: this._onChangedQuestions(0, 2),
                title: Text('Sim, qual?',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            RadioListTile<bool>(
                value: false,
                groupValue: this._listQuestions[2].boolResult,
                onChanged: this._onChangedQuestions(0, 2),
                title: Text('Não',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            (this._listQuestions[2].boolResult == null ||
                    !this._listQuestions[2].boolResult
                ? Container()
                : Container(
                    margin: EdgeInsets.only(bottom: 20, left: 40),
                    child: Column(
                      children: [
                        Container(
                            margin:
                                EdgeInsets.only(top: 20, bottom: 20, left: 20)),
                        RadioListTile<String>(
                            value: 'Ardência',
                            groupValue: this._listQuestions[2].textResult,
                            onChanged: this._onChangedQuestions(1, 2),
                            title: Text('Ardência',
                                style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontSize: 19,
                                    decoration: TextDecoration.none))),
                        RadioListTile<String>(
                            value: 'Inchaço',
                            groupValue: this._listQuestions[2].textResult,
                            onChanged: this._onChangedQuestions(1, 2),
                            title: Text('Inchaço',
                                style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontSize: 19,
                                    decoration: TextDecoration.none))),
                        RadioListTile<String>(
                            value: 'Vermelhidão',
                            groupValue: this._listQuestions[2].textResult,
                            onChanged: this._onChangedQuestions(1, 2),
                            title: Text('Vermelhidão',
                                style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontSize: 19,
                                    decoration: TextDecoration.none))),
                        RadioListTile<String>(
                            value: 'Coceira',
                            groupValue: this._listQuestions[2].textResult,
                            onChanged: this._onChangedQuestions(1, 2),
                            title: Text('Coceira',
                                style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontSize: 19,
                                    decoration: TextDecoration.none))),
                        RadioListTile<String>(
                            value: 'Outros',
                            groupValue: this._listQuestions[2].textResult,
                            onChanged: this._onChangedQuestions(1, 2),
                            title: Text('Outros',
                                style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontSize: 19,
                                    decoration: TextDecoration.none))),
                        (this._listQuestions[2].textResult == null ||
                                this._listQuestions[2].textResult != 'Outros'
                            ? Container()
                            : Container(
                                child: TextField(
                                  controller: this._otherValues[0],
                                  decoration: InputDecoration(
                                    hintText: "Incomodo...",
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                    enabledBorder: new UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.grey)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.pink),
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(left: 50, right: 40)))
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
                groupValue: this._listQuestions[3].textResult,
                onChanged: this._onChangedQuestions(1, 3),
                title: Text('Pastosa',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            RadioListTile<String>(
                value: 'Líquida',
                groupValue: this._listQuestions[3].textResult,
                onChanged: this._onChangedQuestions(1, 3),
                title: Text('Líquida',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            RadioListTile<String>(
                value: 'Grumosa',
                groupValue: this._listQuestions[3].textResult,
                onChanged: this._onChangedQuestions(1, 3),
                title: Text('Grumosa',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            RadioListTile<String>(
                value: 'Outra',
                groupValue: this._listQuestions[3].textResult,
                onChanged: this._onChangedQuestions(1, 3),
                title: Text('Outra',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            (this._listQuestions[3].textResult == null ||
                    this._listQuestions[3].textResult != 'Outra'
                ? Container()
                : Container(
                    margin: EdgeInsets.only(left: 50, right: 40),
                    child: TextField(
                      controller: this._otherValues[1],
                      decoration: InputDecoration(
                        hintText: "Sujeira...",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black),
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
                groupValue: this._listQuestions[4].textResult,
                onChanged: this._onChangedQuestions(1, 4),
                title: Text('Amarronzada',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            RadioListTile<String>(
                value: 'Amarelada',
                groupValue: this._listQuestions[4].textResult,
                onChanged: this._onChangedQuestions(1, 4),
                title: Text('Amarelada',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            RadioListTile<String>(
                value: 'Esverdeada',
                groupValue: this._listQuestions[4].textResult,
                onChanged: this._onChangedQuestions(1, 4),
                title: Text('Esverdeada',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            RadioListTile<String>(
                value: 'Outra',
                groupValue: this._listQuestions[4].textResult,
                onChanged: this._onChangedQuestions(1, 4),
                title: Text('Outra',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            (this._listQuestions[4].textResult == null ||
                    this._listQuestions[4].textResult != 'Outra'
                ? Container()
                : Container(
                    margin: EdgeInsets.only(left: 50, right: 40),
                    child: TextField(
                      controller: this._otherValues[2],
                      decoration: InputDecoration(
                        hintText: "Cor...",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black),
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
                  'Percebeu saída de sangue?',
                  style: GoogleFonts.notoSans(
                      color: Colors.black,
                      fontSize: 22,
                      decoration: TextDecoration.none),
                ),
                margin: EdgeInsets.only(top: 20, bottom: 20, left: 20)),
            RadioListTile<bool>(
                value: true,
                groupValue: this._listQuestions[5].boolResult,
                onChanged: this._onChangedQuestions(0, 5),
                title: Text('Sim',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            RadioListTile<bool>(
                value: false,
                groupValue: this._listQuestions[5].boolResult,
                onChanged: this._onChangedQuestions(0, 5),
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
                groupValue: this._listQuestions[6].boolResult,
                onChanged: this._onChangedQuestions(0, 6),
                title: Text('Não?',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            RadioListTile<bool>(
                value: true,
                groupValue: this._listQuestions[6].boolResult,
                onChanged: this._onChangedQuestions(0, 6),
                title: Text('Sim, como?',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            (this._listQuestions[6].boolResult == null ||
                    !this._listQuestions[6].boolResult
                ? Container()
                : Container(
                    margin: EdgeInsets.only(left: 50, right: 40),
                    child: TextField(
                      controller: this._otherValues[3],
                      decoration: InputDecoration(
                        hintText: "Causou...",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black),
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
                groupValue: this._listQuestions[7].boolResult,
                onChanged: this._onChangedQuestions(0, 7),
                title: Text('Não',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            RadioListTile<bool>(
                value: true,
                groupValue: this._listQuestions[7].boolResult,
                onChanged: this._onChangedQuestions(0, 7),
                title: Text('Sim, Quando?',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            (this._listQuestions[7].boolResult == null ||
                    !this._listQuestions[7].boolResult
                ? Container()
                : Container(
                    margin: EdgeInsets.only(left: 50, right: 40),
                    child: DateTimeFormField(
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
                groupValue: this._listQuestions[8].boolResult,
                onChanged: this._onChangedQuestions(0, 8),
                title: Text('Sim',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            RadioListTile<bool>(
                value: false,
                groupValue: this._listQuestions[8].boolResult,
                onChanged: this._onChangedQuestions(0, 8),
                title: Text('Não, qual a diferença?',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            (this._listQuestions[8].boolResult == null ||
                    this._listQuestions[8].boolResult
                ? Container()
                : Container(
                    margin: EdgeInsets.only(left: 50, right: 40),
                    child: TextField(
                      controller: this._otherValues[4],
                      decoration: InputDecoration(
                        hintText: "Foi...",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black),
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
                groupValue: this._listQuestions[9].boolResult,
                onChanged: this._onChangedQuestions(0, 9),
                title: Text('Não',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            RadioListTile<bool>(
                value: true,
                groupValue: this._listQuestions[9].boolResult,
                onChanged: this._onChangedQuestions(0, 9),
                title: Text('Sim, poruqe?',
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 19,
                        decoration: TextDecoration.none))),
            (this._listQuestions[9].boolResult == null ||
                    !this._listQuestions[9].boolResult
                ? Container()
                : Container(
                    margin: EdgeInsets.only(left: 50, right: 40),
                    child: TextField(
                      controller: this._otherValues[5],
                      decoration: InputDecoration(
                        hintText: "Causou...",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black),
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
        )
      ],
    )));
  }
}
