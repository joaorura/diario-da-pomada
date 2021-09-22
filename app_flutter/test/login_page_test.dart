// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:app_flutter/models/signup-model.dart';
import 'package:app_flutter/pages/calendar-page/calendar-page.dart';
import 'package:app_flutter/pages/login-page/login-page.dart';
import 'package:app_flutter/pages/login-page/logo-login.dart';
import 'package:app_flutter/pages/login-page/sigup-page.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/services/signup-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_flutter/main.dart';

void main() {
  testWidgets('LoginPage - Campos', (WidgetTester tester) async {
    await tester.pumpWidget(App(home: LoginPage(NotificationService())));

    expect(find.byType(LogonLogin), findsOneWidget);
    expect(find.text('CPF, Email ou Cartão do SUS'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('Exibir'), findsOneWidget);
    expect(find.text('Crie uma conta!'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });

  testWidgets('LoginPage - Acesso ao cadastro', (WidgetTester tester) async {
    await tester.pumpWidget(App(home: LoginPage(NotificationService())));

    var createButton = find.text('Crie uma conta!');
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pump(new Duration(milliseconds: 100));

    expect(find.byType(SignupPage), findsOneWidget);
  });

  testWidgets('LoginPage - Acessar conta', (WidgetTester tester) async {
    await tester.pumpWidget(App(home: LoginPage(NotificationService())));

    SignupService signupService = SignupService();

    SignupModel signupModel = SignupModel("test@test.com", DateTime(1990, 1, 1),
        "Test test", "012345678901234", "0170", "13674272407");

    bool check = await signupService.signUp(signupModel);

    expect(check, true);

    List<TextFormField> campos =
        find.byType(TextFormField).evaluate().toList() as List<TextFormField>;
    expect(campos.length, 2);
    await tester.enterText(find.byKey(campos[0].key!), "test@test.com");
    await tester.enterText(find.byKey(campos[1].key!), "0170");

    List<MaterialButton> buttons =
        find.byType(MaterialButton).evaluate().toList() as List<MaterialButton>;

    await tester.tap(find.byKey(buttons[1].key!));

    await tester.pump(new Duration(seconds: 1));

    expect(find.byType(CalendarPage), findsOneWidget);
  });
}
