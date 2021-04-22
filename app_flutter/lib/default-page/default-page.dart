import 'package:app_flutter/calendar-page/calendar-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DefaultPage();
}

class _DefaultPage extends State<DefaultPage> {
  Widget bodyChild = CalendarPage();
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (this._selectedIndex == index) {
      return;
    }

    this.setState(() {
      this._selectedIndex = index;
    });
    switch (index) {
      case 2:
        this.setState(() {
          this.bodyChild = CalendarPage();
        });
        break;

      default:
        this.setState(() {
          this.bodyChild = Container(
            child: Text("a"),
          );
        });
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
            icon: Icon(Icons.bar_chart_rounded, color: Colors.pink),
            label: 'Estatítisticas',
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
