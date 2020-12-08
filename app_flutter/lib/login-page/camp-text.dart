import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CampText extends StatefulWidget {
  final String nameCamp;
  final Function getData;
  CampText({Key key, this.nameCamp, this.getData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CampText(this.nameCamp, this.getData);
}

class _CampText extends State<CampText> {
  final String nameCamp;
  final Function getData;

  _CampText(this.nameCamp, this.getData);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.1,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withAlpha(900),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: TextFormField(
        onSaved: this.getData,
        style: GoogleFonts.notoSans(color: Colors.white),
        decoration: InputDecoration(
            hintText: this.nameCamp,
            hintStyle: GoogleFonts.notoSans(color: Colors.white)),
      ),
    );
  }
}
