import 'package:app_flutter/models/file-model.dart';
import 'package:app_flutter/models/user-data-model.dart';
import 'package:app_flutter/services/file-service.dart';
import 'package:app_flutter/services/report-service.dart';
import 'package:app_flutter/services/user-data-service.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:flutter/cupertino.dart';
import 'package:awesome_select/awesome_select.dart';
// ignore: implementation_imports
import 'package:awesome_select/src/model/chosen.dart';

class SpecificReportPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpecificReportPage();
}

class _SpecificReportPage extends State<SpecificReportPage> {
  String? _selectedHealthCard = '';

  List<S2Choice<String>>? options;

  Future<void> _downloadFile(BuildContext context) async {
    ReportService csvService = new ReportService();
    FileModel? fileModel =
        await csvService.getEspecificReport(_selectedHealthCard);

    if (fileModel == null) {
      showSnackBar(context,
          "Falha a acessar os dados do relatório em download de relátorio específico");
      return;
    }

    FileService fileService = new FileService();
    await fileService.writeFileBase64(fileModel.fileBase64,
        "dp-r-espec-$_selectedHealthCard-${DateTime.now().toString().replaceAll(':', '-')}.xlsx");

    showSnackBar(context, "Download do relátorio específico feito.");
  }

  Widget buildFuture(BuildContext context, AsyncSnapshot<UserDataModel?> data) {
    if (data.hasData) {
      options = [];

      for (DataModel user in data.data!.users!) {
        List<String> names = user.name.split(" ");
        String name;
        if (names.length > 2) {
          name = '${names[0]} ${names[1]}';
        } else {
          name = user.name;
        }
        options!.add(S2Choice<String>(
            value: user.healthCard, title: '$name - ${user.healthCard}'));
      }

      return Container(
          child: Column(children: [
        Container(
          margin: EdgeInsetsDirectional.only(bottom: 60),
        ),
        SmartSelect<String>.single(
            title: 'Usuário',
            selectedValue: _selectedHealthCard,
            choiceItems: options,
            onChange: (S2SingleSelected<String?> state) {
              setState(() => _selectedHealthCard = state.value);
            }),
        Container(
          margin: EdgeInsetsDirectional.only(bottom: 60),
        ),
        TextButton(
            child: Text(
                "Download Estátisticas do HealthCard $_selectedHealthCard"),
            onPressed: () => _downloadFile(context))
      ]));
    } else {
      return LoadingProvider(
        themeData: LoadingThemeData(),
        child: Container(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    UserDataService userService = UserDataService();
    Future<UserDataModel?> futureUser = userService.getUserData();
    return FutureBuilder(future: futureUser, builder: buildFuture);
  }
}
