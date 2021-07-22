enum TypeUserEnum { normal, admin }

class TypeUserModel {
  TypeUserEnum typeUser;

  TypeUserModel.fromJson(Map<String, dynamic> json)
      : typeUser = TypeUserEnum.values[json['typeUser']];
}
