import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forum_republique/evenement/task.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../api/server_config.dart';
import '../constants.dart';
import 'eventlst.dart';
import 'taskcontroller.dart';
import '../pages/reminder.dart';
import '../pages/widgets/header_widget.dart';
import '../pages/widgets/input_field.dart';
import '../theme/theme_helper.dart';
import 'package:http/http.dart' as http;



class AddEventPage extends StatefulWidget {
  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  final TaskController _taskController= Get.put(TaskController());
  final TextEditingController event_nameController = TextEditingController();
  final TextEditingController descriptioneventController = TextEditingController();
  final TextEditingController BugetController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController adresseventController = TextEditingController();


  DateTime _selectedDate = DateTime.now();
  String _startTime =DateFormat("hh:mm a").format(DateTime.now());
  String _endTime="9:30 PM";
  int _selectedRemind =5 ;
  List<int> remindList=[
    5,
    10,
    15,
    24,
  ];
  String _selectedRepeat ="None" ;
  List<String> repeatList=[
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];
  int _selectedColor=0;

  Future save() async {

    var res = await  http.post(
      Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/event/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "event_name": event_nameController.text,
        "descriptionEvent": descriptioneventController.text,
        "buget": BugetController.text,
        "image": imageController.text,
        "adressevent": adresseventController.text,
      }),
    );
    /*   var res = await http.post(
        Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/event/ajout"),
        headers: headers,
        body: msg);*/
    if(res.statusCode==201 ||res.statusCode==200){
      Navigator.push(
          context,  MaterialPageRoute(builder: (context) => listEvent()));
    }
    print("res.bodyres.body ${res.body}");
    print("statusCodestatusCodestatusCode ${res.statusCode}");
/*  */
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  _event() async {}
  File ? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState() => this.image = imageTemporary;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    double? height = MediaQuery
        .of(context)
        .size
        .height;
    double? width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  width: 5, color: Colors.white),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20,
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),
                            child: image != null ? Image.file(image!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ) : Icon(
                              Icons.event,
                              color: Colors.grey.shade300,
                              size: 80.0,
                            ),

                          ),
                          Container(
                              padding: const EdgeInsets.fromLTRB(80, 80, 0, 0),
                              child: IconButton(
                                onPressed: () =>
                                    pickImage(ImageSource.gallery),
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  const Text("Ajouter un évenement",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                    MyInputField(title: "event_namee", hint: "Entrer le nom de l'event",controller: event_nameController,
                    ),
                    MyInputField(title: "descriptionEvent", hint: "Entrer votre description",controller: descriptioneventController,),
                    MyInputField(title: "Budget", hint: "Entrer votre budget",controller: BugetController,),
                    MyInputField(title: "adressevent", hint: "Entrer levent adresse",controller: adresseventController,),
                    MyInputField(
                      title: "Date", hint: DateFormat.yMd().format(_selectedDate),
                         widget: IconButton(
                            icon: const Icon(Icons.calendar_today_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              print('hi there');
                              _getDateFromUser();
                            },
                          ),

                ),//date
                  Row(
                    children: [
                          Expanded(child: MyInputField(
                            title: "Heure de début",
                            hint: _startTime,
                            widget: IconButton(
                              onPressed: (){
                                _getTimeFromUser(isStartTime: true);

                              },
                              icon: const Icon(
                                Icons.access_time_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          )),//date debut
                          const SizedBox(width: 12,),
                          Expanded(child: MyInputField (
                            title: "Heure de fin",

                            hint: _endTime,
                            widget: IconButton(
                              onPressed: (){
                                _getTimeFromUser(isStartTime: false);

                              },
                              icon: const Icon(
                                Icons.access_time_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          )),//datefin
                        ],
                      ),
                      MyInputField(title: "Rappeler", hint: "$_selectedRemind heure d'avance",
                        widget: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          elevation: 4,
                          style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),
                          underline: Container(height: 0,),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedRemind = int.parse(newValue!);
                            });
                          },
                          items: remindList.map<DropdownMenuItem<String>>((int value){
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()),

                            );
                        }
                        ).toList(),
                      ),

                      ), // rappeler
                      MyInputField(title: "Répéter", hint: _selectedRepeat,
                          widget: DropdownButton(
                            icon: const Icon(Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            iconSize: 32,
                            elevation: 4,
                            style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),
                            underline: Container(height: 0,),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedRepeat = newValue!;
                              }

                              );
                            },
                            items: repeatList.map<DropdownMenuItem<String>>((String? value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value!, style: const TextStyle(color: Colors.black87),),

                              );
                            }
                            ).toList(),
                          )
                      ),// button
                          const SizedBox(height: 18,),
                          Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _colorPallete(),
                          const SizedBox(height: 10.0),
                          Container(
                            decoration:
                            ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "crée".toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                _validateDate();
                                save();
                                }

                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                ),
              ],
              ),
              )],
              ),

            )
            );



  }
  _validateDate(){
    if(event_nameController.text.isNotEmpty&&descriptioneventController.text.isNotEmpty&&adresseventController.text.isNotEmpty&&BugetController.text.isNotEmpty){
      _addTaskToDb();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ReminderPage()));
    }
  }
  _colorPallete(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Color",
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0,),
        Wrap(
            children: List<Widget>.generate(2, (int index){
              return GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedColor=index;
                    print("$index");
                  });

                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index ==0 ? bgColor:primaryColor,
                    child: _selectedColor==index?const Icon(Icons.done,
                      color: Colors.white,
                      size: 16,
                    ):Container(),

                  ),
                ),
              );
            })
        )


      ],
    );
  }


  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2222));
    if (_pickerDate!=null){
      setState(() {
        _selectedDate= _pickerDate;
        print(_selectedDate);
      });
    }else{
      print("c'est nul ou quelque chose ne va pas");
    }
  }
  _getTimeFromUser({required bool isStartTime})async{
    var pickedTime= await _showTimePicker();
    String _formatedtime = pickedTime.format(context);
    if(pickedTime==null){
      print("time canceled");
    }else if (isStartTime==true){
      setState(() {
        _startTime=_formatedtime;
      });

    }else if (isStartTime==false){
      setState(() {
        _endTime=_formatedtime;
      });

    }

  }
  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context:context,
        initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
    ));
  }
  _addTaskToDb() async {
  int value = await _taskController.addTask(
       task:Task(
         descriptionEvent: descriptioneventController.text,
         event_name: event_nameController.text,
         budget: BugetController.text,
         adressevent:adresseventController.text,
         date: DateFormat.yMd().format(_selectedDate),
         startTime: _startTime,
         endTime: _endTime,
         remind: _selectedRemind,
         repeat: _selectedRepeat,
         isCompleted: 0,
       )
   );
  print("My id is ""$value");
  }

}
