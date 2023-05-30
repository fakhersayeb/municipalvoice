import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gestion_reclamations_citoyens/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:gestion_reclamations_citoyens/example.dart';
import 'package:gestion_reclamations_citoyens/techni.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:gestion_reclamations_citoyens/inscription.dart';
import 'package:gestion_reclamations_citoyens/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
class ex extends StatefulWidget {
  ex({Key key,this.v,this.val}) : super(key: key);
  String v,val;
  
  @override
  _exState createState() => _exState();
}

class _exState extends State<ex> {
  SharedPreferences logindata;
  String newuser;

  

  
  void check_if_already_login() async{
       logindata = await SharedPreferences.getInstance();
       newuser = logindata.getString('my_string_key') ?? '';
       
       
       if(newuser == 'con'){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WebViewExample(value:'con',gmail:mail,lonte:longitude,late:latitude)));
       }
       else if(newuser == 'techni'){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WebViewExample(value:'techni',gmail:mail)));
       }
      }
      
       String mail,pass,mail2,pass2;
       SharedPreferences saveimg;
  
                               
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
   _getCurrentLocation();
      check_if_already_login();
    
   if(check==false){
     
      mail=user.email;
      pass=user.password;
     }
     else{
      
      mail=tech.email;
      pass=tech.password;
     }
    if(check==false){
     
      mail2=user.email;
      pass2=user.password;
     }
     else{
      
      mail2=tech.email;
      pass2=tech.password;
     }
       _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account){
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
      }
      final _formKey = GlobalKey<FormState>();
      final _formKey2 = GlobalKey<FormState>();
      final _formKey3 = GlobalKey<FormState>();
      Future save() async {
       String url = 'https://nodetbge.seedbytes.com/auth'; 
        var res = await http.post(url,
        
            headers: <String, String>{
              'Context-Type': 'application/json;charSet=UTF-8'
            },
            body: <String, String>{
              'email': mail,
              'password': pass
            });
             
  
        
        if (res.body=='utilisateur ne pas trouvé'){
          Fluttertoast.showToast(
            msg: "Email  incorrect".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        }
        else if (res.body=='Votre email ne pas été vérifié. Veuillez cliquer sur renvoyer '){
          Fluttertoast.showToast(
            msg: "Votre email n'a pas été vérifié.".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        }
        else if (res.body=='Incorrect mot de passe'){
          Fluttertoast.showToast(
            msg: "mot de passe incorrect".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        }
        else{
logindata.setString('my_string_key', 'con');

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WebViewExample(value:'con',gmail:mail,lonte:longitude,late:latitude)));
        }
       
      }
       
  String longitude,latitude;
Position position;
   _getCurrentLocation() async{
    Geolocator geolocator;
 position = await Geolocator.getCurrentPosition( desiredAccuracy: LocationAccuracy.bestForNavigation,forceAndroidLocationManager:true);
    
      longitude=position.longitude.toString();
      latitude=position.latitude.toString();
     
  }
      Future savetech() async {
       String url = 'https://nodetbge.seedbytes.com/authtech'; 
        var res = await http.post(url,
        
            headers: <String, String>{
              'Context-Type': 'application/json;charSet=UTF-8'
            },
            body: <String, String>{
              'email': mail,
              'password': pass
            });
            
      
        
        if (res.body=='utilisateur ne pas trouvé'){
          Fluttertoast.showToast(
            msg: "Email  incorrect".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        }
        else if (res.body=='Votre email ne pas été vérifié. Veuillez cliquer sur renvoyer '){
          Fluttertoast.showToast(
            msg: "Votre email n'a pas été vérifié.".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        }
        else if (res.body=='Incorrect mot de passe'){
          Fluttertoast.showToast(
            msg: "mot de passe incorrect".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        }
        else{

          logindata.setString('my_string_key', 'techni');
         logindata.setString('email', mail);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WebViewExample(value:'techni',gmail:mail)));
        }
       
      }
      Future _save3() async {
   String url = 'https://nodetbge.seedbytes.com/change'; 
    var res = await http.put(url,
    
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': mail2,
          'password': pass2,
          
        });
        if (res.body=='utilisateur ne pas trouvé'){
      Fluttertoast.showToast(
        msg: "Email incorrect".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
     if (res.body=='{"message":"mot de passe changé"}'){
      Fluttertoast.showToast(
        msg: "mot de passe changé".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pop(
        context);
    }

  }
  Future _save3tech() async {
   String url = 'https://nodetbge.seedbytes.com/changetech'; 
    var res = await http.put(url,
    
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': mail2,
          'password': pass2,
          
        });
        if (res.body=='utilisateur ne pas trouvé'){
      Fluttertoast.showToast(
        msg: "Email incorrect".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
     if (res.body=='{"message":"mot de passe changé"}'){
      Fluttertoast.showToast(
        msg: "mot de passe changé".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pop(
        context);
    }

  }
       Future _save2() async {
   String url = 'https://nodetbge.seedbytes.com/sendmail'; 
    var res = await http.post(url,
    
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': mail,
          
        });
    
    if (res.body=='{"message":"Email incorrect"}'){
      Fluttertoast.showToast(
        msg: "Email incorrect".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
    else{
       Navigator.of(context,rootNavigator: true).pop();
           Alert(
                 
        context: context,
        title: "Modification".tr(),
        content:
        Form(
          key: _formKey3,
         child:Column(
          children: <Widget>[
            
            TextFormField(
               controller: TextEditingController(text: mail2),
                  onChanged: (value){
                   mail2=value;
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
                icon: Icon(Icons.email),
                labelText: 'Email'.tr(),
                hintText: 'Email'.tr(),
              ),
            ),
            TextFormField(
              controller: TextEditingController(text: pass2),
                  onChanged: (value){
                   pass2=value;
                  },
                  validator: (value) {
                      if (value.isEmpty) {
                        return 'Entrez quelque chose'.tr();
                      }
                        return null;
                    },
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Mot de passe'.tr(),
                hintText: 'Nouveau mot de passe'.tr(),
              ),
            ),
         
          ] 
          ),),
           buttons:[
             DialogButton(
              color: Colors.cyan,
            onPressed: (){
              if(_formKey3.currentState.validate()){
             _save3();
              }
              else{
            
              }
            },
            child: Text('modifier').tr(),
            )
          ]
                   ).show();
    }
   
  }
   Future _save2tech() async {
   String url = 'https://nodetbge.seedbytes.com/sendmailtech'; 
    var res = await http.post(url,
    
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': mail,
          
        });
   
    if (res.body=='{"message":"Email incorrect"}'){
      Fluttertoast.showToast(
        msg: "Email incorrect".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
    else{
       Navigator.of(context,rootNavigator: true).pop();
           Alert(
                 
        context: context,
        title: "Modification".tr(),
        content:
        Form(
          key: _formKey3,
         child:Column(
          children: <Widget>[
            
            TextFormField(
               controller: TextEditingController(text: mail2),
                  onChanged: (value){
                   mail2=value;
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
                icon: Icon(Icons.email),
                labelText: 'Email'.tr(),
                hintText: 'Email'.tr(),
              ),
            ),
            TextFormField(
              controller: TextEditingController(text: pass2),
                  onChanged: (value){
                   pass2=value;
                  },
                  validator: (value) {
                      if (value.isEmpty) {
                        return 'Entrez quelque chose'.tr();
                      }
                        return null;
                    },
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Mot de passe'.tr(),
                hintText: 'Nouveau mot de passe'.tr(),
              ),
            ),
         
          ] 
          ),),
           buttons:[
             DialogButton(
              color: Colors.cyan,
            onPressed: (){
              if(_formKey3.currentState.validate()){
             _save3tech();
              }
              else{
              
              }
            },
            child: Text('modifier').tr(),
            )
          ]
                   ).show();
    }
   
  }
      User user = User('','', '');
      Tech tech = Tech('','', '');
    bool check=false;
    GoogleSignInAccount _currentUser;
  Future<void> _handleSignIn() async{
    try{
      await _googleSignIn.signIn();
      if(check==false){
         logindata.setString('my_string_key', 'con');
     Navigator.push(
            context, new MaterialPageRoute(builder: (context) => WebViewExample(value:'con',gmail:'',lonte: longitude,late:latitude)));
      }else{
         logindata.setString('my_string_key', 'techni');
     Navigator.push(
            context, new MaterialPageRoute(builder: (context) => WebViewExample(value:'techni',gmail:'')));
      }
    }catch(error){
     
    }
  }

  bool isLoggedIn = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();

  String _message = 'Log in/out by pressing the buttons below.';

_loginWithFB() async{
    final FacebookLoginResult result =
        await facebookLogin.logIn(['email']);

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
       
         isLoggedIn = true;
         if(check==false){
            logindata.setString('my_string_key', 'con');
     Navigator.push(
            context, new MaterialPageRoute(builder: (context) => WebViewExample(value:'con',gmail:'',lonte:longitude,late:latitude)));
         }else{
            logindata.setString('my_string_key', 'techni');
     Navigator.push(
            context, new MaterialPageRoute(builder: (context) => WebViewExample(value:'techni',gmail:'')));
         }
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
                SizedBox(height: 40,),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          
                           FadeAnimation(1.2, Text("Connexion", style: TextStyle(color: Colors.deepPurple, fontSize: 40),).tr()),
    
                        ],
                      ),
                     
                     
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                        
                        ],
                      ),
                      
                    ],
                  ),
                ),
                
                Expanded(
                  
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: <Widget>[
                            
                            FadeAnimation(1.4, Container(
                              
                              child: Column(
                                children: <Widget>[
                                  FadeAnimation(1.4,SvgPicture.asset('assets/commune.svg',width: 150,height: 150,)),
                                    SizedBox(height: 30,),
                                        FadeAnimation(1.5, TextFormField(
                                      controller: TextEditingController(text:mail),
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
                                ),),
                                        
                                     
                                  SizedBox(
                                    height: 10,
                                  ),  
                                  
                                   FadeAnimation(1.5, TextFormField(
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
                                    )
                                  
                                ],
                              ),
                            )),
                            SizedBox(height: 10,),
                           
                              Row(
                                 children: [
                                   SizedBox(
                                  width: 200,
                                   ),
                                    InkWell(
                                 child:FadeAnimation(1.6, Text("Mot de passe oublié?", style: TextStyle(color: Colors.lightBlue, fontSize: 15),).tr()),
                                    onTap: (){
                                   
             
              Alert(
        context: context,
        title: "Tapez votre email".tr(),
        content: Form(
          key: _formKey2,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.email_outlined),
                //labelText: 'Username',
                hintText: 'entrer email'.tr(),
                labelText: 'Email'.tr()
              ),
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
            ),
           
                        
          ],
        ),
         ),
        buttons: [
          DialogButton(
            color: Colors.blueAccent,
            onPressed: () {
            if(_formKey2.currentState.validate()){
              if(check==false){
                _save2();
              }else {
                _save2tech();
              }
              
            }
            else{
             
            }
            },
            child: Text(
              "Suivant".tr(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
             
              ).show();                                    },
                                    ),
                                 ],
                             
                               
                                 
                            ),
                      
             
                           FadeAnimation(1.7,  Row(
                          children: [
                             Checkbox(value: check, onChanged:(bool val){
                          setState(() {
                            check=val;
                    
                         
                          });
                        },
                        ),
                        SizedBox(width: 5,),
                        Text('Je suis un agent municipal').tr(),
                          ],
                        ),),
                         
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                               InkWell(
                                 child:FadeAnimation(1.8, Text("Vérifier que vous êtes un agent municipal", style: TextStyle(color: Colors.lightBlue, fontSize: 15),).tr()),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                                    }
                           ),
                            ],
                          ),
                            
                            FadeAnimation(1.9, Container(
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
                                  
                                 if(widget.val=="tech2021"){
                                  
                                    savetech();
                                     
      
                                 }else{
                                  Fluttertoast.showToast(
            msg: "vous devez vérifier que vous êtes un agent municipal".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
                                 }
                                }
                                
                              } else {
                               
                              }
                            },
                            child: Text(
                              "Se connecter".tr(),
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )),
                              ),
                            )),
                            
                             Padding(padding: EdgeInsets.fromLTRB(35, 8, 0, 0),
                    child: Row(
                      children:[
                        FadeAnimation(2, Text("Vous n'avez pas de compte?", style: TextStyle(color: Colors.grey,fontSize: 15),).tr()),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, new MaterialPageRoute(builder: (context)=>HomePage()));
                          },
                          child: FadeAnimation(1.5,Text("S'inscrire",style:TextStyle(color:Colors.blue,fontSize:15,fontWeight: FontWeight.bold)).tr(),
                        ),),
                        
                      ],
                    ),
                    ),
                          SizedBox(
                            height: 10,
                          ),  
                               FadeAnimation(1.6, Text("Continuer avec :", style: TextStyle(color: Colors.grey,fontSize: 20),
                        ).tr(),
                        ),
                        
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FadeAnimation(1.7, RaisedButton(
                                  color: Colors.blue,
                                  onPressed: (){
                                        _loginWithFB();
                                  },
                                  child: Row(
                                 children: [
                                   SizedBox(
                                     width: 10,
                                   ),
                                   Icon(
                                      FontAwesomeIcons.facebook,
                                      color: Colors.white,
                                       size: 20.0,
                                   ),
                                   SizedBox(
                                     width: 5,
                                   ),
                                   Center(
                                  child: Text("Facebook", style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),).tr(),
                                ),
                                 ],
                                ), 
                                ),
                                
                              )),
                            
                            SizedBox(width: 10),
                            Expanded(
                              child: FadeAnimation(1.7, RaisedButton(
                                color: Colors.green,
                                onPressed: (){
                                  _handleSignIn();
                                },
                                
                                child: Row(
                                  children: [
                                    SizedBox(
                                     width: 10,
                                   ),
                                   Icon(
                                      FontAwesomeIcons.google,
                                      color: Colors.white,
                                       size: 20.0,
                                   ),
                                   SizedBox(
                                     width: 10,
                                   ),
                                     Center(
                                  child: Text("Google", style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),).tr(),
                                ),
                                  ],
                                ),
                                ),
                                
                                
                              )),
                            
                          ],
                        )
                                
                             
                           
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
