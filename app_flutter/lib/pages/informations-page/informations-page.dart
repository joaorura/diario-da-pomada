import 'package:app_flutter/models/informations-model.dart';
import 'package:expandable_group/expandable_group_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformationsPage extends StatelessWidget {
  final List<InformationsModel> listInformations = [
    InformationsModel(
        "Qual o motivação do aplicativo?",
        "Esse aplicativo te ajuda a lembrar do uso diário da pomada ginecológica. Além disso, orienta" +
            " sobre a pomada ginecológica de barbatimão, como você deve usá-la e o tempo de uso."),
    InformationsModel(
        "Como a pomada funciona?",
        "O barbatimão é uma planta conhecida popularmente e cientificamente pelas propriedades" +
            " anti-inflamatórias, antifúngicas, anticâncer.\nCom isso, a pomada ginecológica de" +
            " barbatimão encontra-se em estudo sobre o efeito cicatrizante de lesões que podem evoluir" +
            " para câncer do colo do útero. Nesse tratamento a pomada deve ser aplicada durante 6 semanas," +
            " todos os dias, à noite, antes de dormir.\nAtenção:\n1. Usar o aplicador uma única vez e" +
            " desprezar;\n2. Este tratamento não impede que tenha relação sexual, mas use camisinha e" +
            " aplique a pomada somente após a relação;\n3. Ao menstruar pode parar o uso da pomada nos" +
            " dias de maior sangramento e em seguida retorna o uso todos os dias."),
    InformationsModel(
        "Quem somos nós?",
        "Somos um grupo de pesquisadores, enfermeiras, professoras e acadêmicos da Universidade Federal" +
            " de Alagoas (UFAL), Campus Arapiraca e Maceió, em parceria com pesquisadores da Universidade" +
            " Federal de Pernambuco (UFPE):\n" +
            "\t- Professora Doutoranda Nirliane Ribeiro Barbosa - UFAL\n" +
            "\t- Professora Doutora Karol Fireman de Farias - UFAL\n" +
            "\t- Professora Doutora Cristiane Araújo Nascimento - UFAL\n" +
            "\t- Professora Doutora Teresinha Gonçalves da Silva - UFPE\n" +
            "\t- Acadêmico em Ciências da Computação João Messias Lima Pereira - UFAL\n" +
            "\t- Acadêmico em Ciências da Computação Vitor Barcelos de Cerqueira - UFAL\n"),
    InformationsModel(
        "O que fazemos?",
        "Trabalhamos na área do cuidado à saúde das mulheres e prevenção do câncer de colo do útero" +
            " por meio de projetos de extensão e de pesquisa ofertados pela Universidade Federal de" +
            " Alagoas, Campus Arapiraca.\n" +
            "Desde 2019, estamos trabalhando com o projeto de pesquisa Ensaio Clínico Randomizado" +
            " de uma Nova Alternativa de Tratamento Tópico das Lesões do Colo Uterino, no qual" +
            " convidamos mulheres com lesão de alto grau no colo do útero para usarem a pomada de" +
            " barbatimão e avaliarmos os efeitos dessa pomada sobre a lesão."),
    InformationsModel(
        "Como entrar em contato conosco?",
        "Através do endereço de e-mail nirliane.barbosa@arapiraca.ufal.br  ou do número de telefone/" +
            " whatsapp (082) 999826404."),
    InformationsModel(
        "Como você pode participar conosco?",
        "Participando dos encontros, reuniões e consultas marcadas pelo grupo e/ou usando a" +
            " pomada ginecológica de barbatimão em estudo.")
  ];

  Widget _header(String title) => Text(title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ));

  List<ListTile> _buildItems(BuildContext context, String text) {
    List<ListTile> list = [
      ListTile(
          title: Text(
        text,
      ))
    ];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: <Widget>[
        Column(
          children: listInformations.map((group) {
            return ExpandableGroup(
              isExpanded: listInformations.indexOf(group) == 0,
              header: _header(group.title),
              items: _buildItems(context, group.text),
              headerEdgeInsets: EdgeInsets.only(left: 16.0, right: 16.0),
            );
          }).toList(),
        )
      ],
    ));
  }
}
