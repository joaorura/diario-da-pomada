import 'package:app_flutter/pages/default-page/default-page.dart';
import 'package:app_flutter/pages/first-carousel/first-carousel.dart';
import 'package:app_flutter/services/login-service.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'utils/timezone.dart';

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

SharedPreferences prefs;
final TimeZone timeZone = TimeZone();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureLocalTimeZone();
  prefs = await SharedPreferences.getInstance();

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
      return App(home: DefaultPage(notificationService));
    } else {
      return App(home: FirstCarousel(notificationService));
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
      title: 'Diario da Pomada',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
          Scaffold(body: SafeArea(top: false, bottom: false, child: this.home)),
    );
  }
}
