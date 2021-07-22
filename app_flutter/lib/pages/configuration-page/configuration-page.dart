import 'package:app_flutter/models/csv-model.dart';
import 'package:app_flutter/models/type-user-model.dart';
import 'package:app_flutter/pages/login-page/login-page.dart';
import 'package:app_flutter/pages/login-page/sigup-page.dart';
import 'package:app_flutter/pages/notifications-page/notifications-page.dart';
import 'package:app_flutter/services/csv-service.dart';
import 'package:app_flutter/services/file-service.dart';
import 'package:app_flutter/services/login-service.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/services/type-user-service.dart';
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

  Future<void> _downloadCsv() async {
    CsvService csvService = new CsvService();
    CsvModel csvModel = await csvService.getCsv();

    FileService fileService = new FileService();
    await fileService.writeFileString(
        csvModel.dataCsv, "diario-da-pomada-${DateTime.now().toString()}");
  }

  Widget buildFuture(BuildContext context, AsyncSnapshot<TypeUserModel> data) {
    Widget downloadCsv;

    if (data.hasData && data.data.typeUser == TypeUserEnum.admin) {
      downloadCsv =
          TextButton(child: Text("Download CSV"), onPressed: _downloadCsv);
    } else {
      downloadCsv = Container();
    }

    return Container(
      child: Column(
        children: [
          TextButton(
              child: Text("Notificações"),
              onPressed: goPageWithBack(
                  context, () => NotificacoesPage(notificationService))),
          TextButton(
              child: Text("Editar Perfil"),
              onPressed: goPageWithBack(
                  context, () => SignupPage(notificationService, edit: true))),
          TextButton(child: Text("Sair da Conta"), onPressed: logoff(context))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TypeUserService typeUserService = new TypeUserService();

    return FutureBuilder(
        future: typeUserService.getTypeUser(), builder: buildFuture);
  }
}
