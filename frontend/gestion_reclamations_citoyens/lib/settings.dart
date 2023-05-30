import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gestion_reclamations_citoyens/techni.dart';
import 'package:gestion_reclamations_citoyens/user.dart';
import 'package:local_auth/local_auth.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'claim.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
class Album {
 
 
  String title;
  String mailto;
  Album({  this.title,this.mailto});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
    
      title: json['title'],
      mailto: json['mailto'],
    );
  }
}
Album al=Album();
class settings extends StatefulWidget {
  String mot,t;
  settings({this.mot,this.t});
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
SharedPreferences logindata;
  bool newuser;
  bool lockInBackground = true;
  bool lockInBackground2 = false;
  String mail,pass,name;
  String username,username2;
  String useremail,useremail2;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final LocalAuthentication localAuth = LocalAuthentication();
    void initState() {
    super.initState();
    
       
      if(widget.mot!=''){
        if(widget.t=='con'){
        recupere();
recuperemail();
        }else{
         recupere2();
        recuperemail2();
        }
      }else{
        username='';
        username2='';
        useremail='';
        useremail2='';
      }
         
         

       
       
        if(widget.t=='con'){
          mail=user.email;
          name=user.username;
          pass=user.password;
        }
        else{
          mail=tech.email;
          name=tech.username;
          pass=tech.password;
        }
     }   
     bool themeSwitch = false;

  dynamic themeColors() {
    if (themeSwitch) {
      return Colors.grey[850];
    } else {
      return Colors.white;
    }
  }
  Future _save() async {
   String url = 'https://nodetbge.seedbytes.com/changename'; 
    var res = await http.put(url,
    
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': mail,
          'username': name,
          
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
     if (res.body=='{"message":"nom et prénom changés"}'){
      Fluttertoast.showToast(
        msg: "nom et prénom changés".tr(),
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
   String url = 'https://nodetbge.seedbytes.com/changeemail'; 
    var res = await http.put(url,
    
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'username': name,
          'email': mail,
          
          
        });
        if (res.body=='utilisateur ne pas trouvé'){
      Fluttertoast.showToast(
        msg: "nom incorrect".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
     if (res.body=='{"message":"email changé"}'){
      Fluttertoast.showToast(
        msg: "email changé".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
   Navigator.pop(context);
    }
 
  }
  Future _save3() async {
   String url = 'https://nodetbge.seedbytes.com/change'; 
    var res = await http.put(url,
    
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': mail,
          'password': pass,
          
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
  Future _savetech() async {
   String url = 'https://nodetbge.seedbytes.com/changenametech'; 
    var res = await http.put(url,
    
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': mail,
          'username': name,
          
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
     if (res.body=='{"message":"nom et prénom changés"}'){
      Fluttertoast.showToast(
        msg: "nom et prénom changés".tr(),
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
   Future _save2tech() async {
   String url = 'https://nodetbge.seedbytes.com/changeemailtech'; 
    var res = await http.put(url,
    
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'username': name,
          'email': mail,
          
          
        });
        if (res.body=='utilisateur ne pas trouvé'){
      Fluttertoast.showToast(
        msg: "nom incorrect".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
     if (res.body=='{"message":"email changé"}'){
      Fluttertoast.showToast(
        msg: "email changé".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pop(context);
    }
 
  }
  Future _save3tech() async {
   String url = 'https://nodetbge.seedbytes.com/changetech'; 
    var res = await http.put(url,
    
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': mail,
          'password': pass,
          
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
  User user = User('','', '');
  Tech tech = Tech('','','');
  Future recuperemail() async {
       String url = 'https://nodetbge.seedbytes.com/getemail'; 
       al.mailto=widget.mot;
       var res = await http.post(url,
        
            headers: <String, String>{
              'Context-Type': 'application/json;charSet=UTF-8'
            },
            body: <String, String>{
              'mailto': al.mailto,
              
            });
        var result = await http.get(url,
        
            headers: 
              {'Context-Type': 'application/json'}
            );
         
          
           setState(() {
             useremail=res.body;
           }); 
   }
   Future recuperemail2() async {
       String url = 'https://nodetbge.seedbytes.com/getemailtech'; 
       al.mailto=widget.mot;
       var res = await http.post(url,
        
            headers: <String, String>{
              'Context-Type': 'application/json;charSet=UTF-8'
            },
            body: <String, String>{
              'mailto': al.mailto,
              
            });
        var result = await http.get(url,
        
            headers: 
              {'Context-Type': 'application/json'}
            );
         
          
           setState(() {
             useremail2=res.body;
           }); 
   }
   Future recupere() async {
      String url2 = 'https://nodetbge.seedbytes.com/get';
      al.title=widget.mot;
    
      var res = await http.post(url2,
        
            headers: <String, String>{
              'Context-Type': 'application/json;charSet=UTF-8'
            },
            body: <String, String>{
              'title': al.title,
              
            });
        var res2 = await http.get(url2,
        
            headers: 
              {'Context-Type': 'application/json'}
            );
     
          
           setState(() {
             username=res.body;
           }); 
   }
    Future recupere2() async {
       String url2 = 'https://nodetbge.seedbytes.com/gettech'; 
       al.title=widget.mot;
    
      var res = await http.post(url2,
        
            headers: <String, String>{
              'Context-Type': 'application/json;charSet=UTF-8'
            },
            body: <String, String>{
              'title': al.title,
              
            });
        var res2 = await http.get(url2,
        
            headers: 
              {'Context-Type': 'application/json'}
            );
        
          
           setState(() {
             username2=res.body;
           }); 
   }
   void showDialogBox(BuildContext context) {
Alert(
                 
        context: context,
        title: "Modification".tr(),
        content:Form(
          key: _formKey2,
        child: Column(
          children: <Widget>[
            TextFormField(
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
                icon: Icon(Icons.email),
                labelText: 'Email'.tr(),
                hintText: 'Email'.tr(),
              ),
            ),
            TextFormField(
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
                icon: Icon(Icons.account_box),
                labelText: 'Nom et prénom'.tr(),
                hintText: 'Nouveaux nom et prénom'.tr(),
              ),
            ),
         
          ] 
          ),),
           buttons:[
             DialogButton(
              color: Colors.cyan,
            onPressed: (){
              if(_formKey2.currentState.validate()){
        if(widget.t=='con'){
                    _save();
              }else{
                _savetech();
              }
              }else{
                
              }
              
            
            },
            child: Text('modifier').tr(),
            )
          ]
          ).show();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Paramètres').tr(),
      ),
     
      

body: 
  SettingsList(
   
        sections: [
          SettingsSection(
            title: 'Commun'.tr(),
            tiles: [
              SettingsTile(
                title: 'Langue'.tr(),
                
                leading: Icon(Icons.language),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => LanguagesScreen(txt:widget.t)));
                },
              ),
             
            ],
          ),
         /* SettingsSection(
            title: 'Compte'.tr(),
            tiles: [
              SettingsTile(title: 'Nom et prénom'.tr(), leading: Icon(Icons.account_circle),
              onTap: (){
                 Alert(
        context: context,
        title: "Nom et prénom".tr(),
        
        content: Column(
          children: <Widget>[
            widget.t == 'con' ?Text(username,style: TextStyle(color: Colors.blue),):Text(username2,style: TextStyle(color: Colors.blue),),
           
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.redAccent,
            onPressed: () => Navigator.of(context,rootNavigator: true).pop(),
            child: Text(
              "Arrêter".tr(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            color: Colors.green,
            child: Text(
              "modifier".tr(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: (){
             Navigator.of(context,rootNavigator: true).pop();
               showDialogBox(context); 
            },
            
          )
        ]).show();
              },
              ),
              SettingsTile(title: 'Email'.tr(), leading: Icon(Icons.email),
              onTap: (){
                 Alert(
        context: context,
        title: "Email".tr(),
        content: Column(
          children: <Widget>[
           
            widget.t == 'con' ?Text(useremail,style: TextStyle(color: Colors.blue),):Text(useremail2,style: TextStyle(color: Colors.blue),),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.redAccent,
            onPressed: () => Navigator.of(context,rootNavigator: true).pop(),
            child: Text(
              "Arrêter".tr(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
         
           
        ]).show();
              },
              ),
             
            ],
          ),*/
          SettingsSection(
            title: 'Sécurité'.tr(),
            tiles: [
              SettingsTile.switchTile(
                title: 'verrouiller application en arrière-plan'.tr(),
                leading: Icon(Icons.phonelink_lock),
                switchValue: lockInBackground,
                onToggle: (bool value) {
                  setState(() {
                    lockInBackground = value;
                  });
                },
              ),
              
     
              SettingsTile(title: 'changer mot de passe'.tr(), leading: Icon(Icons.lock),
              onTap: (){
              
                 Alert(
                 
        context: context,
        title: "Modification".tr(),
        content:
        Form(
          key: _formKey,
         child:Column(
          children: <Widget>[
            
            TextFormField(
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
                icon: Icon(Icons.email),
                labelText: 'Email'.tr(),
                hintText: 'Email'.tr(),
              ),
            ),
            TextFormField(
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
              if(_formKey.currentState.validate()){
                if(widget.t=='con'){
                  _save3();
                }else{
                  _save3tech();
                }
             
              }
              else{
               
              }
            },
            child: Text('modifier').tr(),
            )
          ]
                   ).show();
           
              },
              ),
            ],
          ),
        
        ],
      ),
      

    );
  }
}