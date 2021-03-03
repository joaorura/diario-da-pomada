import 'package:app_flutter/first-carousel/first-carousel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(top: false, child: FirstCarousel()));
  }
}

class App extends StatefulWidget {
  final Widget home;

  App({Key key, this.home}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _App(this.home);
}

class _App extends State<App> {
  final Widget home;

  _App(this.home);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(body: SafeArea(top: false, child: this.home)),
    );
  }
}
