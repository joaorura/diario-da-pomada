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
import 'package:google_fonts/google_fonts.dart';

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
        csvModel.dataCsv, "diario-da-pomada-${DateTime.now().toString()}.csv");
  }

  Widget buildFuture(BuildContext context, AsyncSnapshot<TypeUserModel> data) {
    Widget downloadCsv;

    if (data.hasData && data.data.typeUser == TypeUserEnum.admin) {
      downloadCsv = Column(children: [
        Container(
          margin: EdgeInsetsDirectional.only(bottom: 20, top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Administrador",
                style: GoogleFonts.notoSans(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none),
                textAlign: TextAlign.start,
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsetsDirectional.only(end: 10, top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(child: Text("Download CSV"), onPressed: _downloadCsv)
              ],
            ))
      ]);
    } else {
      downloadCsv = Container();
    }

    return Container(
      margin: EdgeInsetsDirectional.only(top: 20),
      child: Column(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Configurações",
                  style: GoogleFonts.notoSans(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsetsDirectional.only(end: 10, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      child: Text("Notificações"),
                      onPressed: goPageWithBack(
                          context, () => NotificacoesPage(notificationService)))
                ],
              )),
          Container(
              margin: EdgeInsetsDirectional.only(end: 10, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      child: Text("Editar Perfil"),
                      onPressed: goPageWithBack(context,
                          () => SignupPage(notificationService, edit: true)))
                ],
              )),
          Container(
              margin: EdgeInsetsDirectional.only(end: 10, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      child: Text("Sair da Conta"), onPressed: logoff(context))
                ],
              )),
          downloadCsv,
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
