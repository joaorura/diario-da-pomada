class QuestionModel {
  bool boolResult;
  String textResult;
  String otherTextResult;
  DateTime dateResult;

  QuestionModel(
      this.boolResult, this.textResult, this.otherTextResult, this.dateResult);

  bool setValues(int element, value) {
    switch (element) {
      case 0:
        this.boolResult = value;
        break;
      case 1:
        this.textResult = value;
        break;
      case 2:
        this.otherTextResult = value;
        break;
      case 3:
        this.dateResult = value;
        break;
      default:
        return false;
    }

    return true;
  }
}
