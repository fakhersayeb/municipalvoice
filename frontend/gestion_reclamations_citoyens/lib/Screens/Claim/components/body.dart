import 'package:flutter/material.dart';
import 'package:gestion_reclamations_citoyens/Screens/Claim/claim.dart';
import 'package:gestion_reclamations_citoyens/Screens/ClaimRequest/FormulaireClaim.dart';
import 'package:gestion_reclamations_citoyens/Screens/Home/HomeScreen.dart';
import 'package:gestion_reclamations_citoyens/Screens/LightsClaim/lightsClaimScreen.dart';
import 'background.dart';
import '../../../Screens/Signup/signup_screen.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:gestion_reclamations_citoyens/example.dart';
import 'package:gestion_reclamations_citoyens/page2.dart';
//import '/../Screens/Proposition/proposition.dart';

import '../../../color_filters.dart';
import '../../../map.dart';
import 'card.dart';
import 'package:flutter/material.dart';
import 'package:gestion_reclamations_citoyens/map.dart';
import 'package:gestion_reclamations_citoyens/page2.dart';
import 'package:gestion_reclamations_citoyens/recmulti.dart';
import '../../../cookie_detail.dart';
import 'package:easy_localization/easy_localization.dart';

//import '/../homepage.dart';
//import '/../introduirecards.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  get lg => null;

  //const introduirecard({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //const introduirecard({key}) : super(key: key);

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(0xFF0974c9),
        actions: [],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        toolbarHeight: 80,
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,

        title: Text('Thématique', style: TextStyle(color: Colors.black)),

        //title: Text('Test'.tr()),
      ),
      backgroundColor: Colors.white,
      // backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 70,
          ),
          Container(
              padding: EdgeInsets.only(right: 25.0, left: 25),
              width: MediaQuery.of(context).size.width - 0.0,
              height: MediaQuery.of(context).size.height - 0.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 30.0,
                mainAxisSpacing: 50.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                  _buildCard('ECLAIRAGE PUBLIC'.tr(), '',
                      'assets/images/eclairage.png', false, false, context),
                  _buildCard(
                      'PROPRETÉ ET DÉCHETS'.tr(),
                      '',
                      'assets/images/Propreté-déchets.png',
                      true,
                      false,
                      context),
                  _buildCard('VOIES ET ESPACES PUBLIQUES'.tr(), '',
                      'assets/images/df.png', false, true, context),
                  _buildCard('AUTRES'.tr(), '', 'assets/images/autres.png',
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
              if (name == 'ECLAIRAGE PUBLIC' || name == "التنوير العمومي") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LightsClaimScreen(
                            type:15
                            )));
              } else if (name == 'PROPRETÉ ET DÉCHETS' ||
                  name == "النظافة ورفع الفضلات") {
                var la;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormulaireClaimScreen(
                            long: lg, lati: la, type: 16)));
              } else if (name == 'VOIES ET ESPACES PUBLIQUES' ||
                  name == "العناية بالطريق العام") {
                var la;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormulaireClaimScreen(
                            long: lg, lati: la, type: 17)));
              } else {
                var la;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormulaireClaimScreen(
                            long: lg, lati: la, type: 18)));
              }
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
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
                          children: [])),
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

                  
                  // Text("text", textAlign: TextAlign.center,)
                  Text(name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          // fontFamily: 'Varela',

                          fontSize: 18.0,
                          fontWeight: FontWeight.w700)),
                ]))));
  }
}
