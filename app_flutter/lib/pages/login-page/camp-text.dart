import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SpaceCamp extends StatelessWidget {
  final String nameCamp;

  SpaceCamp(this.nameCamp, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child:
              Text(nameCamp, style: GoogleFonts.notoSans(color: Colors.white)),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.1,
          margin: EdgeInsets.only(top: 20, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.pink.withAlpha(30),
            border: Border.all(color: Colors.white, width: 1.5),
          ),
        )
      ],
    );
  }
}

class CampText extends StatefulWidget {
  final String? nameCamp;
  final void Function(String?)? getData;
  final List<TextInputFormatter>? inputs;
  final String? Function(String?)? validate;
  final String? dataCamp;
  final Widget? icon;
  final bool? obcure;

  CampText(this.nameCamp, this.getData,
      {Key? key,
      this.inputs,
      this.validate,
      this.dataCamp,
      this.icon,
      this.obcure})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CampText();
}

class _CampText extends State<CampText> {
  String Function(String)? validate;
  TextEditingController? _controller;
  bool? _obscure;

  @override
  void initState() {
    if (widget.obcure == null) {
      _obscure = false;
    } else {
      _obscure = widget.obcure;
    }

    _controller = new TextEditingController(text: widget.dataCamp);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(widget.nameCamp!,
              style: GoogleFonts.notoSans(color: Colors.white)),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.1,
          margin: EdgeInsets.only(top: 20, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.pink.withAlpha(30),
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: TextFormField(
            controller: _controller,
            onSaved: widget.getData,
            inputFormatters: widget.inputs,
            validator: widget.validate,
            style: GoogleFonts.notoSans(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 10, right: 10),
                icon: widget.icon),
            obscureText: _obscure!,
          ),
        )
      ],
    );
  }
}
