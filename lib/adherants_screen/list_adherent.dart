import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/server_config.dart';
import '../auth/login_page.dart';
import 'formadduser.dart';
import 'list.dart';
import 'modifier.dart';



class Home extends StatefulWidget {
  int state;
  int id;
  Home(this.state,this.id);
  @override
  _HomeState createState() => _HomeState(this.state,this.id);
}

class _HomeState extends State<Home> {
  late int state;
  late int id;
  int _currentIndex = 0;

  _HomeState(this.state,this.id);
  Future getAdherents() async {
/*    final msg = jsonEncode(<String, String>{
      "email": "eeeeeeeeee",
      "firstName": "string",
      "lastName": "string",
      "password": "string",
      "resetPasswordToken": "string",
      "telephone": "string"
    });
    Map<String, String> headers = {
      "Context-Type": "application/json",
      "Accept": "application/json",
    };*/
    var res = await  http.post(
      Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/GetAllU"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{


      }),
    );
    /*   var res = await http.post(
        Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/ajout"),
        headers: headers,
        body: msg);*/
    if(res.statusCode==201 ||res.statusCode==200){
      Navigator.push(
          context,  MaterialPageRoute(builder: (context) => const LoginPage()));
    }else {
      print('error !');
    }
    print("res.bodyres.body ${res.body}");
    print("statusCodestatusCodestatusCode ${res.statusCode}");
/*  */
  }

  @override
  void initState() {
    super.initState();
    changeView(state);
  }
  void _onTap(index){
    changeView(index);
  }
 late  Widget _body;
  late String _title;
  void changeView(index){
    _currentIndex = index;
    setState(() {
      switch (index) {
        case 0:{
          _title="Ajouter";
          _body=MyForm(this.id);
          break;
        }
        case 1:{
          _title="Liste";
          _body=MyList();
          break;
        }
        case 2:{
          _title="Modifier";
          _body=Modif(id);
          break;
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
      Scaffold(
        appBar: AppBar(
          title: Text(_title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace:Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                )
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only( top: 16, right: 16,),
              child: Stack(
                children: <Widget>[
                  Icon(Icons.notifications),
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(6),),
                      constraints: BoxConstraints( minWidth: 12, minHeight: 12, ),
                      child: Text( '5', style: TextStyle(color: Colors.white, fontSize: 8,), textAlign: TextAlign.center,),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        body:_body,
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.add),),
            BottomNavigationBarItem(icon: Icon(Icons.table_chart),),
            BottomNavigationBarItem(icon: Icon(Icons.mode_edit),),
          ],
          currentIndex: _currentIndex,
          onTap: _onTap,

          ),
      )
    );
  }
}
