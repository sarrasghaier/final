
import 'package:forum_republique/api/server_config.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'apiinterceptor.dart';

class ApiService {
  Client client = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  Future<Response> getMyProfile(String id) async {
    var myProfileUri = Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/$id");
    final res = await client.get(myProfileUri);
    return res;
  }

  Future<Response> getUserList() async {
    var userUrl = Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/GetAllU");
    final res = await client.get(userUrl);
    return res;
  }

  Future<Response> getUserById(String id) async {
    var userUrl = Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/$id");
    final res = await client.get(userUrl);
    return res;
  }

  Future<Response> addUser(int roleId, String email, String password,
      String firstName,String lastName, String telephone) async {
    var userUrl = Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/ajout");
    final res = await client.post(userUrl, body: {
      "role_id": roleId.toString(),
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName":lastName,
      "telephone": telephone
    });
    return res;
  }

  Future<Response> updateUser(
      int? id, int roleId, String email, String firstName,String lastName, String telephone) async {
    var userUrl = Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/update/$id");
    final res = await client.put(userUrl, body: {
      "role_id": roleId.toString(),
      "email": email,
      "firstName": firstName,
      "lastName" :lastName,
      "phone": telephone
    });
    return res;
  }

  Future<Response> deleteUser(String id) async {
    var userUrl = Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/del/$id");
    final res = await client.delete(userUrl);
    return res;
  }

  Future<Response> getRoleList() async {
    var rolerUrl = Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/roles/");
    final res = await client.get(rolerUrl);
    return res;
  }

  Future<Response> getRoleById(String id) async {
    var rolerUrl = Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/roles/$id");
    final res = await client.get(rolerUrl);
    return res;
  }

  Future<Response> addRole(String roleName) async {
    var rolerUrl =Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/roles/");
    final res = await client.post(rolerUrl,
        body: {"role_name": roleName});
    return res;
  }

  Future<Response> updateRole(
      int? id, String roleName) async {
    var rolerUrl = Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/roles/$id");
    final res = await client.put(rolerUrl,
        body: {"role_name": roleName});
    return res;
  }

  Future<Response> deleteRole(String id) async {
    var rolerUrl = Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/roles/$id");
    final res = await client.delete(rolerUrl);
    return res;
  }
}
