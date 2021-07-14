import 'package:app_flutter/models/login-model.dart';
import 'package:app_flutter/models/token-model.dart';
import 'package:app_flutter/services/dio-service.dart';
import 'package:localstore/localstore.dart';

class LoginService extends DioService {
  void login(LoginModel login) async {
    CollectionRef tokenCollection = Localstore.instance.collection('token');
    Map<String, dynamic> items = await tokenCollection.get();
    List<TokenModel> tokens =
        items.entries.map((entry) => entry.value['token']).toList();

    if (tokens.length == 0 || tokens.length > 1) {
      String idToken = tokenCollection.doc().id;
      tokenCollection.doc(idToken).set({"token": TokenModel("token")});
    } else {}
  }

  void logoff() {}

  bool loged() {
    return false;
  }
}
