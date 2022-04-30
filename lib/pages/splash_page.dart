import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ishonch_test/funksion/colorhex.dart';
import 'package:ishonch_test/funksion/text.dart';
import 'package:ishonch_test/pages/homepage.dart';
import 'package:ishonch_test/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  _initTimer()async{
   var box = Hive.box("MyBaza");
   var res = await box.get("auth");
    Timer(const Duration(milliseconds: 900), () {
      if(res==null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
      }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));  
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors:[
             Colors.blue.withOpacity(0.8),
             Colors.blue.withOpacity(0.9),
            ] )
        ),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 40),
        // ignore: prefer_const_constructors
        child: TextWidget.txt("Test", 25, FontWeight.w700, ColorHex.colorFromHex("#FFFFFF"))
      ),
    );
  }
}