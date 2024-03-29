import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final List<Widget>? children;

  BasePage({Key? key, this.children}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BasePage(this.children!);
}

class _BasePage extends State<BasePage> {
  final List<Widget> children;

  _BasePage(this.children);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.pink.withAlpha(90),
          ),
          child: ListView(children: this.children)),
    );
  }
}
