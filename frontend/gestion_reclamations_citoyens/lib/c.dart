import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_reclamations_citoyens/r%C3%A9clamation.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:odoo_api/odoo_api_connector.dart';
class Service{
static Future<List<Data>> save() async {


  
   String url2 = 'http://10.0.2.2:8080/idc'; 
   print(url2);
 
       var res = await http.get(url2,
        
            headers: 
              {'Context-Type': 'application/json'}
            );
         
         var data = json.encode(res.body);
     print(data);
    List jsonResponse = json.decode(res.body);
      print(jsonResponse);
     print (jsonResponse.map((d) => new Data.fromJson(d)).toList());
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
            print("Succesful");
            final response = result.getResult();
            print(response);
           var data = json.encode(response['records']);
     print(data);
      List jsonResponse = json.decode(data);
      print(jsonResponse);
      print (jsonResponse.map((d) => new Data.fromJson(d)).toList());
      return jsonResponse.map((d) => new Data.fromJson(d)).toList();
     
       } else {
            print(result.getError()); 
            return [];
          }
          

  
}

}
class chantierpage extends StatefulWidget {
  const chantierpage({ Key? key }) : super(key: key);

  @override
  _chantierpageState createState() => _chantierpageState();
}

class _chantierpageState extends State<chantierpage> {
  final _debouncer = Debouncer(milliseconds: 500);
   List<Data> inf=[];
  List<Data> filtered=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Service.save().then((rec){
  setState(() {
    inf=rec;
    filtered=inf;
  });
  });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Suivre les réclamations').tr(),),
      body: 
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
                          u.date.toLowerCase().contains(string.toLowerCase())))
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
              
           Text('Date: '+filtered[index].date,
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
                    )
                      ]),
   );
                })
       )
       ]
       )
       )
       );
  }
}