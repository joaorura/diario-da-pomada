class DataModel {
  final String name;
  final String healthCard;

  DataModel(this.name, this.healthCard);

  DataModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        healthCard = json['healthCard'];
}

class UserDataModel {
  final List<DataModel>? users;

  UserDataModel(this.users);

  static List<DataModel> _convert(List<dynamic> data) {
    List<DataModel> result = [];
    for (var item in data) {
      DataModel data = DataModel.fromJson(item);
      result.add(data);
    }

    return result;
  }

  UserDataModel.fromJson(Map<String, dynamic> json)
      : users = _convert(json['users']);
}
