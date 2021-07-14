import 'package:app_flutter/calendar-page/calendar-page.dart';
import 'package:app_flutter/configuration-page/configuration-page.dart';
import 'package:app_flutter/informations-page/informations-page.dart';
import 'package:app_flutter/services/notification-service.dart';
import 'package:app_flutter/use-page/use-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultPage extends StatefulWidget {
  final NotificationService notificationService;
  DefaultPage(this.notificationService, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DefaultPage();
}

class _DefaultPage extends State<DefaultPage> {
  Widget bodyChild;
  int _selectedIndex = 1;

  void initState() {
    super.initState();
    this.bodyChild = CalendarPage(widget.notificationService);
    this._selectedIndex = 1;
  }

  void _onItemTapped(int index) {
    if (this._selectedIndex == index) {
      return;
    }

    this.setState(() {
      this._selectedIndex = index;
    });
    switch (index) {
      case 0:
        this.setState(() {
          this.bodyChild = UsePage();
        });
        break;
      case 1:
        this.setState(() {
          this.bodyChild = CalendarPage(widget.notificationService);
        });
        break;
      case 2:
        this.setState(() {
          this.bodyChild = InformationsPage();
        });
        break;
      case 3:
        this.setState(() {
          this.bodyChild = ConfigurationPage(widget.notificationService);
        });
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: this.bodyChild),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business, color: Colors.pink),
            label: 'Uso',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded, color: Colors.pink),
            label: 'Calendário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded, color: Colors.pink),
            label: 'Informações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_rounded, color: Colors.pink),
            label: 'Menu',
          )
        ],
        currentIndex: this._selectedIndex,
        onTap: this._onItemTapped,
      ),
    );
  }
}