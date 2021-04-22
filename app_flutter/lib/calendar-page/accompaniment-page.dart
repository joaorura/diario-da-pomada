import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccompanimentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccompanimentPage();
}

class _AccompanimentPage extends State<AccompanimentPage> {
  TextEditingController _theTextController = TextEditingController();

  bool _groupValue;

  void _onChanged(bool value) {
    setState(() {
      this._groupValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  groupValue: _groupValue,
                  onChanged: _onChanged,
                  title: Text('Sim',
                      style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 19,
                          decoration: TextDecoration.none))),
              RadioListTile<bool>(
                  value: false,
                  groupValue: _groupValue,
                  onChanged: _onChanged,
                  title: Text('Não',
                      style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 19,
                          decoration: TextDecoration.none))),
              (_groupValue == null || _groupValue
                  ? Container()
                  : Container(
                      child: TextField(
                        controller: _theTextController,
                        decoration: InputDecoration(
                          hintText: "Enter your name!",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.black),
                          enabledBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.grey)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink),
                          ),
                        ),
                      ),
                      margin: EdgeInsets.only(left: 40, right: 40)))
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center);
  }
}

class Croos {}
