import 'package:app_flutter/services/notification-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificacoesPage extends StatefulWidget {
  final NotificationService notificationService;
  NotificacoesPage(this.notificationService, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotificacoesPage();
}

class _NotificacoesPage extends State<StatefulWidget> {
  TimeOfDay _time = TimeOfDay.now();

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 10),
      child: Column(
        children: [
          Text("Horário da Notificação",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          ElevatedButton(
            onPressed: _selectTime,
            child: Text('${_time.format(context)}'),
          ),
        ],
      ),
    );
  }
}
