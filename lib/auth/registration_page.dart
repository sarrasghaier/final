
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:forum_republique/theme/theme_helper.dart';
import 'package:forum_republique/pages/widgets/header_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import '../api/server_config.dart';
import 'form.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends  StatefulWidget{
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
     return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage>{
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/ajout"),
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
          context,  MaterialPageRoute(builder: (context) => const form()));
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

  _register() async {}
  File ? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null ) return;
      final imageTemporary = File(image.path);
      setState()=> this.image = imageTemporary;
    } on PlatformException catch (e){
      print('Failed to pick image: $e');
    }
  }
  bool checkedValue = false;
  bool checkboxValue = false;
  int _value = 0;
  String? valueChoose;
  List listItem = [
    "Medicine", "Education", "Commerce", "Culture", "Banque","S??curit??","D??fense","Informatique","Autre"
  ];

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
                                  Icons.person,
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
                                  Icons.person,
                                  color: Color(0xfff10b09),
                                ),
                                hintText: "First Name",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,

                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter your name";
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
                                  Icons.person,
                                  color: Color(0xfff10b09),
                                ),
                                hintText: "last Name",
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
                                  const Text("Mr")
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
                                  const Text("Mme")
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 3,
                                    groupValue: _value,
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value as int;
                                      });
                                    },
                                  ),
                                  const Text("Mlle")
                                ],),

                              ],
                            )
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: DropdownButton(
                                  hint: const Text("Select Domain: "),
                                  dropdownColor: Colors.white,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 36,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 22
                                  ),
                                  value: valueChoose,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      valueChoose = newValue!;
                                    });
                                  },
                                  items: listItem.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem.toString(),
                                      child: Text(valueItem.toString()),
                                    );
                                  }).toList()
                              ),
                            ),
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
                                Icons.email,
                                color: Color(0xfff10b09),
                              ),
                              hintText: "Email",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            validator: (val) {
                              if (!(val!.isEmpty) && !RegExp(
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(val)) {
                                return "Entrer un email valide";
                              } else if (val.isEmpty) {
                                return "Please enter your email adresse";
                              return null;
                              }
                              return null;
                            },

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
                                Icons.phone,
                                color: Color(0xfff10b09),
                              ),
                              hintText: "Phone Number",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            validator: (val) {
                              if (!(val!.isEmpty) &&
                                  !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                return "Enter a valid phone number";
                              } else if (val.isEmpty) {
                                return "Please enter your mobile phone";
                              return null;
                              }
                              return null;
                            },

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
                                  Icons.vpn_key,
                                  color: Color(0xfff10b09),
                                ),
                                hintText: "Enter Password",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Entrer votre mot de passe";
                                } else if (val.length < 8) {
                                  return "Entrer un mot de passe valide";
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
                                hintText: "Home Adress",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter your Home Adress";
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
                                hintText: "Work Adresse",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter your Work Adresse";
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
                                      "J'accepte tous les termes .",
                                      style: TextStyle(color: Colors.grey),),
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
                                "Registrer".toUpperCase(),
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
                        const SizedBox(height: 30.0),
                        const Text(
                          "Ou cr??ez un compte en utilisant les m??dias sociaux",
                          style: TextStyle(color: Colors.grey),),
                        const SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.googlePlus, size: 35,
                                color: HexColor("#EC2D2F"),),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Google Plus",
                                          "You tap on GooglePlus social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                            const SizedBox(width: 30.0,),
                            GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 5, color: HexColor("#40ABF0")),
                                  color: HexColor("#40ABF0"),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.twitter, size: 23,
                                  color: HexColor("#FFFFFF"),),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Twitter",
                                          "You tap on Twitter social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                            const SizedBox(width: 30.0,),
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.facebook, size: 35,
                                color: HexColor("#3E529C"),),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Facebook",
                                          "You tap on Facebook social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                          ],
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
