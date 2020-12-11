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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(this.nameCamp,
              style: GoogleFonts.notoSans(color: Colors.white)),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.1,
          margin: EdgeInsets.only(top: 20, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.pink.withAlpha(30),
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: TextFormField(
            onSaved: this.getData,
            style: GoogleFonts.notoSans(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10, right: 10)),
          ),
        )
      ],
    );
  }
}
