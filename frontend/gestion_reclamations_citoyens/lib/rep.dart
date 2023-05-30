import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';
import 'FadeAnimation.dart';
import 'data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';


class Claim {
  String id;
  String name;
  String commentaire;
  String adresse;
  String image;
  String image2;
  String image3;
  Claim({ this.id,this.name,this.commentaire,this.adresse,this.image,this.image2,this.image3});
  
}

  Claim claim = Claim();
  



class Formrep extends StatefulWidget {
  @override
  _FormrepState createState() => _FormrepState();
}

class _FormrepState extends State<Formrep> {
 
File imagefile,imagefile2,imagefile3;
    _opengallery(BuildContext context) async{
      var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
      this.setState(() {
        imagefile = picture;
        final bytes=imagefile.readAsBytesSync();
        claim.image=base64Encode(bytes);
      });
      Navigator.of(context).pop();
      }
       _opengallery2(BuildContext context) async{
      var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
      this.setState(() {
        imagefile2 = picture;
        final bytes2=imagefile2.readAsBytesSync();
        claim.image2=base64Encode(bytes2);
      });
       }
       _opengallery3(BuildContext context) async{
      var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
      this.setState(() {
        imagefile3 = picture;
        final bytes3=imagefile3.readAsBytesSync();
        claim.image3=base64Encode(bytes3);
      });
      Navigator.of(context).pop();
      }
      _opencamera(BuildContext context) async{
        var picture = await ImagePicker.pickImage(source: ImageSource.camera);
      this.setState(() {
        imagefile = picture;
        final bytes=imagefile.readAsBytesSync();
        claim.image=base64Encode(bytes);
      });
      Navigator.of(context).pop();
      }
       _opencamera2(BuildContext context) async{
        var picture = await ImagePicker.pickImage(source: ImageSource.camera);
      this.setState(() {
        imagefile2 = picture;
        final bytes2=imagefile2.readAsBytesSync();
        claim.image2=base64Encode(bytes2);
      });
      Navigator.of(context).pop();
      }
       _opencamera3(BuildContext context) async{
        var picture = await ImagePicker.pickImage(source: ImageSource.camera);
      this.setState(() {
        imagefile3 = picture;
        final bytes3=imagefile3.readAsBytesSync();
        claim.image3=base64Encode(bytes3);
      });
      Navigator.of(context).pop();
      }
      Future<Void> _showchoicedialog(BuildContext context){
        return showDialog(context: context, builder: (BuildContext context){
         return AlertDialog(
           content: SingleChildScrollView(
             child: ListBody(
               children: [
                 Text('fais un choix!').tr(),
                 Padding(padding: EdgeInsets.all(8.00)),
                 Row(
                   children: [
                     Icon(Icons.photo_album),
                     SizedBox(
                       width: 2,
                     ),
                     GestureDetector(
                    child:Text('Galerie').tr(),
                    onTap: (){
                      _opengallery(context);
                    }
                  ),
                   ],
                 ),
                  
                  Padding(padding: EdgeInsets.all(8.00)),
                  Row(
                    children:[
                      Icon(Icons.camera_alt),
                       SizedBox(
                       width: 2,
                     ),
                      GestureDetector(
                    child:Text('Caméra').tr(),
                    onTap: (){
                      _opencamera(context);
                    }
                  ),
                    ],
                    
                  ),
               ],
             ),
           ),
         );
        }
        );
      }
      Future<Void> _showchoicedialog2(BuildContext context){
        return showDialog(context: context, builder: (BuildContext context){
         return AlertDialog(
           content: SingleChildScrollView(
             child: ListBody(
               children: [
                 Text('fais un choix!').tr(),
                 Padding(padding: EdgeInsets.all(8.00)),
                 Row(
                   children: [
                     Icon(Icons.photo_album),
                     SizedBox(
                       width: 2,
                     ),
                     GestureDetector(
                    child:Text('Galerie').tr(),
                    onTap: (){
                      _opengallery2(context);
                    }
                  ),
                   ],
                 ),
                  
                  Padding(padding: EdgeInsets.all(8.00)),
                  Row(
                    children:[
                      Icon(Icons.camera_alt),
                       SizedBox(
                       width: 2,
                     ),
                      GestureDetector(
                    child:Text('Caméra').tr(),
                    onTap: (){
                      _opencamera2(context);
                    }
                  ),
                    ],
                    
                  ),
               ],
             ),
           ),
         );
        }
        );
      }
       Future<Void> _showchoicedialog3(BuildContext context){
        return showDialog(context: context, builder: (BuildContext context){
         return AlertDialog(
           content: SingleChildScrollView(
             child: ListBody(
               children: [
                 Text('fais un choix!').tr(),
                 Padding(padding: EdgeInsets.all(8.00)),
                 Row(
                   children: [
                     Icon(Icons.photo_album),
                     SizedBox(
                       width: 2,
                     ),
                     GestureDetector(
                    child:Text('Galerie').tr(),
                    onTap: (){
                      _opengallery3(context);
                    }
                  ),
                   ],
                 ),
                  
                  Padding(padding: EdgeInsets.all(8.00)),
                  Row(
                    children:[
                      Icon(Icons.camera_alt),
                       SizedBox(
                       width: 2,
                     ),
                      GestureDetector(
                    child:Text('Caméra').tr(),
                    onTap: (){
                      _opencamera3(context);
                    }
                  ),
                    ],
                    
                  ),
               ],
             ),
           ),
         );
        }
        );
      }
      Future<Void> _deletedialog(BuildContext context){
        return showDialog(context: context, builder: (BuildContext context){
         return AlertDialog(
           content: SingleChildScrollView(
             child: ListBody(
               children: [
                 
                
                  Row(
                    children: [
                      Icon(Icons.delete_outline),
                      GestureDetector(
                    child:Text('Supprimer image').tr(),
                    onTap: (){
                      _clearimage(context);
                    }
                  ),
                    ],
                  ),
                  
               ],
             ),
           ),
         );
        }
        );
      }
      _clearimage(BuildContext context) {

   setState(() {

    imagefile = null;

      }); 
      Navigator.of(context).pop();
      }
     Future<Void> _deletedialog2(BuildContext context){
        return showDialog(context: context, builder: (BuildContext context){
         return AlertDialog(
           content: SingleChildScrollView(
             child: ListBody(
               children: [
                 
                
                  Row(
                    children: [
                      Icon(Icons.delete_outline),
                      GestureDetector(
                    child:Text('Supprimer image').tr(),
                    onTap: (){
                      _clearimage2(context);
                    }
                  ),
                    ],
                  ),
                  
               ],
             ),
           ),
         );
        }
        );
      }
      _clearimage2(BuildContext context) {

   setState(() {

    imagefile2 = null;

      }); 
      Navigator.of(context).pop();
      }
    Future<Void> _deletedialog3(BuildContext context){
        return showDialog(context: context, builder: (BuildContext context){
         return AlertDialog(
           content: SingleChildScrollView(
             child: ListBody(
               children: [
                 
                
                  Row(
                    children: [
                      Icon(Icons.delete_outline),
                      GestureDetector(
                    child:Text('Supprimer image').tr(),
                    onTap: (){
                      _clearimage3(context);
                    }
                  ),
                    ],
                  ),
                  
               ],
             ),
           ),
         );
        }
        );
      }
      _clearimage3(BuildContext context) {

   setState(() {

    imagefile3 = null;

      }); 
      Navigator.of(context).pop();
      }
 Future save() async {
       String url = 'https://nodetbge.seedbytes.com/rec'; 
        var res = await http.post(url,
        
            headers: <String, String>{
              'Context-Type': 'application/json;charSet=UTF-8'
            },
            body: <String, String>{
              
              'name': claim.name,
              'commentaire': claim.commentaire,
              'adresse': claim.adresse,
            });
       
        if (res.body=='erreur'){
          Fluttertoast.showToast(
            msg: "Erreur".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        }
     
 }
  var client = OdooClient("https://tbge-test.odoo.whitecapetech.com");
 
  Future<AuthenticateCallback> _connection(context) async {
    final jsonstring= await DefaultAssetBundle.of(context).loadString('assets/data/data.json');
String username=dataFromJson(jsonstring).username;
   String password=dataFromJson(jsonstring).password;
   String dbname=dataFromJson(jsonstring).dbname;

    AuthenticateCallback auth =
        await client.authenticate(username, password, dbname);
    if (auth.isSuccess) {
      final user = auth.getUser();
     
      
    } else {
      
    
      
    }
       
       }
  Future<OdooResponse> _addrec()  async{
    
    client.create("maintenance.request", {'name': claim.name, 'description': claim.commentaire,'equipment_id': claim.id}).then((OdooResponse result){
      if(result.hasError()){
    
      }
      else{
        
      }
    });
  }


  final _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connection(context);
  
  }
  Future save2() async {
   String url = 'http://10.0.2.2:8080/repair'; 
    var res = await http.post(url,
    
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          
         "adresse":claim.adresse,
         "commentaire":claim.commentaire,
         "image":claim.image,
         "image2":claim.image2,
         "image3":claim.image3,
        });
  
      if (res.body=='réparation envoyée'){
          Fluttertoast.showToast(
            msg: "Informations envoyées",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        }
    }
    
 Future<OdooResponse> _getrec3()  async{
      final domain = [
            ["name", "=", claim.adresse]
        ];
        var fields = ["id"];
        client
            .searchRead("maintenance.equipment", domain, fields)
            .then((OdooResponse result) {
          if (!result.hasError()) {
            
            final data = result.getResult();
         
            final records = ("${data["records"]}");
           String s = records.substring(6,11);
          int num = int.parse(s);
           
            
           // claim.id=num;
            return claim.id;
          } else {
      
          }
        });
     }
    bool themeSwitch = false;

  dynamic themeColors() {
    if (themeSwitch) {
      return Colors.grey[850];
    } else {
      return Colors.white;
    }
  }
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  String _textValue = "sample";
  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _cameraOcr,
        waitTap: true,
      );

      setState(() {
        _textValue = texts[0].value;
        //claim.adresse=_textValue;
      });
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
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
        title: Text('Ajout des informations sur la réparation').tr(),
      ),
      body: Form(
         
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
           
                child:SingleChildScrollView(
               
                child: Container(
                    color: themeColors(),
                 
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...[

                        FadeAnimation(0.9, Image.asset('assets/add.gif',height: 150,width: 150,
                        
                       
                        ),),
                Padding(padding: EdgeInsets.all(1)),
                 new RaisedButton(
              onPressed: _read,
              child: new Text('Ajouter image').tr(),
            ),
                    FadeAnimation(1.2, Row(
                  children: [
              SizedBox(
                width: 10,
              ),     
                    Text('Code*',style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.bold),).tr(),
                  ],
                ),),
                FadeAnimation(1.3, Row(
                  children: [
                     SizedBox(
                width: 10,
              ),
                   Text('Veuillez saisir le code de équipement défaillant',style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.normal),).tr(),
                  ],
                ),),
                 FadeAnimation(1.3, Row(
                  children: [
                     SizedBox(
                width: 10,
              ),
                   Text('(le code est inscrit sur équipement AxxxDxPxxx)',style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.normal),).tr(),
                  ],
                ),),
                FadeAnimation(1.1,  Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: themeSwitch ? Colors.grey[850] : Colors.white,))
                                ),
                child:FadeAnimation(1.1, TextFormField(
                  
                                      controller: TextEditingController(text: claim.adresse),
                                      onChanged: (value){
                                         claim.adresse=value;
                                                },
                                                 validator: (value) {
                          if (value.isEmpty) {
                            return 'Entrez quelque chose'.tr();
                          }
                            return null;
                          
                        },
                                      decoration: InputDecoration(
                               
                            
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
                                ),)
                 ),),
                  
               
                   
                           FadeAnimation(1.5, Row(
                  children: [
                   SizedBox(
                width: 10,
              ),
                    Text('Détails*',style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.bold),).tr(),
                  ],
                ),),
               FadeAnimation(1.6,  Row(
                  children: [
                     SizedBox(
                width: 10,
              ),
                   Text('Merci de nous donner plus de détails',style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.normal),).tr(),
                  ],
                ),),
                FadeAnimation(1.7,  Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: themeSwitch ? Colors.grey[850] : Colors.white,))
                                ),
                        child:FadeAnimation(1.7, TextFormField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            filled: false,
                           
                               
                            
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
                                borderSide: BorderSide(color: Colors.red))
                           
                          ),
                          controller: TextEditingController(text: claim.commentaire),
                          onChanged: (value) {
                            claim.commentaire = value;
                          },
                          validator: (value) {
                          if (value.isEmpty) {
                            return 'Entrez quelque chose'.tr();
                          }
                            return null;
                          
                        },
                          maxLines: 5,
                ),)),),
                
                         FadeAnimation(1.8, Row(
                  children: [
                     SizedBox(
                       width: 10,
                     ),
                   Text('Image(s)*',style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.bold),).tr(),
                  ],
                ),),
                        FadeAnimation(1.9, Row(
                  children: [
                     SizedBox(
                       width: 8,
                     ),
                   Text('Vous pouvez ajouter une ou plusieurs image(s)  \nde équipement défaillant',style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.normal),).tr(),
                  ],
                ),),
              
                     Column(
                   children: [
                   
                    Row(
                      children: [
                         FadeAnimation(2.0, CircleAvatar(
                              backgroundImage: imagefile == null
                                  ? NetworkImage(
                                      'https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg')
                                  : FileImage(imagefile),
                              radius: 50.0,
                            ),),
                            SizedBox(
                              width: 10,
                            ),
                           FadeAnimation(2.0, CircleAvatar(
                              backgroundImage: imagefile2 == null
                                  ? NetworkImage(
                                      'https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg')
                                  : FileImage(imagefile2),
                              radius: 50.0,
                            ),), 
                            SizedBox(
                              width: 10,
                            ),
                           FadeAnimation(2.0, CircleAvatar(
                              backgroundImage: imagefile3 == null
                                  ? NetworkImage(
                                      'https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg')
                                  : FileImage(imagefile3),
                              radius: 50.0,
                            ),), 
                      ],
                      
                    ),
                  
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                     FadeAnimation(2.0,InkWell(
                  onTap: (){
                    _showchoicedialog(context);
                  },
                  child:Icon(Icons.add_a_photo,color: themeSwitch ? Colors.white : Colors.grey[850],),
                ), ),
                 SizedBox(
                      width: 5,
                    ),
                     FadeAnimation(2.0,InkWell(
                  onTap: (){
                   _deletedialog(context);
                  },
                  child:Icon(Icons.delete,color: themeSwitch ? Colors.white : Colors.grey[850],),
                ), ),
                SizedBox(
                      width: 60,
                    ),
                     FadeAnimation(2.0,InkWell(
                  onTap: (){
                    _showchoicedialog2(context);
                  },
                  child:Icon(Icons.add_a_photo,color: themeSwitch ? Colors.white : Colors.grey[850],),
                ), ),
                 SizedBox(
                      width: 5,
                    ),
                     FadeAnimation(2.0,InkWell(
                  onTap: (){
                   _deletedialog2(context);
                  },
                  child:Icon(Icons.delete,color: themeSwitch ? Colors.white : Colors.grey[850],),
                ), ),
                SizedBox(
                      width:70,
                    ),
                     FadeAnimation(2.0,InkWell(
                  onTap: (){
                    _showchoicedialog3(context);
                  },
                  child:Icon(Icons.add_a_photo,color: themeSwitch ? Colors.white : Colors.grey[850],),
                ), ),
                 SizedBox(
                      width: 5,
                    ),
                     FadeAnimation(2.0,InkWell(
                  onTap: (){
                   _deletedialog3(context);
                  },
                  child:Icon(Icons.delete,color: themeSwitch ? Colors.white : Colors.grey[850],),
                ), ),
                  ],
                )
                   ],
                 ),
                  
                      
                       FadeAnimation(2.1, Container(
                  width: 300,
                  height: 50,
      
                  child:RaisedButton(
                   onPressed: (){
                     if(_formKey.currentState.validate()){
                     // _addrec();
                      save2();
                     }
                     else{
                       
                        
                     }
                   },
                   shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                   color: Colors.grey,
                   child: Text('Envoyer informations').tr(),
                 ),),
                 ), 
                        
                      ].expand(
                        (widget) => [
                          widget,
                          SizedBox(
                            height: 24,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
      )
    );
  }
}

