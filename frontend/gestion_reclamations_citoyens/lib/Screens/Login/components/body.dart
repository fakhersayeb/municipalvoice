import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestion_reclamations_citoyens/Screens/Home/HomeScreen.dart';
import 'package:gestion_reclamations_citoyens/introduirecards.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'background.dart';
import '../../../Screens/Signup/signup_screen.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../components/rounded_password_field.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email, password;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future save() async {
    String url = 'http://10.0.2.2:8080/auth';
    var res = await http.post(url, headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    }, body: <String, String>{
      'email': email,
      'password': password
    });

    print(res.body);

    if (res.body == 'utilisateur ne pas trouvé') {
      Fluttertoast.showToast(
          msg: "Email  incorrect".tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (res.body ==
        'Votre email ne pas été vérifié. Veuillez cliquer sur renvoyer ') {
      Fluttertoast.showToast(
          msg: "Votre email n'a pas été vérifié.".tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (res.body == 'Incorrect mot de passe') {
      Fluttertoast.showToast(
          msg: "mot de passe incorrect".tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
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

              SizedBox(height: size.height * 0.03),
              // TextFormField(

              //   controller: TextEditingController(text: email),
              //   onChanged: (value) {
              //     email = value;
              //   },
              //   validator: (value) {
              //     if (value.isEmpty) {
              //       return 'Entrez quelque chose'.tr();
              //     } else if (RegExp(
              //             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              //         .hasMatch(value)) {
              //       return null;
              //     } else {
              //       return 'Entrez valide email'.tr();
              //     }
              //   },
              // ),

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
                                Icons.person,
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
                padding: const EdgeInsets.all(28.0),
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
                              borderSide: new BorderSide(color: Colors.white)),
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
                          filled: true),
                    )
                  ],
                ),
              ),
              // RoundedPasswordField(
              //   controller: TextEditingController(text: password),
              //           onChanged: (value){
              //            password=value;
              //           },
              //            validator: (value) {
              //               if (value.isEmpty) {
              //                 return 'Entrez quelque chose'.tr();
              //               }
              //                 return null;
              //             },
              // ),
              RoundedButton(
                text: "Connexion",
                 press: () {
                   if (_formKey.currentState.validate()) {
                     save();
                  }
                // press: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) {
                //         return HomeScreen();
                //       },
                //     ),
                //   );
                },
                //},
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
      ),
    );
  }
}
