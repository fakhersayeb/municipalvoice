import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestion_reclamations_citoyens/Screens/Home/HomeScreen.dart';
import 'package:gestion_reclamations_citoyens/components/adressrounded_input_field.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Screens/Login/login_screen.dart';
import '../../../shared.dart';
import '../../../constants.dart';
import 'background.dart';
import 'or_divider.dart';
import 'social_icon.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/rounded_button.dart';
import '../../../components/myrounded_input_field.dart';
import '../../../components/rounded_input_field.dart';
import '../../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  GoogleSignInAccount _currentUser;
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();

      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (error) {
      print(error);
    }
  }

  bool isLoggedIn = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();

  String _message = 'Log in/out by pressing the buttons below.';
  SharedPreferences logindata;
  _loginWithFB() async {
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        print('I am inside this');
        isLoggedIn = true;

        // logindata.setString('my_string_key', 'con');
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => HomeScreen()));

        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Inscription",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              
              Container(
                // padding: const EdgeInsets.all(28.0),
                padding: const EdgeInsets.fromLTRB(30, 35, 30, 5),
                // margin: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                        controller: TextEditingController(text: nom),
                        onChanged: (value) {
                          nom = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Entrez quelque chose'.tr();
                          }
                          return null;
                        },
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
                            hintText: " Nom ",
                            // border: InputBorder.none,
                            border: new OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.red)),
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
                // padding: const EdgeInsets.all(28.0),
                padding: const EdgeInsets.fromLTRB(30, 35, 30, 5),
                // margin: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                        controller: TextEditingController(text: prenom),
                        onChanged: (value) {
                          prenom = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Entrez quelque chose'.tr();
                          }
                          return null;
                        },
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
                            hintText: " Prénom",
                            // border: InputBorder.none,
                            border: new OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.red)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(30.0),
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
                // padding: const EdgeInsets.all(28.0),
                padding: const EdgeInsets.fromLTRB(30, 35, 30, 5),
                // margin: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                        controller: TextEditingController(text: email),
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Entrez quelque chose'.tr();
                          } else if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return null;
                          } else {
                            return 'Entrez valide email'.tr();
                          }
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                            fillColor: kPrimaryLightColor,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                              child: Icon(
                                Icons.mail,
                                color: kPrimaryColor,
                              ), // icon is 48px widget.
                            ),
                            hintText: "Votre Email",
                            // border: InputBorder.none,
                            border: new OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.red)),
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
                // padding: const EdgeInsets.all(28.0),
                padding: const EdgeInsets.fromLTRB(30, 35, 30, 5),
                // margin: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                        controller: TextEditingController(text: adresse),
                        onChanged: (value) {
                          adresse = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Entrez quelque chose'.tr();
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                            fillColor: kPrimaryLightColor,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                              child: Icon(
                                Icons.map,
                                color: kPrimaryColor,
                              ), // icon is 48px widget.
                            ),
                            hintText: "Votre Adresse",
                            // border: InputBorder.none,
                            border: new OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.red)),
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
                // padding: const EdgeInsets.all(28.0),
                padding: const EdgeInsets.fromLTRB(30, 35, 30, 5),
                // margin: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                        controller: TextEditingController(text: password),
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Entrez quelque chose'.tr();
                          }
                          return null;
                        },
                        obscureText: true,
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
                                borderSide:
                                    new BorderSide(color: Colors.white)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(color: Colors.red)),
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

            
              RoundedButton(
                  text: "S'inscrire",
                  press: () {
                    if (_formKey.currentState.validate()) {
                      save();
                    } else {
                      print('error');
                    }
                  }),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  }),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // SvgPicture.asset('assets/icons/facebook.svg',

                  //     allowDrawingOutsideViewBox: true,
                  //     height: 50,
                  //     width: 50,
                  //     fit: BoxFit.scaleDown),
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {
                      _loginWithFB();
                    },
                  ),
                  // SocalIcon(
                  //   iconSrc: "assets/icons/twitter.svg",
                  //   press: () {},
                  // ),
                  // SvgPicture.asset('assets/icons/google-plus.svg',
                  //     height: 40, width: 40, fit: BoxFit.scaleDown),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {
                      _handleSignIn();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  String nom, prenom, email, adresse, password;
  Future save() async {
    String url = 'http://10.0.2.2:8080/inscri';
    var res = await http.post(url, headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    }, body: <String, String>{
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'adresse': adresse,
      'password': password
    });

    if (res.body ==
        'Cette adresse e-mail est déjà associée à un autre compte.') {
      Fluttertoast.showToast(
          msg: "Cette adresse e-mail est déjà associée à un autre compte.".tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Bonjour,Un e-mail de vérification vous a été envoyé.".tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      MySharedPreferences.instance.setStringValue("nom", nom);
      MySharedPreferences.instance.setStringValue("prenom", prenom);
      MySharedPreferences.instance.setStringValue("email", email);

      MySharedPreferences.instance.setStringValue("adresse", adresse);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    }
  }
}
