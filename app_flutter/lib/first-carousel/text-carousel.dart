import 'package:flutter/material.dart';

class TextCarousel extends StatefulWidget {
  final String text;

  TextCarousel({Key key, this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextCarousel(this.text);
}

class _TextCarousel extends State<TextCarousel> {
  final String text;

  _TextCarousel(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
          this.text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              shadows: [Shadow(color: Colors.black, blurRadius: 80)],
              decoration: TextDecoration.none),
        ),
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.12,
            right: MediaQuery.of(context).size.width * 0.05),
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.3,
            bottom: MediaQuery.of(context).size.height * 0.3));
  }
}
