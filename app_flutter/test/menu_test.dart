import 'package:app_flutter/pages/calendar-page/calendar-page.dart';
import 'package:app_flutter/pages/configuration-page/configuration-page.dart';
import 'package:app_flutter/pages/default-page/default-page.dart';
import 'package:app_flutter/pages/informations-page/informations-page.dart';
import 'package:app_flutter/pages/use-page/use-page.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_flutter/main.dart';

void main() {
  initializeDateFormatting('pt_BR', null);

  Finder camp;

  testWidgets('Menu Principal - Acesso a página Uso',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(App(home: DefaultPage(NotificationService(), test: true)));
    await tester.pump(new Duration(seconds: 1));

    expect(find.byType(CalendarPage), findsOneWidget);

    camp = find.text("Uso");

    expect(camp, findsOneWidget);

    await tester.tap(camp);
    await tester.pump(new Duration(seconds: 1));

    expect(find.byType(UsePage), findsOneWidget);
  });

  testWidgets('Menu Principal - Acesso a página Calendário',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(App(home: DefaultPage(NotificationService(), test: true)));
    await tester.pump(new Duration(seconds: 1));

    expect(find.byType(CalendarPage), findsOneWidget);

    camp = find.text("Uso");

    expect(camp, findsOneWidget);

    await tester.tap(camp);
    await tester.pump(new Duration(seconds: 1));

    expect(find.byType(UsePage), findsOneWidget);

    camp = find.text("Calendário");

    expect(camp, findsOneWidget);

    await tester.tap(camp);
    await tester.pump(new Duration(seconds: 1));

    expect(find.byType(CalendarPage), findsOneWidget);
  });

  testWidgets('Menu Principal - Acesso a página Informações',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(App(home: DefaultPage(NotificationService(), test: true)));
    await tester.pump(new Duration(seconds: 1));

    expect(find.byType(CalendarPage), findsOneWidget);

    camp = find.text("Informações");

    expect(camp, findsOneWidget);

    await tester.tap(camp);
    await tester.pump(new Duration(seconds: 1));

    expect(find.byType(InformationsPage), findsOneWidget);
  });

  testWidgets('Menu Principal - Acesso a página Menu',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(App(home: DefaultPage(NotificationService(), test: true)));
    await tester.pump(new Duration(seconds: 1));

    expect(find.byType(CalendarPage), findsOneWidget);

    camp = find.text("Menu");

    expect(camp, findsOneWidget);

    await tester.tap(camp);
    await tester.pump(new Duration(seconds: 1));

    expect(find.byType(ConfigurationPage), findsOneWidget);
  });
}
