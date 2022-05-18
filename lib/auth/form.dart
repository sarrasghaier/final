
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forum_republique/theme/theme_helper.dart';
import 'package:forum_republique/pages/widgets/header_widget.dart';
import 'package:intl/intl.dart';
import '../api/server_config.dart';
import '../pages/widgets/input_field.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;
import '../pages/widgets/header_widget.dart';
import '../theme/theme_helper.dart';

class form extends  StatefulWidget{
  const form({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _formState();
  }
}

class _formState extends State<form>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future save() async {
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
      Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1//ajout"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": emailController.text,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "password": passwordController.text,
        "resetPasswordToken": passwordController.text,
        "telephone": phoneNumberController.text,
      }),
    );
    /*   var res = await http.post(
        Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/ajout"),
        headers: headers,
        body: msg);*/
    if(res.statusCode==201 ||res.statusCode==200){
      Navigator.push(
          context,  MaterialPageRoute(builder: (context) => const LoginPage(errMsg: '',)));
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
  bool checkboxValue = false;
  bool checkedValue = false;
  int _value = 0;
  String? valueChoose;
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
      body: SingleChildScrollView(
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
                              ),

                            ],
                          ),
                        ),

                        const SizedBox(height: 30,),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey[200],
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 50,
                                  color: Color(0xffEEEEEE)
                              ),
                            ],
                          ),
                          child: TextFormField(
                              cursorColor: const Color(0xfff10b09),
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.credit_card_sharp,
                                  color: Color(0xfff10b09),
                                ),
                                hintText: "Cin",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,

                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter your Cin";
                                return null;
                                }
                                return null;
                              }


                          ),

                        ),
                        const SizedBox(height: 30,),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xffEEEEEE),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 20),
                                  blurRadius: 100,
                                  color: Color(0xffEEEEEE)
                              ),
                            ],
                          ),
                          child: TextFormField(
                              cursorColor: const Color(0xfff10b09),
                              decoration: const InputDecoration(
                                focusColor: Color(0xfff10b09),
                                icon: Icon(
                                  Icons.timelapse_rounded,
                                  color: Color(0xfff10b09),
                                ),
                                hintText: "age",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter your last  name";
                                return null;
                                }
                                return null;
                              }

                          ),
                        ),


                        const SizedBox(height: 30,),
                        MyInputField(
                          title: "Date de naissance", hint: DateFormat.yMd().format(_selectedDate),
                          widget: IconButton(
                            icon: const Icon(Icons.calendar_today_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              print('hi there');
                              _getDateFromUser();
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: _value,
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value as int;
                                      });
                                    },
                                  ),
                                  const Text("Femme")
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 2,
                                    groupValue: _value,
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value as int;
                                      });
                                    },
                                  ),
                                  const Text("Homme")
                                ],),
                              ],
                            )
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey[200],
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 50,
                                  color: Color(0xffEEEEEE)
                              ),
                            ],
                          ),
                          child: TextFormField(
                            cursorColor: const Color(0xfff10b09),
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.work,
                                color: Color(0xfff10b09),
                              ),
                              hintText: "Profession",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter your profession";
                                return null;
                                }
                                return null;
                              }
                          ),
                        ),

                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xffEEEEEE),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 20),
                                  blurRadius: 100,
                                  color: Color(0xffEEEEEE)
                              ),
                            ],
                          ),
                          child: TextFormField(
                            cursorColor: const Color(0xfff10b09),
                            decoration: const InputDecoration(
                              focusColor: Color(0xfff10b09),
                              icon: Icon(
                                Icons.flag,
                                color: Color(0xfff10b09),
                              ),
                              hintText: "nationnalité ",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter your nationnalité";
                                return null;
                                }
                                return null;
                              }
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xffEEEEEE),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 20),
                                  blurRadius: 100,
                                  color: Color(0xffEEEEEE)
                              ),
                            ],
                          ),
                          child: TextFormField(
                              cursorColor: const Color(0xfff10b09),
                              decoration: const InputDecoration(
                                focusColor: Color(0xfff10b09),
                                icon: Icon(
                                  Icons.outlined_flag,
                                  color: Color(0xfff10b09),
                                ),
                                hintText: "Zip",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter your zip code";
                                return null;
                                }
                                return null;
                              }
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xffEEEEEE),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 20),
                                  blurRadius: 100,
                                  color: Color(0xffEEEEEE)
                              ),
                            ],
                          ),
                          child: TextFormField(
                              cursorColor: const Color(0xfff10b09),
                              decoration: const InputDecoration(
                                focusColor: Color(0xfff10b09),
                                icon: Icon(
                                  Icons.location_on,
                                  color: Color(0xfff10b09),
                                ),
                                hintText: "Country",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter your country";
                                return null;
                                }
                                return null;
                              }

                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xffEEEEEE),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 20),
                                  blurRadius: 100,
                                  color: Color(0xffEEEEEE)
                              ),
                            ],
                          ),
                          child: TextFormField(
                              cursorColor: const Color(0xfff10b09),
                              decoration: const InputDecoration(
                                focusColor: Color(0xfff10b09),
                                icon: Icon(
                                  Icons.location_on,
                                  color: Color(0xfff10b09),
                                ),
                                hintText: "region",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter your region";
                                return null;
                                }
                                return null;
                              }

                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xffEEEEEE),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 20),
                                  blurRadius: 100,
                                  color: Color(0xffEEEEEE)
                              ),
                            ],
                          ),
                          child: TextFormField(
                              cursorColor: const Color(0xfff10b09),
                              decoration: const InputDecoration(
                                focusColor: Color(0xfff10b09),
                                icon: Icon(
                                  Icons.emoji_flags,
                                  color: Color(0xfff10b09),
                                ),
                                hintText: "etat",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter your etat";
                                return null;
                                }
                                return null;
                              }

                          ),
                        ),
                        const SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    const Text(
                                      "J'accepte tous les conditions",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Theme
                                        .of(context)
                                        .errorColor, fontSize: 12,),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'Vous devez accepter les termes et conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration:
                          ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                              const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "enregistrer".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                save();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
}

class MyAlertDialog extends StatelessWidget{
  final String title;
  final String content;
  final List<Widget>actions;

  const MyAlertDialog({
    required this.title,
    required this.content,
    this.actions =const[],
  });
  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: actions,
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyText1,
      ),

    );
  }
}
