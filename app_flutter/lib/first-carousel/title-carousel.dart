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
        style: GoogleFonts.acme(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            shadows: [Shadow(color: Colors.black, blurRadius: 80)],
            decoration: TextDecoration.none),
        textAlign: TextAlign.start,
      ),
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.07,
          top: MediaQuery.of(context).size.height * 0.05,
          bottom: MediaQuery.of(context).size.height * 0.05),
    );
  }
}
