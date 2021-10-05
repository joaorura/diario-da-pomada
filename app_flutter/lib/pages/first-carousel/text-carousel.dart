import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextCarousel extends StatefulWidget {
  final String? text;

  TextCarousel({Key? key, this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextCarousel(this.text!);
}

class _TextCarousel extends State<TextCarousel> {
  final String text;

  _TextCarousel(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
          this.text,
          style: GoogleFonts.notoSans(
              color: Colors.white,
              fontSize: 25,
              shadows: [Shadow(color: Colors.black, blurRadius: 80)],
              decoration: TextDecoration.none),
        ),
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.12,
            top: MediaQuery.of(context).size.height * 0.12));
  }
}
