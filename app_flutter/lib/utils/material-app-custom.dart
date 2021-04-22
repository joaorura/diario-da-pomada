import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaterialAppCustom extends StatelessWidget {
  final Widget _child;
  final String _title;

  MaterialAppCustom(this._child, this._title);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this._title,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          body: SafeArea(top: true, bottom: false, child: this._child)),
    );
  }
}
