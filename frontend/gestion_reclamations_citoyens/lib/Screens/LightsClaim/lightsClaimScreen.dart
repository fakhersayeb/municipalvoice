import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gestion_reclamations_citoyens/Screens/Home/HomeScreen.dart';
import 'package:gestion_reclamations_citoyens/components/rounded_input_field_Claim.dart';
import 'package:gestion_reclamations_citoyens/components/rounded_password_field.dart';
import 'package:gestion_reclamations_citoyens/shared.dart';
import '../../components/rounded_button.dart';
import 'package:gestion_reclamations_citoyens/constants.dart';

import 'package:image_picker/image_picker.dart';

import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';
import '../../FadeAnimation.dart';
import '../../data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Claim {
  String id;
  String name;
  String commentaire;
  String adresse;
  List<String> fi = [];
  String date;
  Claim(
      {this.id, this.name, this.commentaire, this.adresse, this.fi, this.date});
}

Claim claim = Claim();

class LightsClaimScreen extends StatefulWidget {
  int type;
  LightsClaimScreen({this.type});
  @override
  _LightsClaimScreenState createState() => _LightsClaimScreenState();
}

class _LightsClaimScreenState extends State<LightsClaimScreen> {
  String dropdownValue = '';
  String nom, prenom, email, adresse, ad;
  List<Asset> images = List<Asset>();
  List files = [];
  String _error;
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
      if (error == null) _error = 'No Error Dectected';
    });
  }

  getImageFileFromAsset(String path) async {
    final file = File(path);
    print(file);

    return file;
  }

  Future save() async {
    String url = 'http://10.0.2.2:8080/rec';
    var now = new DateTime.now();
    List imglist = [];
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    claim.date = formattedDate;
    var base64Image;
    String Name;
    var name1, name2, name3;
    String name4, name5, name6;
    for (int i = 0; i < images.length; i++) {
      var path2 =
          await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
      var file = await getImageFileFromAsset(path2);
      String Name = file.path.split('/').last;
      var base64Image = base64Encode(file.readAsBytesSync());
      imglist.add(jsonEncode(Name));
      files.add(base64Image);
    }
    if (files.length == 1) {
      name1 = files[0];
      name4 = imglist[0];
      jsonEncode(name1);
      jsonEncode(name4);
      print('img1' + name1);
      print(name4);
    }
    if (files.length == 2) {
      name1 = files[0];
      name2 = files[1];
      name4 = imglist[0];
      name5 = imglist[1];
      jsonEncode(name1);
      jsonEncode(name4);
      jsonEncode(name2);
      jsonEncode(name5);
      print('img1' + name1);
      print('img2' + name2);
      print(name4);
      print(name5);
    }
    if (files.length == 3) {
      name1 = files[0];
      name2 = files[1];
      name3 = files[2];
      name4 = imglist[0];
      name5 = imglist[1];
      name6 = imglist[2];
      jsonEncode(name1);
      jsonEncode(name4);
      jsonEncode(name2);
      jsonEncode(name5);
      jsonEncode(name3);
      jsonEncode(name6);
      print('img1' + name1);
      print('img2' + name2);
      print('img3' + name3);
      print(name4);
      print(name5);
      print(name6);
    }

    print(files);
    print(files.length);

    final msg = jsonEncode({
      'name': claim.name,
      'commentaire': claim.commentaire,
      'adresse': claim.adresse,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'adr': adresse,
      'latitude':latitude,
      'longitude':longitude,
      'id': claim.id,
      'name1': name1,
      'name2': name2,
      'name3': name3,
      'name4': name4,
      'name5': name5,
      'name6': name6,
      'date': claim.date,
      'type': widget.type
    });
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
      if (res.body == 'réclamation envoyée') {
        Fluttertoast.showToast(
            msg: "Réclamation envoyée".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        files.clear();
        print(files.length);
      }
    } catch (e) {
      return e.message;
    }
  }

  var client = OdooClient("https://tbge-test.odoo.whitecapetech.com");

  Future<AuthenticateCallback> _connection(context) async {
    final jsonstring = await DefaultAssetBundle.of(context)
        .loadString('assets/data/data.json');
    String username = dataFromJson(jsonstring).username;
    String password = dataFromJson(jsonstring).password;
    String dbname = dataFromJson(jsonstring).dbname;

    AuthenticateCallback auth =
        await client.authenticate(username, password, dbname);
    if (auth.isSuccess) {
      final user = auth.getUser();
      print("Hey ${user.name}");
    } else {
      print("Login failed");
    }
  }

  Future<OdooResponse> _addrec() async {
    client.create("maintenance.request", {
      'name': claim.name,
      'description': claim.commentaire,
      'equipment_id': claim.id
    }).then((OdooResponse result) {
      if (result.hasError()) {
        print(result.getError());
      } else {
        print('succesful');
        print(result.getStatusCode());
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
    _connection(context);
    MySharedPreferences.instance
        .getStringValue("nom")
        .then((value) => setState(() {
              nom = value;
            }));
    MySharedPreferences.instance
        .getStringValue("prenom")
        .then((value) => setState(() {
              prenom = value;
            }));
    MySharedPreferences.instance
        .getStringValue("email")
        .then((value) => setState(() {
              email = value;
            }));
    MySharedPreferences.instance
        .getStringValue("adresse")
        .then((value) => setState(() {
              adresse = value;
            }));
  }
 String longitude,latitude;
Position position;
   _getCurrentLocation() async{
    Geolocator geolocator;
 position = await Geolocator.getCurrentPosition( desiredAccuracy: LocationAccuracy.bestForNavigation,forceAndroidLocationManager:true);
    
      longitude=position.longitude.toString();
      latitude=position.latitude.toString();
     print(longitude);
     print(latitude);
  }
  Future save2() async {
    String url = 'https://nodetbge.seedbytes.com/claim';
    var res = await http.post(url, headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    }, body: <String, String>{
      "adresse": claim.adresse,
      "name": claim.name,
      "commentaire": claim.commentaire,
      "id": claim.id,
    });
    print(res.body);
  }

  Future<OdooResponse> _getrec3() async {
    final domain = [
      ["name", "=", claim.adresse]
    ];
    var fields = ["id"];
    client
        .searchRead("maintenance.equipment", domain, fields)
        .then((OdooResponse result) {
      if (!result.hasError()) {
        print("Succesful");
        final data = result.getResult();
        print(data);
        print("Total: ${data['length']}");
        final records = ("${data["records"]}");
        String s = records.substring(6, 11);
        int num = int.parse(s);
        print(records);
        print(s);

        // claim.id=num;
        // return claim.id;
      } else {
        print(result.getError());
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
        print(_textValue);
        // claim.adresse=_textValue;
      });
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Color(0xFF0974c9),
          actions: [IconButton(
            icon: Icon(Icons.home),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return HomeScreen();
                        },
                      ),
                    );
            },
          ),],
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

          title: Text('Ajout de réclamation',
              style: TextStyle(color: Colors.black)),
          // title: Text('Ajout de réclamation').tr(),
        ),
        body: Form(
          key: _formKey,
          child: Scrollbar(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Container(
                  color: themeColors(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 35),
                      ...[
                       
         
                        FadeAnimation(
                          1.2,
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Code*',
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
                        FadeAnimation(
                          1.3,
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '(Veuillez saisir le code de l’équipement défaillant)',
                                style: TextStyle(
                                    color: themeSwitch
                                        ? Colors.white
                                        : Colors.grey[850],
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ).tr(),
                            ],
                          ),
                        ),
                        FadeAnimation(
                          1.3,
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '(le code est inscrit sur l’équipement AxxxDxPxxx)',
                                style: TextStyle(
                                    color: themeSwitch
                                        ? Colors.white
                                        : Colors.grey[850],
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ).tr(),
                            ],
                          ),
                        ),
                     
                        Container(
                          // padding: const EdgeInsets.all(28.0),
                          padding: const EdgeInsets.fromLTRB(30, 35, 30, 5),
                          // margin: EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                  controller: TextEditingController(
                                      text: claim.adresse),
                                  onChanged: (value) {
                                    claim.adresse = value;
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
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 5, 30, 5),
                                        // child: Icon(
                                        //   Icons.lock,
                                        //   color: kPrimaryColor,
                                        // ), // icon is 48px widget.
                                      ),
                                      hintText: "Code",
                                      // border: InputBorder.none,
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide:
                                              BorderSide(color: Colors.red)),
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

                        FadeAnimation(
                          1.2,
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Titre*',
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
                        FadeAnimation(
                          1.3,
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Quel est le sujet de la demande?',
                                style: TextStyle(
                                    color: themeSwitch
                                        ? Colors.white
                                        : Colors.grey[850],
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ).tr(),
                            ],
                          ),
                        ),
                       

                        Container(
                          // padding: const EdgeInsets.all(28.0),
                          padding: const EdgeInsets.fromLTRB(30, 35, 30, 5),
                          // margin: EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                  controller:
                                      TextEditingController(text: claim.name),
                                  onChanged: (value) {
                                    claim.name = value;
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
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 5, 30, 5),
                                        // child: Icon(
                                        //   Icons.lock,
                                        //   color: kPrimaryColor,
                                        // ), // icon is 48px widget.
                                      ),
                                      hintText: "Sujet",
                                      // border: InputBorder.none,
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide:
                                              BorderSide(color: Colors.red)),
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
                                     
                                      filled: true))
                            ],
                          ),
                        ),
                       
                       
                        FadeAnimation(
                          1.5,
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Détails',
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
                        FadeAnimation(
                          1.6,
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Merci de nous donner plus de détails',
                                style: TextStyle(
                                    color: themeSwitch
                                        ? Colors.white
                                        : Colors.grey[850],
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ).tr(),
                            ],
                          ),
                        ),

                        
                        Container(
                          // padding: const EdgeInsets.all(28.0),
                          padding: const EdgeInsets.fromLTRB(30, 35, 30, 5),
                          // margin: EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                  controller: TextEditingController(
                                      text: claim.commentaire),
                                  onChanged: (value) {
                                    claim.commentaire = value;
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
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 5, 30, 5),
                                        
                                      ),
                                      hintText: "Détails",
                                      // border: InputBorder.none,
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide:
                                              BorderSide(color: Colors.red)),
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
                                      
                                      filled: true))
                            ],
                          ),
                        ),

                        FadeAnimation(
                          1.8,
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Statut*',
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

                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(
                            Icons.arrow_downward,
                            color: Colors.black,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                              claim.id = dropdownValue;
                              print(claim.id);
                            });
                          },
                          items: <String>['hors service'.tr(), '']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        FadeAnimation(
                          1.8,
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Image(s)',
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
                        FadeAnimation(
                          1.9,
                          Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Vous pouvez ajouter une ou plusieurs photos \nde l’équipement défaillant',
                                style: TextStyle(
                                    color: themeSwitch
                                        ? Colors.white
                                        : Colors.grey[850],
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ).tr(),
                            ],
                          ),
                        ),

                        Column(
                          children: [
                            RaisedButton(
                              child: Text("Choisir des images").tr(),
                              onPressed: loadAssets,
                              color: kPrimaryColor,
                              textColor: Colors.white,
                            ),
                            SizedBox(
                              height: 120,
                              child: buildGridView(),
                            )
                          ],
                        ),

                        FadeAnimation(
                          2.1,
                          Container(
                            // width: 300,
                            // height: 50,

                            child: RoundedButton(
                              text: "Envoyer réclamation",
                              //     child: RaisedButton(
                              press: () {
                                if (_formKey.currentState.validate()) {
                                  save();
                                } else {
                                  print('not ok');
                                }
                              },
                             
                            ),
                          ),

                        
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
        ));
  }
}
