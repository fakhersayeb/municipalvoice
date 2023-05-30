//import 'login_screen.dart';
//import 'signup_screen.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'FadeAnimation.dart';
import 'Screens/Login/login_screen.dart';
import 'Screens/Signup/signup_screen.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffffffff),
                //Color(0xff0000ff),
                //Color(0xff0000ff),
                Color(0xffffffff),
                //Colors.blueAccent,
                //Color(0xffE6E6E6),
                //Color(0xff14279B),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeAnimation(
                  1.4,
                  Image.asset(
                    //'assets/image2-removebg-preview.png',
                    'assets/logos.png',
                    height: 200,
                    width: 150,
                  )),
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xff14279B),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Color(0xff14279B), width: 2),
                  ),
                  child: Text(
                    'Se Connecter'.tr(),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xff14279B),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Color(0xff14279B), width: 2),
                  ),
                  child: Text(
                    "S'inscrire".tr(),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
