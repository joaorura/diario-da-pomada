import 'package:app_flutter/first-carousel/first-carousel.dart';
import 'package:app_flutter/services/login-service.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'default-page/default-page.dart';

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _configureLocalTimeZone();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
    ], supportedLocales: [
      const Locale('pt', 'BR')
    ], home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NotificationService notificationService;

  void initState() {
    super.initState();
    notificationService = new NotificationService();
  }

  @override
  Widget build(BuildContext context) {
    LoginService loginService = new LoginService();

    if (loginService.loged()) {
      return Scaffold(
          body: SafeArea(top: false, child: DefaultPage(notificationService)));
    } else {
      return Scaffold(
          body:
              SafeArea(top: false, child: FirstCarousel(notificationService)));
    }
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
