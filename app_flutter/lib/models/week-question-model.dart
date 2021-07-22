import 'package:intl/intl.dart';

class WeekQuestionModel {
  bool dificuldadeIntroducao;

  bool aplicouDormirSexo;

  bool sentiuIncomodo;
  String tipoIncomodo;
  String outroTipoIncomodo;

  String tipoSujeiraCalcinha;
  String outroTipoSujeiraCalcinha;

  String tipoCorResiduoCalcinha;
  String outroTipoCorResiduoCalcinha;

  bool sanguePresente;

  bool dificuldadeSexo;
  String tipoDificuldadeSexo;

  bool menstruouRecentemente;
  DateTime dataMenstruacao;

  bool mestruacaoIgualAnterior;
  String tipoMestruacaoDiferente;

  bool parouUso;
  String motivoParadaUso;

  DateTime dataDeMarcacao;
  DateTime dataDePreenchimento;

  static const String _otherDefault = "outr";

  bool containsOther(String text) {
    if (text == null) {
      return false;
    }
    return text.toLowerCase().contains(_otherDefault);
  }

  void removeAllOther() {
    if (containsOther(tipoIncomodo)) {
      tipoIncomodo = outroTipoSujeiraCalcinha;
      outroTipoSujeiraCalcinha = null;
    }

    if (containsOther(tipoSujeiraCalcinha)) {
      tipoSujeiraCalcinha = outroTipoSujeiraCalcinha;
      outroTipoSujeiraCalcinha = null;
    }

    if (containsOther(tipoCorResiduoCalcinha)) {
      tipoCorResiduoCalcinha = outroTipoCorResiduoCalcinha;
      outroTipoCorResiduoCalcinha = null;
    }
  }

  bool validate() {
    return !(dificuldadeIntroducao == null ||
        aplicouDormirSexo == null ||
        sentiuIncomodo == null ||
        (sentiuIncomodo != null &&
            sentiuIncomodo == true &&
            tipoIncomodo == null) ||
        tipoSujeiraCalcinha == null ||
        tipoCorResiduoCalcinha == null ||
        sanguePresente == null ||
        dificuldadeSexo == null ||
        (dificuldadeSexo != null &&
            dificuldadeSexo == true &&
            tipoDificuldadeSexo == null) ||
        menstruouRecentemente == null ||
        (menstruouRecentemente != null &&
            menstruouRecentemente == true &&
            dataMenstruacao == null) ||
        mestruacaoIgualAnterior == null ||
        (mestruacaoIgualAnterior != null &&
            mestruacaoIgualAnterior == false &&
            tipoMestruacaoDiferente == null) ||
        parouUso == null ||
        (parouUso != null && parouUso == true && motivoParadaUso == null) ||
        dataDeMarcacao == null ||
        dataDePreenchimento == null);
  }

  Map<String, dynamic> toJson() => {
        "dificuldadeIntroducao": dificuldadeIntroducao,
        "aplicouDormirSexo": aplicouDormirSexo,
        "sentiuIncomodo": sentiuIncomodo,
        "tipoIncomodo": tipoIncomodo,
        "tipoSujeiraCalcinha": tipoSujeiraCalcinha,
        "tipoCorResiduoCalcinha": tipoCorResiduoCalcinha,
        "sanguePresente": sanguePresente,
        "dificuldadeSexo": dificuldadeSexo,
        "tipoDificuldadeSexo": tipoDificuldadeSexo,
        "menstruouRecentemente": menstruouRecentemente,
        "dataMenstruacao": DateFormat('yyyy-MM-dd').format(dataMenstruacao),
        "mestruacaoIgualAnterior": mestruacaoIgualAnterior,
        "tipoMestruacaoDiferente": tipoMestruacaoDiferente,
        "parouUso": parouUso,
        "motivoParadaUso": motivoParadaUso,
        "dataDeMarcacao": DateFormat('yyyy-MM-dd').format(dataDeMarcacao),
        "dataDePreenchimento":
            DateFormat('yyyy-MM-dd').format(dataDePreenchimento)
      };
}
