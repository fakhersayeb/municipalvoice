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
  int id;
  String name;
  String commentaire;
  String adresse;
  Claim({ this.id,this.name,this.commentaire,this.adresse});
  factory Claim.fromJson(Map<String, dynamic> json) {
    
    return Claim(
      id: json["id"],
      name: json["name"],
      commentaire: json["commentaire"],
      adresse: json["adresse"],
      
    );
  }
}

  Claim claim = Claim();
  


class techconnexion extends StatefulWidget {
  @override
  techconnexionState createState() => techconnexionState();
}

class techconnexionState extends State<techconnexion> {
 String dropdownValue='';
File imagefile;
    _opengallery(BuildContext context) async{
      var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
      this.setState(() {
        imagefile = picture;
        
      });
      Navigator.of(context).pop();
      }
      _opencamera(BuildContext context) async{
        var picture = await ImagePicker.pickImage(source: ImageSource.camera);
      this.setState(() {
        imagefile = picture;
        
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
    
   Widget _decideimageview(){
         
       if( imagefile != null){
      return
        Image.file(imagefile,width:150,height: 150,);
     
      
    }
    else{
       return FadeAnimation(1.4, Image.asset('assets/image.jpg',width: 150,height: 150,),);
    }
      
   }
 Future save() async {
       String url = 'https://nodetbge.seedbytes.com/update'; 
        var res = await http.put(url,
        
            headers: <String, String>{
              'Context-Type': 'application/json;charSet=UTF-8'
            },
            body: <String, String>{
              'adresse': claim.adresse,
              'name': claim.name,
            });
   
        if(res.body=='réclamation modifiée'){
          Fluttertoast.showToast(
            msg: "Réclamation modifiée".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
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
          
            
            claim.id=num;
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
        title: Text('Mis à jour de réclamation').tr(),
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

                        FadeAnimation(0.9, Image.asset('assets/update.gif',height: 150,width: 250,
                        
                        
                        ),),
                Padding(padding: EdgeInsets.all(1)),
             
                    FadeAnimation(1.2, Row(
                  children: [
              SizedBox(
                width: 10,
              ),     
                    Text('Code*',style: TextStyle(color: themeSwitch ? Colors.white : Colors.grey[850],fontSize: 15,fontWeight: FontWeight.bold),).tr(),
                  ],
                ),),
              
                _textValue==''? FadeAnimation(1.1,  Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: themeSwitch ? Colors.grey[850] : Colors.white,))
                                ),
                child:FadeAnimation(1.1, TextFormField(
                  
                                      controller: TextEditingController(text: _textValue),
                                      onChanged: (value){
                                         _textValue=value;
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
                 ),):FadeAnimation(1.1,  Container(
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
     claim.name=dropdownValue;
        
        });
      },
     
      items: <String>['functional','']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
       
     ), 
                  
                      
                       FadeAnimation(2.1, Container(
                  width: 300,
                  height: 50,
      
                  child:RaisedButton(
                   onPressed: (){
                     if(_formKey.currentState.validate()){
                     // _addrec();
                      save();
                     }
                     else{
                     
                        
                     }
                   },
                   shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                   color: Colors.grey,
                   child: Text('Modifier réclamation').tr(),
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

