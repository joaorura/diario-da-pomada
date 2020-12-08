import 'package:flutter/cupertino.dart';

class LogonLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LogonLogin();
}

class _LogonLogin extends State<LogonLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.2,
      height: MediaQuery.of(context).size.height * 0.2,
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.06),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        image: DecorationImage(
            image: AssetImage("assets\\images\\img_1.jpg"), fit: BoxFit.cover),
      ),
    );
  }
}
