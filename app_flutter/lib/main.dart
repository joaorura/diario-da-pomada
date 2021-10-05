import 'package:app_flutter/pages/default-page/default-page.dart';
import 'package:app_flutter/pages/first-carousel/first-carousel.dart';
import 'package:app_flutter/services/login-service.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'utils/timezone.dart';

Future<void> configureLocalTimeZone({String? timeZone}) async {
  tz.initializeTimeZones();

  if (timeZone == null) {
    timeZone = await FlutterNativeTimezone.getLocalTimezone();
  }

  tz.setLocalLocation(tz.getLocation(timeZone));
}

final TimeZone timeZone = TimeZone();

Future<void> loadConf() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureLocalTimeZone();
}

Future<void> main() async {
  await loadConf();
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
  Widget buildFuture(BuildContext context, AsyncSnapshot<bool> data) {
    if (data.hasData) {
      NotificationService notificationService = new NotificationService();
      if (data.data as bool) {
        return App(home: DefaultPage(notificationService));
      } else {
        return App(home: FirstCarousel(notificationService));
      }
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginService loginService = new LoginService();
    Future<bool> futureData = loginService.loged();

    return new FutureBuilder(builder: buildFuture, future: futureData);
  }
}

class App extends StatefulWidget {
  final Widget? home;

  App({Key? key, this.home}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _App(this.home);
}

class _App extends State<App> {
  final Widget? home;

  _App(this.home);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diario da Pomada',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          body:
              SafeArea(top: false, bottom: false, child: this.home as Widget)),
    );
  }
}
