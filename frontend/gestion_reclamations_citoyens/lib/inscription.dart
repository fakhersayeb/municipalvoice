import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestion_reclamations_citoyens/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gestion_reclamations_citoyens/connexion.dart';
import 'package:gestion_reclamations_citoyens/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'map.dart';
import 'package:gestion_reclamations_citoyens/techni.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

SharedPreferences logindata;
 String newuser;
   void check_if_already_login() async{
       logindata = await SharedPreferences.getInstance();
       newuser = logindata.getString('my_string_key') ?? '';
       if(newuser == 'con'){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WebViewExample(value:'con')));
       }
       else if(newuser == 'techni'){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WebViewExample(value:'techni')));
       }
      }
      String name,mail,pass;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     check_if_already_login();
     if(check==false){
      name=user.username;
      mail=user.email;
      pass=user.password;
     }
     else{
       name=tech.username;
      mail=tech.email;
      pass=tech.password;
     }
  
   
  }

  final _formKey = GlobalKey<FormState>();
  Future save() async {
   String url = 'https://nodetbge.seedbytes.com/inscri'; 
    var res = await http.post(url,
    
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'username': name,
          'email': mail,
          'password': pass
        });
    
    if (res.body=='Cette adresse e-mail est déjà associée à un autre compte.'){
      Fluttertoast.showToast(
        msg: "Cette adresse e-mail est déjà associée à un autre compte.".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
    else{
      Fluttertoast.showToast(
        msg: "Bonjour,Un e-mail de vérification vous a été envoyé.".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ex()));
    }
  }
  Future save2() async {
   String url = 'https://nodetbge.seedbytes.com/inscritech'; 
    var res = await http.post(url,
    
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'username': name,
          'email': mail,
          'password':pass
        });
    
    if (res.body=='Cette adresse e-mail est déjà associée à un autre compte.'){
      Fluttertoast.showToast(
        msg: "Cette adresse e-mail est déjà associée à un autre compte.".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
    else{
      Fluttertoast.showToast(
        msg: "Bonjour,Un e-mail de vérification vous a été envoyé.".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ex()));
    }
  }
  User user = User('','', '');
  Tech tech = Tech('','', '');
  bool check=false;
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.white,
              Colors.white,
              Colors.white
            ]
          )
        ),
        child:Form(
          key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 45,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                
                    
                  Row(
                    children: [
                      SizedBox(
                    width: 80,
                  ),
                
                
                       FadeAnimation(1.1, Text("Inscription", style: TextStyle(color: Colors.deepPurple, fontSize: 40),).tr()),
                       
                    ],
                  ),
               SizedBox(
                 height: 10,
               ),
                  Row(
                    children: [
                    SizedBox(
                      width: 80,
                    ),
                     FadeAnimation(1.2,SvgPicture.asset('assets/commune.svg',width: 200,height: 130,)),
                                    SizedBox(height: 30,),
                    ],
                  ),
                 
                  
                  
                ],
              ),
            ),
            
            Expanded(
              
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        
                        FadeAnimation(1.3, Container(
                         
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.white))
                                ),
                               child:TextFormField(
                                   controller: TextEditingController(text: name),
                  onChanged: (value){
                   name=value;
                  },
                   validator: (value) {
                      if (value.isEmpty) {
                        return 'Entrez quelque chose'.tr();
                      }
                        return null;
                    },
                    
                                  decoration: InputDecoration(
                                   icon: Icon(Icons.account_box,color: Colors.cyan),
                                    hintText: 'nom et prénom'.tr(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red))),
                                  ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.white))
                                ),
                                
                                    child:TextFormField(
                                  controller: TextEditingController(text: mail),
                                  onChanged: (value){
                                     mail=value;
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
                                  decoration: InputDecoration(
                          icon: Icon(Icons.email,color: Colors.cyan),           
                      hintText: 'email'.tr(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red))),
                            ),
                                    
                                 
                                ),
                              
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.white))
                                ),
                                child: TextFormField(
                                   controller: TextEditingController(text: pass),
                  onChanged: (value){
                   pass=value;
                  },
                   validator: (value) {
                      if (value.isEmpty) {
                        return 'Entrez quelque chose'.tr();
                      }
                        return null;
                    },
                    obscureText: true,
                                  decoration: InputDecoration(
                                   icon: Icon(Icons.vpn_key,color: Colors.cyan),
                                    hintText: 'mot de passe'.tr(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red))),
                                  ),
                                ),
                              
                            ],
                          ),
                        )),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            FadeAnimation(1.4, Checkbox(value: check, onChanged:(bool val){
                          setState(() {
                            check=val;
                          
                          });
                        },
                        ),),
                        SizedBox(width: 5,),
                        FadeAnimation(1.5, Text('Je suis un agent municipal').tr(),)
                          ],
                        ),
                         
                        FadeAnimation(1.5, Container(
                          child: Center(
                            child:RaisedButton(
                        color: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            if(check==false){
                               save();
                            }else{
                              save2();
                            }
                            
                          } else {
                          
                          }
                        },
                        child: Text(
                          "S'inscrire",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ).tr()),
                          ),
                        )),
                       
                         Padding(padding: EdgeInsets.fromLTRB(35, 8, 0, 0),
                child: Row(
                  children:[
                    FadeAnimation(1.5, Text("Vous avez déjà un compte?", style: TextStyle(color: Colors.grey,fontSize:15),).tr()),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, new MaterialPageRoute(builder: (context)=>ex()));
                      },
                      child: FadeAnimation(1.5,Text('Connexion',style:TextStyle(color:Colors.blue,fontSize:15,fontWeight: FontWeight.bold)).tr(),
                    ),),
                    
                  ],
                ),
                ),
                        
                        
                     
                      ],
                    ),
                  ),
                ),
              ),
            
          ],
        ),
      ),
    ),
    );
  }
}
