import 'package:flutter/material.dart';
import 'package:gestion_reclamations_citoyens/map.dart';
import 'package:gestion_reclamations_citoyens/page2.dart';
import 'package:gestion_reclamations_citoyens/recmulti.dart';
import 'cookie_detail.dart';
import 'package:easy_localization/easy_localization.dart';
class CookiePage extends StatelessWidget {
  String lg,la;
  CookiePage({required this.lg,required this.la});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
           actions: [
            
            
           ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewExample()));
          },
        ),
        title: Text('Thématique'.tr()),
      ),
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          
 
          Container(
              padding: EdgeInsets.only(right: 30.0),
              width: MediaQuery.of(context).size.width - 0.0,
              height: MediaQuery.of(context).size.height - 0.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                  _buildCard('ECLAIRAGE PUBLIC'.tr(), '', 'assets/eclairage.jpg',
                      false, false, context),
                  _buildCard('PROPRETÉ ET DÉCHETS'.tr(), '', 'assets/Propreté-déchets.jpg',
                      true, false, context),
                  _buildCard('VOIES ET ESPACES PUBLIQUES'.tr(), '',
                      'assets/images.jpg', false, true, context),
                  _buildCard('AUTRES'.tr(), '', 'assets/autres.png',
                      false, false, context),
                  
                ],
              )),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }

  Widget _buildCard(String name, String price, String imgPath, bool added,
      bool isFavorite, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              if(name=='ECLAIRAGE PUBLIC' || name=="التنوير العمومي"){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FormWidgetsDemo()));
              }
               else if(name=='PROPRETÉ ET DÉCHETS' || name=="النظافة ورفع الفضلات"){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>recmulti(long:lg,lati:la,type:10)));
               } 
               else if(name=='VOIES ET ESPACES PUBLIQUES' || name=="العناية بالطريق العام"){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>recmulti(long:lg,lati:la,type:11)));
               } 
               else{
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>recmulti(long:lg,lati:la,type:12)));
               }  
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                           
                          ])),
                  Hero(
                      tag: imgPath,
                      child: Container(
                          height: 100.0,
                          width: 110.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.contain)))),
                  SizedBox(height: 5.0),
                  Text(price,
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Text(name,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  
                ]))));
  }
}