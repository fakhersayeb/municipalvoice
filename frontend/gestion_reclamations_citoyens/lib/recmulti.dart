import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';

import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';
import 'FadeAnimation.dart';
import 'data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
class Claim {
  String id;
  String name;
  String commentaire;
  String adresse;
  String files;
  String date;
  String type;
  Claim({ this.id,this.name,this.commentaire,this.adresse,this.files,this.date,this.type});
  
}

  Claim claim = Claim();
  


class recmulti extends StatefulWidget {
  @override
  String long,lati;
  int type;
  recmulti({this.type,this.long,this.lati});
  _recmultiState createState() => _recmultiState();
}

class _recmultiState extends State<recmulti> {
 String dropdownValue='';
List imglist=[];

List<Asset> images = List<Asset>();
  String _error;
  List files = [];
 Widget buildGridView() {
    if (images != null)
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    else
      return Container(color: Colors.white);
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        
        selectedAssets: images,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      
      
    });
  }
  getImageFileFromAsset(String path) async{
      final file=File(path);
      
      return file;
    }
   
 Future save() async {
       String url = 'http://10.0.2.2:8080/rec2'; 
       var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    claim.date=formattedDate;
    
    
    var base64Image;
    String Name;
    var name1,name2,name3;
    String name4,name5,name6;
    for(var i=0;i<images.length;i++){
        
       var path2 = await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      
        var file = await getImageFileFromAsset(path2);
      
         Name = file.path.split('/').last;
        base64Image=base64Encode(file.readAsBytesSync());
       
         
          imglist.add(jsonEncode(Name));
          files.add(base64Image);
          
         
          }
          
          if(files.length==1){
           name1=files[0];
           name4=imglist[0];
           jsonEncode(name1);
           jsonEncode(name4);
         
         
         }
         if(files.length==2){
           name1=files[0];
          name2=files[1];
          name4=imglist[0];
          name5=imglist[1];
          jsonEncode(name1);
           jsonEncode(name4);
           jsonEncode(name2);
           jsonEncode(name5);
         
         }
         if(files.length==3){
           name1=files[0];
          name2=files[1];
          name3=files[2];
          name4=imglist[0];
          name5=imglist[1];
          name6=imglist[2];
          jsonEncode(name1);
           jsonEncode(name4);
           jsonEncode(name2);
           jsonEncode(name5);
           jsonEncode(name3);
           jsonEncode(name6);
        
         }
        

    
    var msg = jsonEncode({'name': claim.name,'longi': widget.long,'latit': widget.lati,
              'id':claim.id,'type':widget.type,'name1':name1,'name2':name2,'name3':name3,'name4':name4,'name5':name5,'name6':name6,'date':claim.date});
       try{
          var res = await http.post(url,headers: {'Content-type': 'application/json'}, body:msg);
        

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
        if (res.body=='réclamation envoyée'){
          Fluttertoast.showToast(
            msg: "Réclamation envoyée".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        files.clear();
        
        }
       }catch (e) {
           return e.message;
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
   String url = 'https://nodetbge.seedbytes.com/claim'; 
    var res = await http.post(url,
    
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          
         "adresse":claim.adresse,
         "name":claim.name,
         "commentaire":claim.commentaire,
         "id":claim.id,
        
        });
   
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
           // return claim.id;
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
  String _textValue = "";
  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _cameraOcr,
        waitTap: true,
      );

      setState(() {
        _textValue = texts[0].value;
       // claim.adresse=_textValue;
      });
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }
  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
           actions: [
             Text("")
            
           ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Ajout de réclamation').tr(),
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
               
                    FadeAnimation(1.2, Row(
                  children: [
              SizedBox(
                width: 10,
              ),     
                    Text('Emplacement*'.tr(),style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.bold),).tr(),
                  ],
                ),),
                FadeAnimation(1.3, Row(
                  children: [
                     SizedBox(
                width: 10,
              ),
                   Text('Veuillez saisir votre localisation'.tr(),style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.normal),).tr(),
                  ],
                 ),),
                 FadeAnimation(1.3, Row(
                  children: [
                     SizedBox(
                width: 10,
              ),
                   Text('(la latitude et la longitude)'.tr(),style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.normal),).tr(),
                  ],
                ),),
                FadeAnimation(1.1,  Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: themeSwitch ? Colors.grey[850] : Colors.white,))
                                ),
                child:FadeAnimation(1.1, TextFormField(
                  
                                      controller: TextEditingController(text: widget.long),
                                      onChanged: (value){
                                         widget.long  =value;
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
         
                FadeAnimation(1.2, Row(
                  children: [
                   SizedBox(
                width: 10,
              ),
                    Text('Titre*',style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.bold),).tr(),
                  ],
                ),),
                FadeAnimation(1.3, Row(
                  children: [
                     SizedBox(
                width: 10,
              ),
                   Text('Quel est le sujet de la demande?',style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.normal),).tr(),
                  ],
                ),),
                
                       FadeAnimation(1.4,  Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: themeSwitch ? Colors.grey[850] : Colors.white,))
                                ),
                child:FadeAnimation(1.2, TextFormField(
                                      controller: TextEditingController(text: claim.name),
                                      onChanged: (value){
                                         claim.name=value;
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
                          controller: TextEditingController(text: widget.lati),
                          onChanged: (value) {
                            widget.lati = value;
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
                   Text('Statut*',style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.bold),).tr(),
                  ],
                ),),
                
                  DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward,color: Colors.black,),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
     
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          claim.id=dropdownValue;
      
        });
      },
     
      items: <String>['hors service'.tr(),'']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
       
     ),
     
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
                   Text('Vous pouvez ajouter une ou plusieurs photos \nde l’équipement défaillant',style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.normal),).tr(),
                  ],
                ),),
              
                     Column(
                   children: [
                   
                RaisedButton(
              child: Text("Choisir des images").tr(),
              onPressed: loadAssets,
            ),
            SizedBox(
              height: 100,
              child: buildGridView(),
            )
                   ],
                 ),
                  
                      
                       FadeAnimation(2.1, Container(
                  width: 300,
                  height: 50,
      
                  child:RaisedButton(
                   onPressed: (){
                     if(_formKey.currentState.validate()){
                     
                     save();
                    
                     }
                     else{
                      
                        
                     }
                   },
                   shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                   color: Colors.grey,
                   child: Text('Envoyer réclamation').tr(),
                 ),),
                 ), 
                        
                      ].expand(
                        (widget) => [
                          widget,
                          SizedBox(
                            height: 14,
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

