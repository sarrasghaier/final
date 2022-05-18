import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../api/server_config.dart';

class NetworkHandler{
  String baseurl = "${ServerConfig.serverAdressess}:8090/api/v1/auth/login";
  var log = Logger();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Future get(String url) async{
    String? token = await storage.read(key: "token");
    url = formater(url);
    var response = await http.get(Uri.parse(url));
    log.i(response.body);
    log.i(response.statusCode);
  }

  String formater(String url){
    return baseurl+url;
  }


  NetworkImage getImage (String username){
    String url = '${ServerConfig.serverAdressess}:8090/api/v1/auth/login';
    return NetworkImage(url);
  }

}
