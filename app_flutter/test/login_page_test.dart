import 'package:app_flutter/pages/calendar-page/calendar-page.dart';
import 'package:app_flutter/pages/login-page/login-page.dart';
import 'package:app_flutter/pages/login-page/logo-login.dart';
import 'package:app_flutter/pages/login-page/sigup-page.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:app_flutter/main.dart';

void main() {
  initializeDateFormatting('pt_BR', null);

  testWidgets('LoginPage - Campos', (WidgetTester tester) async {
    await tester.pumpWidget(App(home: LoginPage(NotificationService())));
    await tester.pump(new Duration(seconds: 1));

    expect(find.byType(LogonLogin), findsOneWidget);
    expect(find.text('CPF, Email ou Cartão do SUS'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('Exibir'), findsOneWidget);
    expect(find.text('Crie uma conta!'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);

    expect(find.byKey(Key('CPF, Email ou Cartão do SUS')), findsOneWidget);
    expect(find.byKey(Key('Senha')), findsOneWidget);
    expect(find.byKey(Key('Entrar')), findsOneWidget);
  });

  testWidgets('LoginPage - Acesso ao cadastro', (WidgetTester tester) async {
    await tester.pumpWidget(App(home: LoginPage(NotificationService())));
    await tester.pump(new Duration(seconds: 1));

    var createButton = find.text('Crie uma conta!');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pump(new Duration(seconds: 10));

    expect(find.byType(SignupPage), findsOneWidget);
  });

  testWidgets('LoginPage - Acessar conta', (WidgetTester tester) async {
    await tester
        .pumpWidget(App(home: LoginPage(NotificationService(), test: true)));

    await tester.pump(new Duration(seconds: 1));

    Finder camp = find.byKey(Key('CPF, Email ou Cartão do SUS'));
    expect(camp, findsOneWidget);
    await tester.enterText(camp, "test@test.com");

    camp = find.byKey(Key('Senha'));
    expect(camp, findsOneWidget);
    await tester.enterText(camp, "0170");

    camp = find.byKey(Key('Entrar'));
    expect(camp, findsOneWidget);

    await tester.tap(camp);

    await tester.pump(new Duration(seconds: 1));

    expect(find.byType(CalendarPage), findsOneWidget);
  });
}
