import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestion_reclamations_citoyens/connexion.dart';
import 'package:gestion_reclamations_citoyens/firstapppage.dart';
import 'package:gestion_reclamations_citoyens/map.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'code.dart';
import 'constants.dart';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
   SharedPreferences? logindata;
  String? newuser;

  
 void check_if_already_login() async{
       logindata = await SharedPreferences.getInstance();
       newuser = logindata!.getString('my_string_key') ?? '';
       if(newuser == 'tech2021'){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ex("")));
       }

      }
    
  String? text;
    _read(context) async {
    final jsonstring= await DefaultAssetBundle.of(context).loadString('assets/data/code.json');
String code=codeFromJson(jsonstring).code;
 
  if(code==text){

    Fluttertoast.showToast(
        msg: "Code correct.".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
     newuser=code;
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ex("")));
  }
  else{

   Fluttertoast.showToast(
        msg: "Code incorrect.".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
   }
   final _formKey = GlobalKey<FormState>();
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context)
        .size;
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meditation App',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: Colors.grey[200],
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: Scaffold(
        body:SingleChildScrollView(
        child:Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFFF5CEB8),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/undraw_pilates_gpdb.png"),
              ),
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
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2BEA1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/menu.svg"),
                    ),
                  ),
                  SizedBox(
                   height: 20,
                  ),
                  Text(
                    "Tapez le code pour vérifiez que vous êtes un technicien :",
                    
                  ).tr(),
                  SizedBox(
                    height: 130,
                  ),
                 Form(
          key: _formKey,
          child:Column(
            children: [
              
                SizedBox(
                 height: 50,
                ),
                TextFormField(
                  
                  controller: TextEditingController(text:text),
                                  onChanged: (value){
                                     text=value;
                                            },
                                             validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entrez quelque chose'.tr();
                      }
                        return null;
                    },
                    obscureText: true,
  decoration: InputDecoration(
    border: UnderlineInputBorder(),

    labelText: 'Entrer le mot de passe'.tr(),
    
  ),
),
              
SizedBox(
                 height: 50,
                ),
                ElevatedButton(
                  child: Text('Suivant').tr(),
                  onPressed: (){
                      if (_formKey.currentState!.validate()) {
                            _read(context);
                          } else {
                            
                          }
                        },
                  
                )
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
