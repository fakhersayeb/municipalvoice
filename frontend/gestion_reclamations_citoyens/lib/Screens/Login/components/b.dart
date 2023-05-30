import 'package:flutter/material.dart';
import 'package:gestion_reclamations_citoyens/Screens/Home/HomeScreen.dart';
import 'background.dart';
import '../../../../../../Screens/Signup/signup_screen.dart';
import '../../../../../../components/already_have_an_account_acheck.dart';
import '../../../../../../components/rounded_button.dart';
import '../../../../../../constants.dart';
import '../../../../../../components/rounded_input_field.dart';
import '../../../../../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body5 extends StatelessWidget {
  const Body5({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Connexion",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Center(
              child: Image(
                image: AssetImage(
                  'assets/icons/logos.png',
                ),
                height: 200.0,
                width: 200.0,
              ),
            ),
            // SvgPicture.asset(
            //   "assets/icons/login.svg",
            //   height: size.height * 0.35,
            // ),
            // SizedBox(height: size.height * 0.03),
            // SizedBox(width: 7.53),
            Container(
              // padding: const EdgeInsets.all(28.0),
              padding: const EdgeInsets.fromLTRB(30, 35, 30, 5),
              // margin: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          fillColor: kPrimaryLightColor,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                            child: Icon(
                              Icons.person,
                              color: kPrimaryColor,
                            ), // icon is 48px widget.
                          ),
                          hintText: "Votre Email",
                          // border: InputBorder.none,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          // border: OutlineInputBorder(
                          //   borderRadius:
                          //       BorderRadius.circular(30.0),

                          // ),
                          // fillColor: Color(0xfff3f3f4),
                          //fillColor: Colors.grey[300],
                          filled: true))
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(28.0),
              // margin: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                          fillColor: kPrimaryLightColor,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                            child: Icon(
                              Icons.lock,
                              color: kPrimaryColor,
                            ), // icon is 48px widget.
                          ),
                          hintText: "Votre Mot de passe",
                          // border: InputBorder.none,
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          // border: OutlineInputBorder(
                          //   borderRadius:
                          //       BorderRadius.circular(30.0),

                          // ),
                          // fillColor: Color(0xfff3f3f4),
                          //fillColor: Colors.grey[300],
                          filled: true))
                ],
              ),
            ),
            // RoundedInputField(
            //   hintText: "Votre Email",
            //   onChanged: (value) {},
            // ),

            // RoundedPasswordField(
            //   onChanged: (value) {},
            // ),
            RoundedButton(
              text: "Connexion",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
