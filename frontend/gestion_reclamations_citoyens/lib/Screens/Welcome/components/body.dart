import 'package:flutter/material.dart';
import '../../../Screens/Login/login_screen.dart';
import '../../../Screens/Signup/signup_screen.dart';
import '../../../Screens/Welcome/components/background.dart';
import '../../../components/rounded_button.dart';
import '../../../constants.dart';
// import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   "Commune de Sousse",
            //   style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: size.height * 0.05),
            // SvgPicture.asset(
            //   "assets/icons/chat.svg",
            //   height: size.height * 0.45,
            // ),
            Image.asset(
              //'assets/image2-removebg-preview.png',
              'assets/images/logos.png',
              height: 200,
              width: 150,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "Connexion",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Inscription",
              // color: kPrimaryLightColor,
              // textColor: Colors.black,

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
