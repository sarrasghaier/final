import 'package:forum_republique/api/server_config.dart';
import 'package:http/http.dart';


class AuthService {
  var loginUri =  Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/auth/login");
  var registerUri = Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/auth/registrer");

  Future<Response?> login(String username, String password) async {
    var res = await post(
        loginUri,
        body: {
          "email": username,
          "password": password
        }
    );
    return res;
  }

  Future<Response?> register(String username, String password, String firstName, String lastName,String telephone) async {
    var res = await post(
        registerUri,
        body: {
          "email": username,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
          "telephone":telephone,
        }
    );
    return res;
  }
}
