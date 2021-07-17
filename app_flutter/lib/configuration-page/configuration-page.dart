import 'package:app_flutter/login-page/login-page.dart';
import 'package:app_flutter/main.dart';
import 'package:app_flutter/notifications-page/notifications-page.dart';
import 'package:app_flutter/services/login-service.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfigurationPage extends StatelessWidget {
  final NotificationService notificationService;
  ConfigurationPage(this.notificationService, {Key key}) : super(key: key);

  Function logoff(BuildContext context) {
    return () {
      LoginService loginService = new LoginService();
      loginService.logOff();

      goPageWithoutBack(context, () => LoginPage(notificationService))();
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextButton(
              child: Text("Notificações"),
              onPressed: goPageWithBack(
                  context, () => NotificacoesPage(notificationService))),
          TextButton(
              child: Text("Editar Perfil"),
              onPressed: goPageWithBack(context, () => Container())),
          TextButton(child: Text("Sair da Conta"), onPressed: logoff(context))
        ],
      ),
    );
  }
}
