import 'package:flutter/material.dart';
import 'package:app_flutter/pages/first-carousel/white-dot.dart';

class ListWhiteDot extends StatefulWidget {
  final int whiteIndex, size;

  ListWhiteDot({Key key, this.whiteIndex, this.size}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListWhiteDot(whiteIndex, size);
}

class _ListWhiteDot extends State<ListWhiteDot> {
  final int whiteIndex, size;

  List<WhiteDot> listWhiteDot;

  _ListWhiteDot(this.whiteIndex, this.size);

  @override
  void initState() {
    super.initState();
    listWhiteDot = new List<WhiteDot>.generate(
        this.size,
        (index) => index == this.whiteIndex
            ? WhiteDot(type: true)
            : WhiteDot(type: false));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: this.listWhiteDot,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
