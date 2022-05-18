import 'package:flutter/material.dart';
import 'package:forum_republique/api/server_config.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../models/eve.dart';

class EventList extends StatefulWidget {
  const EventList({Key? key}): super(key:key);


  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  var events = <eve>[];
  var event;
  Future<List<eve>> getAll() async {
    var data = await http.get(
        Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/event/"),
        headers: {"Content-Type": "application/json","Accept": "application/json"});
    var body = json.decode(data.body);
    List<eve> userFromJson(String str) => List<eve>.from(json.decode(str).map((x) => eve.fromJson(x)));
    Iterable list = json.decode(data.body);
    List<eve>events =[];
    events.clear();
    for (var item in body ){
      events.add(eve.fromJson(item));
    }
        //
        //  print("jsonDatajsonDatajsonData ${eve[0].name}");
        // List<eve> users =[];
        // for(var u in jsonData){
        // }
        // User user =eve(u['id'],u['name'],u['email'],u['password']);
        // users.add(eve);
        //  }
    if(data.statusCode==201 ||data.statusCode==200){
      events = list.map((model) => eve.fromJson(model)).toList();
    }else {
      print('error !');
    }
    //  print(users.length);
    return events;
  }
  Future<String> delete(eve event) async{
    var url = Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/event/");
    var result = 'false';
    await http.delete(url).then((value){
      print(value.body);
      return result = 'true';
    });
    return result;
  }
  late List<eve> _value;
  @override
  void initState() async{
    _value = await getAll() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAll(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.data == null){
            return const CircularProgressIndicator();
          }else{
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context,int index){
                  return  ListTile(
                    title: Text(snapshot.data[index].List),
                    subtitle: Text(snapshot.data[index].firstName),
                    trailing:
                    IconButton(
                      icon:  const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: (){
                        setState(() {
                          delete(event);
                        });
                      },
                    ),
                  );

                }
            );}

        }
    );

  }
}

