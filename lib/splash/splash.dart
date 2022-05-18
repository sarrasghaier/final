import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:forum_republique/pages/home_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    (SchedulerBinding.instance)!.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 3000));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => homePage()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.white],
            stops: [0, 1],
          ),
        ),
        child: Center(
          child:
          Image.asset('logo.png',
            width: 200,
            height: 200,
          ),
      ),
      ),

    );
  }
}
