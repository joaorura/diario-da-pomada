class TokenModel {
  final String acessToken;

  TokenModel(this.acessToken);

  TokenModel.fromJson(Map<String, dynamic> json)
      : acessToken = json['access_token'];

  Map<String, dynamic> toJson() => {'access_token': acessToken};
}
