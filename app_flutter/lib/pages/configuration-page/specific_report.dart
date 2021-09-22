import 'package:app_flutter/models/file-model.dart';
import 'package:app_flutter/models/user-data-model.dart';
import 'package:app_flutter/services/file-service.dart';
import 'package:app_flutter/services/report-service.dart';
import 'package:app_flutter/services/user-data-service.dart';
import 'package:app_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_select/smart_select.dart';

class SpecificReportPage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _SpecificReportPage();
}

class _SpecificReportPage extends State<SpecificReportPage> {
    String _selectedHealthCard;

    List<S2Choice<String>> options;

    Future<void> _downloadFile(BuildContext context) async {
        ReportService csvService = new ReportService();
        FileModel fileModel = await csvService.getEspecificReport(_selectedHealthCard);

        if(fileModel == null) {
            showSnackBar(context, "Falha a acessar os dados do relatório em download de relátorio específico");
            return;
        }

        FileService fileService = new FileService();
        await fileService.writeFileBase64(
            fileModel.fileBase64, "dp-r-espec-$_selectedHealthCard-${DateTime.now().toString()}.xlsx");

        showSnackBar(context, "Download do relátorio específico feito.");
    }

    Widget buildFuture(BuildContext context, AsyncSnapshot<UserDataModel> data) {
        if(data.hasData) {
            options = [];

            for(DataModel user in data.data.users) {
                List<String> names = user.name.split(" ");
                options.add(S2Choice<String>(value: user.healthCard, title: '${names[0]} ${names[1]} - ${user.healthCard}'));
            }

            return Container(
                child: Column(children: [
                    SmartSelect<String>.single(
                        title: 'Usuário',
                        value: _selectedHealthCard,
                        choiceItems: options,
                        onChange: (state) => setState(() => _selectedHealthCard = state.value)
                    ),
                    TextButton(child: Text("Download Estátisticas do HealthCard ${_selectedHealthCard}"), onPressed: () => _downloadFile(context))
                ])
            );
        }
        else {
            return  LoadingProvider(
                themeData: LoadingThemeData(),
                child: Container(),
    );
        }
    }

    @override
    Widget build(BuildContext context) {
        UserDataService dataService = UserDataService();
        Future<UserDataModel> futureCalendarModel = dataService.getUserData();
    return FutureBuilder(
        future: futureCalendarModel,
        initialData: UserDataModel(null),
        builder: buildFuture);
    }
}