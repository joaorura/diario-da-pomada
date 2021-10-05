enum TypeUserEnum { user, admin }

class TypeUserModel {
  TypeUserEnum typeUser;

  static TypeUserEnum _getEnum(String label) {
    switch (label) {
      case 'user':
        return TypeUserEnum.user;
      case 'admin':
        return TypeUserEnum.admin;
      default:
        throw new Exception("Label não encontrado dentro do TypeUserEnum");
    }
  }

  TypeUserModel(this.typeUser);

  TypeUserModel.fromJson(Map<String, dynamic> json)
      : typeUser = _getEnum(json['role']);
}
