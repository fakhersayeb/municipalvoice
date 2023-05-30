import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_arcgis/esri_plugin.dart';
import 'package:flutter_map_arcgis/layers/feature_layer_options.dart';
import 'package:gestion_reclamations_citoyens/cards.dart';
import 'package:gestion_reclamations_citoyens/color_filters.dart';




import 'package:gestion_reclamations_citoyens/page2.dart';
import 'package:gestion_reclamations_citoyens/r%C3%A9clamation.dart';
import 'package:gestion_reclamations_citoyens/rep.dart';
import 'package:gestion_reclamations_citoyens/settings.dart';
import 'package:gestion_reclamations_citoyens/techconnexion.dart';

import 'package:image_picker/image_picker.dart';
import 'package:latlng/latlng.dart';
import 'package:flutter_map_arcgis/flutter_map_arcgis.dart';

import 'package:mailto/mailto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'connexion.dart';
import 'package:easy_localization/easy_localization.dart';

class Album {
 
 
  String title;

  Album({  this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
    
      title: json['title'],
    );
  }
}
Album al=Album();

class WebViewExample extends StatefulWidget {
   String value,gmail,lonte,late;
   WebViewExample({this.value,this.gmail,this.lonte,this.late});
  
   
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample>  {
 
   SharedPreferences logindata,stock;
  Album al= Album();
  File _image;
 String _imagepath;
  String img =
      'https://rentnjoy.com/wp-content/uploads/2016/03/analyst-placeholder-avatar.png';
  String newuser;
  String v;
   File imagefile;
   String username,username2;
 String wordname;
    Future recupere() async {
     
      al.title= widget.gmail;
   
          String url = 'https://nodetbge.seedbytes.com/get'; 
        
         var res = await http.post(url,
        
            headers: <String, String>{
              'Context-Type': 'application/json;charSet=UTF-8'
            },
            body: <String, String>{
              'title': al.title,
              
            });
           var res2 = await http.get(url,
           
               headers: 
                 {'Context-Type': 'application/json'}
               );
        
             
              setState(() {
                username=res.body;
              }); 
      }
       Future recupere2() async {
          String url = 'https://nodetbge.seedbytes.com/gettech';
          al.title=widget.gmail; 
          var res = await http.post(url,
        
            headers: <String, String>{
              'Context-Type': 'application/json;charSet=UTF-8'
            },
            body: <String, String>{
              'title': al.title,
              
            });
           var res2 = await http.get(url,
           
               headers: 
                 {'Context-Type': 'application/json'}
               );
          
             
              setState(() {
                username2=res.body;
              }); 
      }
  void check_if_already_login2() async{
       logindata = await SharedPreferences.getInstance();
       await logindata.remove('my_string_key');
      await logindata.remove('email');
      
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ex(v:"")));
      
      }
    

   _launchMailto() async {
  final mailtoLink = Mailto(
    to: ['fakhersayeb00@gmail.com'],
    cc: ['', ''],
    subject: '',
    body: '',
  );
  // Convert the Mailto instance into a string.
  // Use either Dart's string interpolation
  // or the toString() method.
  await launch('$mailtoLink');
}

 Future getdata()async{
   var wordtake=logindata.getString('email');
   setState(() {
     wordname=wordtake;
   });
  
 }

  @override
  void initState() {
    super.initState();
   
   loadimage();
 
  if(widget.gmail!=''){
    if(widget.value=='con'){
    
      recupere();
    }else{
     
      recupere2();
    }
     
    
  }else{
    username='';
    username2='';
  }
 
   if(widget.value=='techni'){
     test=true;
     
   }
   else{
     test=false;
    
   }
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
 
  bool test=false;
  
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Scaffold(
        appBar: AppBar(title: Text('Réclamations citoyens').tr(),
        actions: [
         
        ],
        ),
        
      body: 
           WebView(
      initialUrl: 'https://tbge.seedbytes.com/test9.html?basemap=hybrid&lg=${widget.lonte}&la=${widget.late}',
    javascriptMode: JavascriptMode.unrestricted,
    
    ),
   
   
     
     drawer: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children:  <Widget>[
        DrawerHeader(
          
          decoration: BoxDecoration(
            
            color: Colors.blue,
          ),
          child: Container(
                      
                       alignment: Alignment.center,
                       child: Column(
                         children: <Widget>[
                          Row(
                            children: [
                               Stack(
                             children: <Widget>[
                              Row(
                                children: [
                                   _imagepath != null ? CircleAvatar(backgroundImage: FileImage(File(_imagepath)),radius:50.0,):CircleAvatar(
                                 backgroundImage: _image == null
                                     ? NetworkImage(
                                         'https://static.vecteezy.com/ti/vecteur-libre/p1/2775274-icone-ligne-vecteur-de-reclamation-d-assurance-vectoriel.jpg')
                                     : FileImage(_image),
                                 radius: 40.0,
                               ),
                               
                               SizedBox(
                                 width: 5,
                               ),
                               Text('Gestion des réclamations'.tr(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)
                                ],
                              ),
                               
                             ],
                           ),
                            ],
                          ),
   
                  
                         ],
                       ),
                     ),
                                
                            
        ),
       
        ListTile(
          leading: Icon(Icons.add),
          title: Text('Ajouter une réclamation').tr(),
           onTap: () {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>CookiePage(lg:widget.lonte,la:widget.late)));
  },
        ),
          ListTile(
          leading: Icon(Icons.read_more),
          title: Text('Suivre les réclamations').tr(),
           onTap: () {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp3()));
  },
        ),
        Visibility(
          visible: test,
          child: ListTile(
          leading: Icon(Icons.update),
          title: Text('Modifier les réclamations').tr(),
           onTap: () {
            
     Navigator.push(context, MaterialPageRoute(builder: (context)=>techconnexion()));
   
  },
        ),
        ),
         Visibility(
          visible: test,
          child: ListTile(
          leading: Icon(Icons.add_chart),
          title: Text('Ajout des informations sur la réparation').tr(),
           onTap: () {
            
     Navigator.push(context, MaterialPageRoute(builder: (context)=>Formrep()));
   
  },
        ),
        ),
         ListTile(
          leading: Icon(Icons.settings),
          title: Text('Paramètres').tr(),
           onTap: () {
     Navigator.push(context, MaterialPageRoute(builder: (context)=>settings(mot:newuser,t:widget.value)));
    
  },
        ),
         ListTile(
          leading: Icon(Icons.contact_page),
          title: Text('Contact').tr(),
           onTap: () {
     _launchMailto();
    
  },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Se déconnecter').tr(),
           onTap: () {
           check_if_already_login2();
             
               
            
               
  },
        ),
      ],
    ),
  ),
      ),
     );
  }
   void _onAlertPress() async {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return new CupertinoAlertDialog(
                                                actions: [
                                                  CupertinoDialogAction(
                                                    isDefaultAction: true,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Icon(Icons.photo_album),
                                                        Text('Gallerie').tr(),
                                                      ],
                                                    ),
                                                    onPressed: (){
                                                      getGalleryImage(context);
                                                    },
                                                  ),
                                                  CupertinoDialogAction(
                                                    isDefaultAction: true,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Icon(Icons.camera_alt),
                                                        Text('Prendre une photo').tr(),
                                                      ],
                                                    ),
                                                    onPressed: (){
                                                      getCameraImage(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      }
                                  
                                      
                                    
                                   
                                      Future getCameraImage(BuildContext context) async {
                                        var image = await ImagePicker.pickImage(source: ImageSource.camera);
                                    
                                        setState(() {
                                          _image = image;
                                          
                                          
                                        });
                                        Navigator.pop(context);
                                      }
                                    
                                      
                                      Future getGalleryImage(BuildContext context) async {
                                        var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                                    
                                        setState(() {
                                          _image = image;
                                         
                                          
                                        });
                                         Navigator.pop(context);
                                      }
                                    SharedPreferences saveimg;
                                    SharedPreferences saveimg2;
                                      void saveimage(path) async{
                                         saveimg = await SharedPreferences.getInstance(); 
                                        saveimg2 = await SharedPreferences.getInstance();
                                         if(widget.value=='con'){
                                         saveimg.setString('imagepath', path);
                                      
                                         }else{
                                           saveimg2.setString('image', path);
                                       
                                         }
                                              
                                          
                                      }
                                          void deleteimage() async{
                                         saveimg = await SharedPreferences.getInstance();
                                         saveimg2 = await SharedPreferences.getInstance();
                                       if(widget.value=="con"){
                                      saveimg.remove('imagepath');
                                       }else{
                                         saveimg2.remove('image');
                                       }
                                        
                                        setState(() {
                                  _imagepath=null;
                                 _image = null;

                                       }); 
                                        
                                      }
                                      void loadimage() async{
                                         saveimg = await SharedPreferences.getInstance();
                                         saveimg2 = await SharedPreferences.getInstance();
                                        setState(() {
                                         if(widget.value=='con'){
                                          _imagepath=saveimg.getString('imagepath');
                                         }else{
                                           _imagepath=saveimg2.getString('image');
                                         }
                                           
                                          
                                         
                                        });
     }

   }
   


