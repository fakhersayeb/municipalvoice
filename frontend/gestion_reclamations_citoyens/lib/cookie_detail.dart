import 'package:flutter/material.dart';
import 'package:gestion_reclamations_citoyens/cards.dart';
import 'package:gestion_reclamations_citoyens/color_filters.dart';
import 'package:gestion_reclamations_citoyens/page2.dart';
import 'package:gestion_reclamations_citoyens/recmulti.dart';
import 'package:easy_localization/easy_localization.dart';

class CookieDetail extends StatelessWidget {
  final assetPath, cookieprice, cookiename;
 String lon,lat;
  CookieDetail({this.assetPath, this.cookieprice, this.cookiename,required this.lon,required this.lat});
  String e='Si vous avez vu un poteau cassé,vous pouvez nous envoyer les détails et des images sous forme de réclamation.'.tr();
  String f='Si vous avez vu une conduite de eau cassé,vous pouvez nous envoyer les détails et des images sous forme de réclamation.'.tr();
  String p='Si vous avez vu quelque chose cassée,vous pouvez nous envoyer les détails et des images sous forme de réclamation.'.tr();
  String s='Si vous avez vu une signalisation routière cassée,vous pouvez nous envoyer les détails et des images sous forme de réclamation.'.tr();
  String c='Si vous avez vu une problème dans un chantier,vous pouvez nous envoyer les détails et des images sous forme de réclamation.'.tr();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
           actions: [
            
            
           ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CookiePage(la: '', lg: '',)));
          },
        ),
        title: Text('Détails').tr(),
      ),

      body: ListView(
        children: [
          SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Thématique'.tr(),
              style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 42.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF17532))
            ),
          ),
            SizedBox(height: 15.0),
            Hero(
              tag: assetPath,
              child: Image.asset(assetPath,
              height: 150.0,
              width: 100.0,
              fit: BoxFit.contain
              )
            ),
            SizedBox(height: 20.0),
            Center(
              child: Text(cookieprice,
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF17532))),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(cookiename,
                  style: TextStyle(
                      color: Color(0xFF575E67),
                      fontFamily: 'Varela',
                      fontSize: 24.0)),
            ),
            SizedBox(height: 20.0),
           cookiename=='Eclairage public' || cookiename=='الإنارة العامة' ? Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(e,
                textAlign: TextAlign.center,
                style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      color: Colors.black)
                ),
              ),
            ):cookiename=='Fuites canalisation de eau' || cookiename=='تسرب مواسير المياه' ? Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(f,
                textAlign: TextAlign.center,
                style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      color: Colors.black)
                ),
              ),
            ):cookiename=='Places publics' || cookiename=='أماكن عامة' ? Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(p,
                textAlign: TextAlign.center,
                style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      color: Colors.black)
                ),
              ),
            ):cookiename=='Signalisation routière' || cookiename=='علامة طريق' ? Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(s,
                textAlign: TextAlign.center,
                style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      color: Colors.black)
                ),
              ),
            ): Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(c,
                textAlign: TextAlign.center,
                style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      color: Colors.black)
                ),
              ),
            ),
            SizedBox(height: 20.0),
           Padding(padding:   EdgeInsets.all(40),
            child:Center(
              child: ElevatedButton(
                   
                onPressed: (){
                  if(cookiename=='ECLAIRAGE PUBLIC' || cookiename=='التنوير العمومي'){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FormWidgetsDemo()));
                  }else if(cookiename=='PROPRETÉ ET DÉCHETS' || cookiename=='النظافة ورفع الفضلات'){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>recmulti(long:lon,lati:lat)));
                  }
                  else if(cookiename=='Places publics' || cookiename=='أماكن عامة'){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>recmulti(long:lon,lati:lat)));
                  }
                  else if(cookiename=='Signalisation routière' || cookiename=='علامة طريق'){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>recmulti(long:lon,lati:lat)));
                  }
                  else if(cookiename=='Chantiers(sécurité)' || cookiename=='مواقع البناء (الأمان)'){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>recmulti(long:lon,lati:lat)));
                  }
                },
                child: Center(
                  child: Text('Suivant'.tr(),
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                ),
                  )
                )
              )
            )
           ),
        ]
      ),

      
    );
  }
}