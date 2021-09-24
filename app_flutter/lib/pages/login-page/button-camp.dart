import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonCamp extends StatefulWidget {
  final String? theText;
  final Function? onPressed;

  ButtonCamp({Key? key, this.theText, this.onPressed}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _ButtonCamp(this.theText!, this.onPressed!);
}

class _ButtonCamp extends State<ButtonCamp> {
  final String theText;
  final Function onPressed;

  _ButtonCamp(this.theText, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: MaterialButton(
        color: Colors.white,
        key: Key(this.theText),
        onPressed: this.onPressed as void Function(),
        child: Text(
          this.theText,
          style: GoogleFonts.notoSans(color: Colors.pink),
        ),
      ),
    );
  }
}
