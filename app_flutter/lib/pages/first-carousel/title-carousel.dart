import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleCarousel extends StatefulWidget {
  final String text;

  TitleCarousel({Key key, this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TitleCarousel(this.text);
}

class _TitleCarousel extends State<TitleCarousel> {
  final String text;

  _TitleCarousel(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this.text,
        style: GoogleFonts.notoSans(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.w900,
            shadows: [Shadow(color: Colors.black, blurRadius: 80)],
            decoration: TextDecoration.none),
        textAlign: TextAlign.start,
      ),
      margin: EdgeInsets.only(left: 20, top: 40),
    );
  }
}
