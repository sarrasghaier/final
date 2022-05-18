
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forum_republique/pages/reminder.dart';
import 'package:forum_republique/statistique/statistiques.dart';
import '../adherants_screen/list.dart';
import '../adherants_screen/updateadherants.dart';
import '../auth/NetworkHandler.dart';
import '../evenement/add_event.dart';
import '../evenement/event.dart';
import '../map/listuserbylocal.dart';
import '../models/Profilemodel.dart';
import 'Donate.dart';



class ProfilePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>{

  bool circular = true ;
  ProfilModel profileModel = ProfilModel('','','','','');
  NetworkHandler networkHandler= NetworkHandler();

  final double  _drawerIconSize = 24;
  final double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).colorScheme.secondary,]
              )
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only( top: 16, right: 16,),
            child: Stack(
              children: <Widget>[
                const Icon(Icons.notifications),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(6),),
                    constraints: const BoxConstraints( minWidth: 12, minHeight: 12, ),
                    child: const Text( '5', style: TextStyle(color: Colors.white, fontSize: 8,), textAlign: TextAlign.center,),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  ]
              )
          ) ,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 1.0],
                    colors: [ Theme.of(context).primaryColor,Theme.of(context).colorScheme.secondary,],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text("Forum de la république",
                    style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings, size: _drawerIconSize, color: Theme.of(context).colorScheme.secondary,),
                title: Text('Paramétres', style: TextStyle(fontSize: 17, color: Theme.of(context).colorScheme.secondary),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => updateAdherants()));
                },
              ),
              ListTile(
                leading: Icon(Icons.event,size: _drawerIconSize,color: Theme.of(context).colorScheme.secondary),
                title: Text('Evenements', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EventPage()),);
                },
              ),
              ListTile(
                leading: Icon(Icons.event,size: _drawerIconSize,color: Theme.of(context).colorScheme.secondary),
                title: Text('ajouter un evenement', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).colorScheme.secondary),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddEventPage()),);
                },
              ),
              ListTile(
                leading: Icon(Icons.insert_chart, size: _drawerIconSize,color: Theme.of(context).colorScheme.secondary),
                title: Text('Statistique',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).colorScheme.secondary),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => statPage()),);
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_money, size: _drawerIconSize,color: Theme.of(context).colorScheme.secondary,),
                title: Text('Donation',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).colorScheme.secondary),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => donatePage()),);
                },
              ),
              ListTile(
                leading: Icon(Icons.date_range, size: _drawerIconSize,color: Theme.of(context).colorScheme.secondary,),
                title: Text('Rappel',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).colorScheme.secondary),),
                onTap: () {


                  Navigator.push( context, MaterialPageRoute(builder: (context) => const ReminderPage()), );
                },
              ),
              ListTile(
                leading: Icon(Icons.list, size: _drawerIconSize,color: Theme.of(context).colorScheme.secondary),
                title: Text('liste',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).colorScheme.secondary),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyList()),);
                },
              ),
              ListTile(
                leading: Icon(Icons.map, size: _drawerIconSize,color: Theme.of(context).colorScheme.secondary),
                title: Text('map',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).colorScheme.secondary),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ListUserByLocal()),);
                },
              ),
              Divider(color: Theme.of(context).primaryColor, height: 1,),
              ListTile(
                leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).colorScheme.secondary,),
                title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).colorScheme.secondary),),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset("assets/images/sarra2.jpg"),
                      height: 200,
                      width: 200,
                    ),


                  const SizedBox(height: 20,),
                  const Text('Sarra', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  const Text('XXXXXX', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}