import 'package:flutter/material.dart';

import '../main.dart';

Function goPageWithoutBack(BuildContext context, Function createWidget) {
  return () {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => App(
                  home: createWidget(),
                )));
  };
}

Function goPageWithBack(BuildContext context, Function createWidget) {
  return () {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => App(
                  home: createWidget(),
                )));
  };
}

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text),
    duration: Duration(seconds: 10),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
