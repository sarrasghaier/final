import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:forum_republique/auth/callapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/auth_service.dart';
import '../api/server_config.dart';
import '../pages/user_screen.dart';
import '../pages/widgets/header_widget.dart';
import '../theme/theme_helper.dart';
import 'forgot_password_page.dart';
import 'registration_page.dart';
import 'package:http/http.dart' as http ;

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key,required this.errMsg}): super(key:key);
  final String errMsg;
  static const String _title = 'Login';
  @override

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  late String errorText;
  bool validate=false;
  bool circular=false;
  final AuthService authService = AuthService();
  final storage = const FlutterSecureStorage();
  final double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();
  Future login() async {
    var res = await  http.post(
      Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/auth/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": emailController.text,
        "password": passwordController.text,

      }),
    );
    /*   var res = await http.post(
        Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/users/ajout"),
        headers: headers,
        body: msg);*/
    if(res.statusCode==201 ||res.statusCode==200){
      Navigator.push(
          context,  MaterialPageRoute(builder: (context) => ProfilePage()));
    }
    print("res.bodyres.body ${res.body}");
    print("statusCodestatusCodestatusCode ${res.statusCode}");
/*  */
  }
  Future verif() async {
    var res = await  http.post(
      Uri.parse("${ServerConfig.serverAdressess}:8090/api/v1/auth/verif"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": emailController.text,
      }),
    );
    if(res.statusCode==201 ||res.statusCode==200){
      Navigator.push(
          context,  MaterialPageRoute(builder: (context) =>  ProfilePage()));
    }else {
      print('error !');
    }
    print("res.bodyres.body ${res.body}");
    print("statusCodestatusCodestatusCode ${res.statusCode}");
/*  */
  }
  _showMsg(msg) { //
    final snackBar = SnackBar(
      backgroundColor: const Color(0xFF363f93),
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  _login() async {
    var data = {
      'email' : emailController.text,
      'password' : passwordController.text,
    };

    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    print(body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage()));
    }else{
      _showMsg(body['message']);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                  child: Column(
                    children: [
                      const Image(
                        image:NetworkImage('https://scontent.ftun16-1.fna.fbcdn.net/v/t1.6435-9/117648424_637219530239329_370547406072171631_n.jpg?_nc_cat=102&ccb=1-6&_nc_sid=09cbfe&_nc_ohc=oLCVX_n6cTwAX_Jvt4R&_nc_ht=scontent.ftun16-1.fna&oh=00_AT-G3UDrwhFJyIw139DB9w1rVd3jngCsmDSPBwlTVHUNRg&oe=62A759E2'),
                        height: 100,
                        width: 100,
                      ),
                      const Text(
                        'FORUM DE LA REPUBLIQUE',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const Text(
                        'connectez-vous ?? votre compte',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  controller:emailController,
                                    decoration: ThemeHelper().textInputDecoration('Nom d\'utilisateur', 'Entrez votre nom d\'utilisateur'
                                    ),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Entrer votre email !";
                                      }
                                      // else {
                                      //   verif();
                                      // }

                                      return null;
                                    }



                                ),
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              const SizedBox(height: 30.0),
                              Container(
                                child: TextFormField(
                                  controller: passwordController,
                                    obscureText: true,
                                    decoration: ThemeHelper().textInputDecoration('Mot de passe', 'Entrez votre Mot de passe'),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Entrer votre mot de passe";
                                      } else if (val.isEmpty) {
                                        return "Entrer un mot de passe valide";
                                      }
                                      return null;
                                    }
                                ),
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              const SizedBox(height: 15.0),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10,0,10,20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push( context, MaterialPageRoute( builder: (context) => const ForgotPasswordPage()), );
                                  },
                                  child: const Text( "Mot de passe oubli???", style: TextStyle( color: Colors.grey, ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text('identifier'.toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                                  onPressed: (){
                                    if (!_formKey.currentState!.validate()) {
                                      return ;
                                    }
                                      _login();


                                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));




                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10,20,10,20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          const TextSpan(text: "vous n'avez pas de compte? "),
                                          TextSpan(
                                            text: 'Cr??er',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationPage()));
                                              },
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                                          ),
                                        ]
                                    )
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );

  }
}
