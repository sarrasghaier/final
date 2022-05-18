

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';


import 'package:forum_republique/evenement/add_event.dart';
import 'package:forum_republique/pages/widgets/button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../evenement/taskcontroller.dart';


class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final _taskController = Get.put(TaskController());
  DateTime _selectDate = DateTime.now();
  var notifyHelper ;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    setState(() {
      print("I am here");
    });

  }

  @override
  Widget build(BuildContext context) {
    print ("build method called");
    return Scaffold(
      appBar: AppBar( title: const Text(" Page des Rappels",
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
      body: Column(
        children: [
          _addTaskBar(),

          Container(
            margin: const EdgeInsets.only(top: 20,left:20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.red,
              selectedTextColor: Colors.white,
              dateTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey,

              ),
              dayTextStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,

              ),
              monthTextStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,

              ),
              onDateChange: (date){
                _selectDate=date;

              },
            ),
          )

        ],
      ),

    );

  }

  // _showTasks(){
  //   return Expanded(
  //     child:Obx((){
  //       return ListView.builder(
  //           itemCount: _taskController.taskList.length,
  //
  //           itemBuilder: (_,context){
  //             print(_taskController.taskList.length);
  //             return Container(
  //               width: 100,
  //               height: 50,
  //               color: Colors.blue,
  //               margin: const EdgeInsets.only(bottom: 10),
  //             );
  //           });
  //     }),
  //   );
  //
  // }
  _addTaskBar(){
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now(),),
                  style: const TextStyle(fontWeight: FontWeight.bold),

                ),
                const Text("Aujourd'hui",
                  style: TextStyle(fontWeight: FontWeight.bold),

                )
              ],
            ),
          ),
          MyButton(label: "+ Ajouter ".toUpperCase(), onTap: (){
            //After successful login we will redirect to profile page. Let's create profile page now
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddEventPage()));
          },),
        ],
      ),
    );
  }


}



