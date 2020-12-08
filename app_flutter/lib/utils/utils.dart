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
