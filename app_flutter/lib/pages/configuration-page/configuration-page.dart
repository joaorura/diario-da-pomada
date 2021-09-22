import 'package:app_flutter/models/file-model.dart';
import 'package:app_flutter/models/signup-model.dart';
import 'package:app_flutter/models/type-user-model.dart';
import 'package:app_flutter/pages/login-page/login-page.dart';
import 'package:app_flutter/pages/login-page/sigup-page.dart';
import 'package:app_flutter/pages/notifications-page/notifications-page.dart';
import 'package:app_flutter/services/report-service.dart';
import 'package:app_flutter/services/file-service.dart';
import 'package:app_flutter/services/login-service.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/services/signup-service.dart';
import 'package:app_flutter/services/type-user-service.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfigurationPage extends StatelessWidget {
  final NotificationService notificationService;
  ConfigurationPage(this.notificationService, {Key? key}) : super(key: key);

  Function logoff(BuildContext context) {
    return () {
      LoginService loginService = new LoginService();
      loginService.logOff();

      goPageWithoutBack(context, () => LoginPage(notificationService))();
    };
  }

  Future<void> _downloadGeneral(BuildContext context) async {
    ReportService csvService = new ReportService();
    FileModel? fileModel = await csvService.getGeneralReport();

    FileService fileService = new FileService();
    await fileService.writeFileBase64(fileModel!.fileBase64,
        "dp-r-general-${DateTime.now().toString()}.xlsx");

    showSnackBar(context, "Download do relátorio geral feito.");
  }

  Future<void> _downloadEspec(BuildContext context) async {
    SignupService userService = SignupService();
    SignupModel? userData = await userService.getUser();

    if (userData == null) {
      showSnackBar(context,
          "Falha a acessar os dados do usuário em download de relátorio específico.");
      return;
    }

    String? healthCard = userData.heathCard;
    ReportService reportService = new ReportService();
    FileModel? fileModel = await reportService.getEspecificReport(healthCard);

    if (fileModel == null) {
      showSnackBar(context,
          "Falha a acessar os dados do relatório em download de relátorio específico.");
      return;
    }

    FileService fileService = new FileService();
    await fileService.writeFileBase64(
        fileModel.fileBase64, "dp-r-espec-${DateTime.now().toString()}.xlsx");

    showSnackBar(context, "Download do relátorio específico feito.");
  }

  Widget buildFuture(BuildContext context, AsyncSnapshot<TypeUserModel?> data) {
    Widget downloadCsv;

    if (data.hasData && data.data?.typeUser == TypeUserEnum.admin) {
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
                TextButton(
                    child: Text("Download Relatório Geral"),
                    onPressed: () => _downloadGeneral(context))
              ],
            )),
        Container(
            margin: EdgeInsetsDirectional.only(end: 10, top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    child: Text("Download Relatório Específico"),
                    onPressed: () => _downloadEspec(context))
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
                      onPressed: goPageWithBack(context,
                              () => NotificacoesPage(notificationService))
                          as void Function()?)
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
                              () => SignupPage(notificationService, edit: true))
                          as void Function()?)
                ],
              )),
          Container(
              margin: EdgeInsetsDirectional.only(end: 10, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      child: Text("Sair da Conta"),
                      onPressed: logoff(context) as void Function()?)
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
