import 'package:app_flutter/models/signup-model.dart';
import 'package:app_flutter/pages/login-page/button-camp.dart';
import 'package:app_flutter/pages/login-page/login-page.dart';
import 'package:app_flutter/pages/login-page/logo-login.dart';
import 'package:app_flutter/pages/login-page/sigup-page.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_flutter/main.dart';

void main() {
  SignupModel testData = SignupModel("test@test.com", DateTime(12, 12, 1990),
      "Test Test", "012345678901234", "3672", "13674272407");

  testWidgets('SiginupPage - Campos Cadastro', (WidgetTester tester) async {
    Finder camp;
    TextFormField textCamp;

    await tester.pumpWidget(App(home: SignupPage(NotificationService())));

    expect(find.byType(LogonLogin), findsOneWidget);

    expect(find.text('Atualizando Cadastro'), findsNothing);

    expect(find.text('Email'), findsOneWidget);

    camp = find.byKey(Key('Email'));
    expect(camp, findsOneWidget);

    await tester.enterText(camp, testData.email!);

    textCamp = tester.firstWidget(camp);
    expect(textCamp.controller!.text, testData.email!);

    expect(find.text('Data de Nascimento'), findsOneWidget);
    expect(find.byKey(Key('Data de Nascimento')), findsOneWidget);

    expect(find.text('Nome Completo'), findsOneWidget);
    expect(find.byKey(Key('Nome Completo')), findsOneWidget);

    camp = find.byKey(Key('Nome Completo'));
    expect(camp, findsOneWidget);

    await tester.enterText(camp, "Test test");

    textCamp = tester.firstWidget(camp);
    expect(textCamp.controller!.text, "Test test");

    expect(find.text('Cartão do SUS'), findsOneWidget);
    expect(find.byKey(Key('Cartão do SUS')), findsOneWidget);

    expect(find.text('CPF'), findsOneWidget);
    expect(find.byKey(Key('CPF')), findsOneWidget);

    expect(find.text('Senha'), findsOneWidget);
    expect(find.byKey(Key('Senha')), findsOneWidget);

    expect(find.text('Repita a senha'), findsOneWidget);
    expect(find.byKey(Key('Repita a senha')), findsOneWidget);

    expect(find.text('Já tem uma Conta?'), findsOneWidget);
    expect(find.byKey(Key('Já tem uma Conta?')), findsOneWidget);

    expect(find.text('Confirmar Cadastro'), findsOneWidget);
    expect(find.byKey(Key('Confirmar Cadastro')), findsOneWidget);

    expect(find.text('Atualizar Cadastro'), findsNothing);
    expect(find.byKey(Key('Atualizar Cadastro')), findsNothing);
  });

  testWidgets('SiginupPage - Campos Atualizar', (WidgetTester tester) async {
    SignupModel testData = SignupModel("test@test.com", DateTime(12, 12, 1990),
        "Test Test", "012345678901234", "3672", "13674272407");

    await tester.pumpWidget(App(
        home:
            SignupPage(NotificationService(), edit: true, testData: testData)));

    await tester.pump(new Duration(seconds: 2));

    expect(find.byType(LogonLogin), findsOneWidget);

    expect(find.text('Atualizando Cadastro'), findsOneWidget);

    expect(find.text('Email'), findsOneWidget);

    Finder camp = find.byKey(Key('Email'));
    expect(camp, findsOneWidget);

    TextFormField textCamp = tester.firstWidget(camp);
    expect(textCamp.controller!.text, testData.email);

    expect(find.text('Data de Nascimento'), findsOneWidget);
    expect(find.byKey(Key('Data de Nascimento')), findsOneWidget);

    expect(find.text('Nome Completo'), findsOneWidget);
    expect(find.byKey(Key('Nome Completo')), findsOneWidget);

    expect(find.text('Cartão do SUS'), findsOneWidget);
    expect(find.byKey(Key('Cartão do SUS')), findsOneWidget);

    expect(find.text('CPF'), findsOneWidget);
    expect(find.byKey(Key('CPF')), findsOneWidget);

    expect(find.text('Senha'), findsNothing);
    expect(find.byKey(Key('Senha')), findsNothing);

    expect(find.text('Repita a senha'), findsNothing);
    expect(find.byKey(Key('Repita a senha')), findsNothing);

    expect(find.text('Já tem uma Conta?'), findsNothing);
    expect(find.byKey(Key('Já tem uma Conta?')), findsNothing);

    expect(find.text('Confirmar Cadastro'), findsNothing);
    expect(find.byKey(Key('Confirmar Cadastro')), findsNothing);

    expect(find.byType(ButtonCamp), findsWidgets);

    expect(find.text('Atualizar Cadastro'), findsOneWidget);
    expect(find.byKey(Key('Atualizar Cadastro')), findsOneWidget);
  });

  testWidgets('SiginupPage - Acessar Login', (WidgetTester tester) async {
    Finder camp;

    await tester.pumpWidget(App(home: SignupPage(NotificationService())));

    await tester.pump(new Duration(seconds: 1));

    expect(find.text('Já tem uma Conta?'), findsOneWidget);

    camp = find.byKey(Key('Já tem uma Conta?'));
    expect(camp, findsOneWidget);

    await tester.ensureVisible(camp);
    await tester.pumpAndSettle();
    await tester.tap(camp);

    await tester.pump(new Duration(seconds: 1));

    expect(find.byType(LoginPage), findsOneWidget);
  });
}
