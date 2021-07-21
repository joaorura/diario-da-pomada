import 'package:flutter/material.dart';

class WhiteDot extends StatefulWidget {
  final bool type;

  WhiteDot({Key key, this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _WhiteDot(this.type);
  }
}

class _WhiteDot extends State<WhiteDot> {
  final bool type;
  final double circularSize = 100;

  _WhiteDot(this.type);

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: MediaQuery.of(context).size.width * 0.035,
        height: MediaQuery.of(context).size.width * 0.035,
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.005),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(this.circularSize),
            border: Border.all(color: Colors.white, width: 1.5),
            color: this.type ? Colors.white : Colors.transparent));
  }
}
