import 'dart:convert';
import 'dart:io';
import '../../FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestion_reclamations_citoyens/components/rounded_button.dart';
import 'package:gestion_reclamations_citoyens/components/rounded_input_field_Claim.dart';
import 'package:gestion_reclamations_citoyens/connexion.dart';
import 'package:gestion_reclamations_citoyens/firstapppage.dart';
import 'package:gestion_reclamations_citoyens/map.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../code.dart';
import '../../constants.dart';

class Proposition extends StatefulWidget {
  @override
  _PropositionState createState() => _PropositionState();
}

class _PropositionState extends State<Proposition> {
  SharedPreferences logindata;
  String newuser;

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = logindata.getString('my_string_key') ?? '';
    if (newuser == 'tech2021') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ex(val: newuser)));
    }
  }

  String text, text2, date;
  _read(context) async {
    final jsonstring = await DefaultAssetBundle.of(context)
        .loadString('assets/data/code.json');
    String code = codeFromJson(jsonstring).code;

    if (code == text) {
      print('ok');
      Fluttertoast.showToast(
          msg: "Code correct.".tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      newuser = code;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ex(val: newuser)));
    } else {
      print('not ok');
      Fluttertoast.showToast(
          msg: "Code incorrect.".tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future save() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    date = formattedDate;
    String url = 'http://10.0.2.2:8080/prop';
    var msg = jsonEncode({'name': text, 'description': text2, 'date': date});
    try {
      var res = await http.post(url,
          headers: {'Content-type': 'application/json'}, body: msg);

      print(res.body);
      if (res.body == 'erreur') {
        Fluttertoast.showToast(
            msg: "Erreur".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      if (res.body == 'proposition envoyée') {
        Fluttertoast.showToast(
            msg: "Proposition envoyée".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      return e.message;
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool themeSwitch = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meditation App',
        theme: ThemeData(
          fontFamily: "Cairo",
          scaffoldBackgroundColor: Colors.white,
          textTheme:
              Theme.of(context).textTheme.apply(displayColor: kTextColor),
        ),
        home: Scaffold(
          appBar: AppBar(
            // backgroundColor: Color(0xFF0974c9),
            actions: [Text("")],
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            bottomOpacity: 0.0,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            toolbarHeight: 80,

            centerTitle: true,

            // title: Text('Ajout de réclamation',
            //    style: TextStyle(color: Colors.black)),

            //title: Text('Test'.tr()),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  // Here the height of the container is 45% of our total height
                  // height: size.height * .45,
                  decoration: BoxDecoration(
                    color: Color(0xFF0974c9),
                    // color: Colors.amberAccent,
                    // image: DecorationImage(
                    //   // fit: BoxFit.fitHeight,
                    //   alignment: Alignment.bottomCenter,
                    //  // image: AssetImage("assets/information.png"),
                    // ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            alignment: Alignment.center,
                            height: 5,
                            width: 52,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset("assets/menu.svg"),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Vous pouvez nous envoyer une proposition  :",
                          style: Theme.of(context).textTheme.display1.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 30.0,
                              color: Colors.blueGrey[900]),
                          textAlign: TextAlign.center,
                          // style: Theme.of(context)
                          //     .textTheme
                          //     .display1
                          //     .copyWith(fontWeight: FontWeight.w900),
                        ).tr(),
                        SizedBox(
                          height: 5,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),

                              // TextFormField(
                              //   controller: TextEditingController(text: text),
                              //   onChanged: (value) {
                              //     text = value;
                              //   },
                              //   validator: (value) {
                              //     if (value.isEmpty) {
                              //       return 'Entrez quelque chose'.tr();
                              //     }
                              //     return null;
                              //   },
                              //   obscureText: false,
                              //   style: TextStyle(
                              //       fontSize: 19.0, color: Color(0xFF0000cf)),
                              //   decoration: InputDecoration(
                              //     focusedBorder: OutlineInputBorder(
                              //       borderSide:
                              //           BorderSide(color: Color(0xFF0000cf)),
                              //       borderRadius: BorderRadius.circular(25.7),
                              //     ),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderSide:
                              //           BorderSide(color: Color(0xFF0974c9)),
                              //       borderRadius: BorderRadius.circular(25.7),
                              //     ),
                              //     // decoration: InputDecoration(
                              //     //   border: UnderlineInputBorder(),
                              //     labelText: "Entrer l'objet".tr(),
                              //   ),
                              // ),
                              SizedBox(
                                height: 5,
                              ),

                              // TextFormField(
                              //   minLines: 1,
                              //   maxLines: 5,
                              //   // allow user to enter 5 line in textfield
                              //   keyboardType: TextInputType.multiline,
                              //   controller: TextEditingController(text: text2),
                              //   onChanged: (value) {
                              //     text2 = value;
                              //   },
                              //   validator: (value) {
                              //     if (value.isEmpty) {
                              //       return 'Entrez quelque chose'.tr();
                              //     }
                              //     return null;
                              //   }, // user keyboard will have a button to move cursor to next line
                              //   // decoration: InputDecoration(
                              //   //   border: UnderlineInputBorder(),
                              //   style: TextStyle(
                              //       fontSize: 19.0, color: Color(0xFF0000cf)),
                              //   obscureText: false,
                              //   decoration: InputDecoration(
                              //     focusedBorder: OutlineInputBorder(
                              //       borderSide:
                              //           BorderSide(color: Color(0xFF0000cf)),
                              //       borderRadius: BorderRadius.circular(25.7),
                              //     ),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderSide:
                              //           BorderSide(color: Color(0xFF0974c9)),
                              //       borderRadius: BorderRadius.circular(25.7),
                              //     ),
                              //     labelText: "Entrer la description".tr(),
                              //   ),
                              // ),

                              SizedBox(
                                height: 5,
                              ),
                              FadeAnimation(
                                1.2,
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Objet*',
                                      style: TextStyle(
                                          color: themeSwitch
                                              ? Colors.white
                                              : Colors.grey[850],
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ).tr(),
                                  ],
                                ),
                              ),

                              //         RoundedInputFieldClaim(
                              //           controller: TextEditingController(text: text),
                              // onChanged: (value){
                              //  text=value;
                              // },
                              //  validator: (value) {
                              //     if (value.isEmpty) {
                              //       return 'Entrez quelque chose'.tr();
                              //     }
                              //       return null;
                              //   },
                              //         ),

                              Container(
                                // padding: const EdgeInsets.all(28.0),
                                padding:
                                    const EdgeInsets.fromLTRB(30, 35, 30, 5),
                                // margin: EdgeInsets.symmetric(vertical: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextFormField(
                                        controller:
                                            TextEditingController(text: text),
                                        onChanged: (value) {
                                          text = value;
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      30, 5, 30, 5),
                                              // child: Icon(
                                              //   Icons.lock,
                                              //   color: kPrimaryColor,
                                              // ), // icon is 48px widget.
                                            ),
                                            hintText: "Objet",
                                            // border: InputBorder.none,
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.white)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                    color: Colors.red)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    borderSide: BorderSide(
                                                        color: Colors.red)),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
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

                              SizedBox(
                                height: 5,
                              ),
                              FadeAnimation(
                                1.2,
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Description*',
                                      style: TextStyle(
                                          color: themeSwitch
                                              ? Colors.white
                                              : Colors.grey[850],
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ).tr(),
                                  ],
                                ),
                              ),

                              // decoration: BoxDecoration(
                              //     border: Border(
                              //         bottom: BorderSide(
                              //   color: themeSwitch
                              //       ? Colors.grey[850]
                              //       : Colors.white,
                              // ))),

                              Container(
                                // padding: const EdgeInsets.all(28.0),
                                padding:
                                    const EdgeInsets.fromLTRB(30, 35, 30, 5),
                                // margin: EdgeInsets.symmetric(vertical: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextFormField(
                                        controller:
                                            TextEditingController(text: text2),
                                        onChanged: (value) {
                                          text2 = value;
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      30, 5, 30, 5),
                                              // child: Icon(
                                              //   Icons.lock,
                                              //   color: kPrimaryColor,
                                              // ), // icon is 48px widget.
                                            ),
                                            hintText: "Description",
                                            // border: InputBorder.none,
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.white)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                    color: Colors.red)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    borderSide: BorderSide(
                                                        color: Colors.red)),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
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
                              // RoundedInputFieldClaim(
                              //   controller: TextEditingController(text: text2),
                              //   onChanged: (value) {
                              //     text2 = value;
                              //   },
                              //   validator: (value) {
                              //     if (value.isEmpty) {
                              //       return 'Entrez quelque chose'.tr();
                              //     }
                              //     return null;
                              //   },
                              // ),
                              SizedBox(
                                height: 5,
                              ),
                              RoundedButton(
                                text: "Envoyer",
                                press: () {
                                  if (_formKey.currentState.validate()) {
                                    save();
                                  }
                                },
                              ),

                              // ElevatedButton(
                              //   child: Text('Envoyer').tr(),
                              //   style: ElevatedButton.styleFrom(
                              //       padding: const EdgeInsets.symmetric(
                              //           horizontal: 30, vertical: 15),
                              //       textStyle: const TextStyle(fontSize: 25),
                              //       primary: Color(0xFF0974c9),
                              //       // fontSize: 24,
                              //       //: const Size(300, 100),
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(50))),
                              //   onPressed: () {
                              //     if (_formKey.currentState.validate()) {
                              //       _read(context);
                              //     } else {
                              //       print("error");
                              //     }
                              //   },
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
