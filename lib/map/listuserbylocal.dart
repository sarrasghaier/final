import 'package:flutter/material.dart';
import 'package:forum_republique/models/user.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../api/server_config.dart';

class ListUserByLocal extends StatefulWidget {
  const ListUserByLocal ({Key? key}): super(key:key);


  @override
  _MyListState createState() => _MyListState();
}
class _MyListState extends State<ListUserByLocal > {
  var users = <User>[];
  var user;
  Future<List<User>> getAll()  async {
    var data = await http.get(
        Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/GetAllU"),
        headers: {"Content-Type": "application/json","Accept": "application/json"});
    var jsonData = json.decode(data.body);
    List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
    Iterable list = json.decode(data.body);


    if(data.statusCode==201 ||data.statusCode==200){
      users = list.map((model) => User.fromJson(model)).toList();
    }else {
      print('error !');
    }
    //  print(users.length);
    return users;
  }
  Future<String> delete(User user) async{
    var url = Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/del");
    var result = 'false';
    await http.delete(url).then((value){
      print(value.body);
      return result = 'true';
    });
    return result;
  }

  @override
  void initState()  {
    super.initState();
  }
  List<User>? _value;
  void bla() async {
    _value = await getAll() ;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child : FutureBuilder(
            future: getAll(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return const CircularProgressIndicator();
              }else{
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context,int index){
                      return  ListTile(
                        title: Text(snapshot.data[index].firstName),
                        subtitle: Text(snapshot.data[index].email),
                        trailing: IconButton(
                          icon:  const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: (){
                            setState(() {
                              delete(user);
                            });
                          },
                        ),
                      );
                    }
                );}

            }
        ));

  }
}
