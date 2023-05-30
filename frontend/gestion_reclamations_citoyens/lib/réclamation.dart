import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gestion_reclamations_citoyens/c.dart';
import 'package:gestion_reclamations_citoyens/f.dart';
import 'package:gestion_reclamations_citoyens/p.dart';
import 'package:gestion_reclamations_citoyens/s.dart';
import 'package:http/http.dart' as http;
import 'package:odoo_api/odoo_api.dart';
import 'package:odoo_api/odoo_api_connector.dart';
import 'package:odoo_api/odoo_user_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'data.dart';

var client = OdooClient("https://tbge-test.odoo.whitecapetech.com");
String nb;
  
  Future<AuthenticateCallback> _connection(BuildContext context) async {
   final jsonstring= await DefaultAssetBundle.of(context).loadString('assets/data/data.json');
   String username=dataFromJson(jsonstring).username;
   String password=dataFromJson(jsonstring).password;
   String dbname=dataFromJson(jsonstring).dbname;
   
    //"pfe@mail.com", "pfe@2021", "tbge"
    AuthenticateCallback auth =
        await client.authenticate(username, password,dbname );
    if (auth.isSuccess) {
      final user = auth.getUser();
      
       
    } else {
     
      
    }
       
       }
   




class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;
 
  Debouncer({this.milliseconds});
 
  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
class Data {
  int id;
   String name;
   String status;
   String description;
   String date;
   String nb;
  Data({this.id,this.name,this.status,this.description,this.date,this.nb });

  factory Data.fromJson(Map<String, dynamic> json) {
    
    return Data(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      description: json["description"],
      date: json["date_claiming"],
      
    );
  }
  Map<String, dynamic> toJson() => {
    'id':id,
        'name': name,
        'status':status,
        'descritpion': description,
      };
     
}

var text='';
class Service{
static Future<List<Data>> save() async {


  
   String url2 = 'http://10.0.2.2:8080/id'; 
  
 
       var res = await http.get(url2,
        
            headers: 
              {'Context-Type': 'application/json'}
            );
         
         var data = json.encode(res.body);
  
    List jsonResponse = json.decode(res.body);
     
     return jsonResponse.map((d) => new Data.fromJson(d)).toList(); 
    
}
 Future<List<Data>> fetchData() async {
 
final domain = [
        ["status", "!=", false],["description", "!=", false]
        ];
        var fields = ["name","description","status"];
      OdooResponse result = await  client
            .searchRead("maintenance.request", domain, fields);
          if (!result.hasError()) {
            
            final response = result.getResult();
           
           var data = json.encode(response['records']);
    
      List jsonResponse = json.decode(data);
     
      return jsonResponse.map((d) => new Data.fromJson(d)).toList();
     
       } else {
           
          }
          

  
}
}



Data data = new Data();
class MyApp3 extends StatefulWidget {
  MyApp3({Key key}) : super(key: key);

  @override
  _MyApp3State createState() => _MyApp3State();
}

class _MyApp3State extends State<MyApp3> with SingleTickerProviderStateMixin{
 
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  List<Data> inf=List();
  List<Data> filtered=List();
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  var android = new AndroidInitializationSettings('@drawable/launch_background');
  var iOS = new IOSInitializationSettings();
  var initSetttings = new InitializationSettings(android, iOS);
  flutterLocalNotificationsPlugin.initialize(initSetttings,
      onSelectNotification: onSelectNotification);
      
  Service.save().then((rec){
  setState(() {
    inf=rec;
    filtered=inf;
    for(int i=0;i<filtered.length;i++){
    print(filtered[i].status);
    if(filtered[i].status=='in_progress'){
         showNotification2();
        }
        if(filtered[i].status=='done'){
          showNotification();
        }
    }
  });
  });
  
        
      
  }
  Future onSelectNotification(String payload) {
  debugPrint("payload : $payload");
  showDialog(
    context: context,
    builder: (_) => new AlertDialog(
      title: new Text('Notification'),
      content: new Text('$payload'),
    ),
  );
}
showNotification() async {
  var android = new AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.High,importance: Importance.Max
  );
  var iOS = new IOSNotificationDetails();
  var platform = new NotificationDetails(android, iOS);
  await flutterLocalNotificationsPlugin.show(
      0, 'Notification', 'Votre réclamation est terminée', platform,
      payload: 'AndroidCoding.in');
}
showNotification2() async {
  var android = new AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.High,importance: Importance.Max
  );
  var iOS = new IOSNotificationDetails();
  var platform = new NotificationDetails(android, iOS);
  await flutterLocalNotificationsPlugin.show(
      0, 'Notification', 'Votre réclamation est en progrès', platform,
      payload: 'AndroidCoding.in');
}
   final _debouncer = Debouncer(milliseconds: 500);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar:  AppBar(
      
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:Text('Suivre les réclamations').tr(),
       bottom:  TabBar(
            tabs: <Widget>[
              Text(
                 'ECLAIRAGE PUBLIC'.tr(),style: TextStyle(fontSize: 15),
              ),
              Text(
                 'Autres thématiques'.tr(),style: TextStyle(fontSize: 15),
              ),
             
            ],
          ),
        
      ),
        body: 
      TabBarView(
       children: [
          Column(
        children: [
           TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Filtrer par nom ou statut ou description'.tr(),
            ),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  filtered = inf
                      .where((u) => (u.name.toLowerCase()
                              
                              .contains(string.toLowerCase()) ||
                          u.status.toLowerCase().contains(string.toLowerCase())
                          ||
                          u.description.toLowerCase().contains(string.toLowerCase())))
                      .toList();
                });
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
   Expanded(child: 
   ListView.builder(
                  
                itemCount: filtered.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    
                    color: Colors.white,
                    child: Column( 
                      
                      children: [
                        
Card(                         
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
       clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(40), // if you need this
    side: BorderSide(
      color: Colors.grey.withOpacity(0.2),
      width: 1,
    ),),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child:Column(
          children: [
             ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 1.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 2.0, color: Colors.white24))),
          child: Icon(Icons.view_list, color: Colors.white),
        ),
        
        title: Row(
           children: [
              Icon(Icons.title,color: Colors.cyan,),
              SizedBox(
                width: 5,
              ),
             Text('Titre: '+filtered[index].name,style: TextStyle(color: Colors.white)),
           ],
        ),
       

        subtitle: Row(
          children: [
            Icon(Icons.description,color: Colors.cyan,),
            SizedBox(
                width: 5,
              ),
              
           Text('Description: '+filtered[index].description,
                    style: TextStyle(color: Colors.white,fontSize: 14),

                  ),
          ],
        ),
       
      ),
      
       Padding(
                 
                  padding: const EdgeInsets.all(1.0),
                  child: Text('Statut: '+filtered[index].status,
                    style: TextStyle(color: Colors.white,),
                  ),
                ),
          ],
        ),
                      
                       ),
                      
                       ),
                       
                      ],
                    ),
                  );
                }
           ),
   ),
             
        ],
      ),
            ListView(
                children: [
                  
                  InkWell(
                    child: Card(child: ListTile(title: Text('PROPRETÉ ET DÉCHETS'.tr(),textAlign: TextAlign.left))),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>fuitepage()));
                  },
                  ),
                  InkWell(
                    child: Card(child: ListTile(title: Text('VOIES ET ESPACES PUBLIQUES'.tr(),textAlign: TextAlign.left))),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>placepage()));
                  },
                  ),
                  InkWell(
                    child: Card(child: ListTile(title: Text('AUTRES'.tr(),textAlign: TextAlign.left))),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>signpage()));
                  },
                  ),
                  
                ],
            
            ),
       ],
     ),    
       
       
       
     
     ) );
  }
}
