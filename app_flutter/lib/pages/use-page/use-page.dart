import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsetsDirectional.only(top: 10, bottom: 10),
            child: Text(
              "Bem-vinda ao Diário da Pomada!",
              style: GoogleFonts.notoSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  shadows: [Shadow(color: Colors.grey, blurRadius: 5)],
                  decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Text("Cuidando de você todos os dias!",
                style: GoogleFonts.notoSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    shadows: [Shadow(color: Colors.grey, blurRadius: 5)],
                    decoration: TextDecoration.none),
                textAlign: TextAlign.center),
            padding: EdgeInsets.only(bottom: 30, top: 10),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 5),
            child: Text(
                "O Diário da Pomada é um aplicativo elaborado por um grupo de pesquisa composto por " +
                    "professores e acadêmicos da Universidade Federal de Alagoas. Tal aplicativo tem como objetivo " +
                    "ajudar as mulheres durante o uso da pomada ginecológica de barbatimão associada a nanopartículas " +
                    "de prata.\nO Diário da Pomada te ajuda a lembrar todos os dias sobre o uso da pomada ginecológica. "
                        "Além disso, orienta sobre a pomada ginecológica de barbatimão, como você deve usá-la e o tempo de " +
                    "uso.\nO barbatimão é uma planta conhecida popularmente e cientificamente pelas propriedades " +
                    "anti-inflamatórias, antifúngicas e cicatrizante. Com isso, a pomada ginecológica de barbatimão " +
                    "encontra-se em estudo sobre o efeito cicatrizante de lesões que podem evoluir para câncer do " +
                    "colo do útero. Nesse tratamento a pomada deve ser aplicada durante 6 semanas, todos os dias, " +
                    "à noite, antes de dormir.\nAtenção:\n\t1. Usar o aplicador uma única vez e desprezar;\n\t2. Este " +
                    "tratamento não impede que tenha relação sexual, mas use camisinha e aplique a pomada somente " +
                    "após a relação;\n\t3. Ao menstruar pode parar o uso da pomada nos dias de maior sangramento e em " +
                    "seguida retorna o uso todos os dias.",
                style: GoogleFonts.notoSans(
                  fontSize: 16,
                  shadows: [Shadow(color: Colors.grey, blurRadius: 2)],
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.start),
          ),
        ],
      ),
    ));
  }
}
