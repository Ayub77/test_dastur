// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:ishonch_test/funksion/colorhex.dart';
import 'package:ishonch_test/funksion/text.dart';
import 'package:ishonch_test/viewmodel/login_viewmodel.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginViewmodel viewmodel = LoginViewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  height: 300,
                  width: 300,
                  image: AssetImage("assets/images/test.png")),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: viewmodel.loginController,
                decoration: InputDecoration(
                  label: Text("Login"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: viewmodel.parolController,
                decoration: InputDecoration(
                  label: Text("Parol"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              FlatButton(
                  height: 60,
                  minWidth: double.infinity,
                  onPressed: () {
                    viewmodel.getlogin(context);
                  },
                  child: TextWidget.txt("Tasdiqlash", 20, FontWeight.w600, ColorHex.colorFromHex("#FFFFFF")),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)))
            ],
          ),
        ),
      ),
    );
  }
}
