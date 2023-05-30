import 'package:flutter/material.dart';
import 'package:gestion_reclamations_citoyens/Screens/Claim/claim.dart';
import 'package:gestion_reclamations_citoyens/Screens/Proposition/proposition.dart';
import 'package:gestion_reclamations_citoyens/Screens/information/information.dart';
import '../../../news.dart';
import '../../../réclamation.dart';
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
import '/../Screens/Proposition/proposition.dart';

import '../../../color_filters.dart';
import '../../../map.dart';
import 'card.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  //const introduirecard({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
           
            toolbarHeight: 90,
            bottomOpacity: 0.0,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            centerTitle: true,

            title: Text('Accueil', style: TextStyle(color: Colors.black)),
          ),
          // backgroundColor: Colors.transparent,

          body: Container(
            padding: EdgeInsets.all(40.0),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (.5 / .5),
              children: <Widget>[
                
                MyCards(
                  title: "Réclamations",
                  img: 'assets/images/megaphone.png',
                  warna: Colors.red,
                  navigation:
                      MaterialPageRoute(builder: (context) => ClaimScreen()),
                ),
                MyCards(
                  title: "Propositions",
                  img: 'assets/images/handshake.png',
                  warna: Colors.red,
                  navigation:
                      MaterialPageRoute(builder: (context) => Proposition()),
                ),
                MyCards(
                  title: "Info",
                  img: 'assets/images/info.png',
                  warna: Colors.yellow,
                  navigation:
                      MaterialPageRoute(builder: (context) => Information()),
                ),
                MyCards(
                  title: "Suivi",
                  img: 'assets/imgpsh_fullsize_anim.png',
                  warna: Colors.yellow,
                  navigation:
                      MaterialPageRoute(builder: (context) => MyApp3()),
                ),
                 MyCards(
                  title: "Nouveautés",
                  img: 'assets/news.png',
                  warna: Colors.yellow,
                  navigation:
                      MaterialPageRoute(builder: (context) => newspage()),
                ),
               
              ],
            ),
          )),
    );
  }
}


  


