import 'package:flutter/material.dart';
import 'package:gestion_reclamations_citoyens/example.dart';
import 'package:gestion_reclamations_citoyens/page2.dart';
//import '/../Screens/Proposition/proposition.dart';

import 'cards.dart';
import 'color_filters.dart';
import 'map.dart';

class introduirecard extends StatelessWidget {
  const introduirecard({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF0974c9),
            // leading: IconButton(
            //   icon: Icon(Icons.home),
            //   onPressed: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => WebViewExample()));
            //   },
            // ),
            centerTitle: true,
            title: Text(''),
          ),
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.all(35.0),
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                MyMenu(
                  title: "Nouveautés",
                  img: 'assets/schedule.png',
                  warna: Colors.blue,
                  navigation:
                      MaterialPageRoute(builder: (context) => CookiePage()), 
                ),
                MyMenu(
                  title: "Réclamations",
                  img: 'assets/images/megaphone.png',
                  warna: Colors.blue,
                  navigation:
                      MaterialPageRoute(builder: (context) => CookiePage()),
                ),
                MyMenu(
                  title: "Propositions",
                  img: 'assets/handshake.png',
                  warna: Colors.red,
                  navigation: MaterialPageRoute(builder: (context) => MyApp()),
                ),
                MyMenu(
                  title: "Info",
                  img: 'assets/info.png',
                  warna: Colors.yellow,
                  navigation: MaterialPageRoute(builder: (context) => MyApp2()),
                ),
                MyMenu(
                  title: "Contact",
                  img: 'assets/images/phone.png',
                  warna: Colors.blueGrey,
                  navigation: MaterialPageRoute(builder: (context) => MyApp2()),
                ),
              ],
            ),
          )),
    );
  }
}

class MyMenu extends StatelessWidget {
  MyMenu({required this.title, this.img,required this.warna,required this.navigation});
  final String title;
  final img;
  final MaterialPageRoute navigation;

  final MaterialColor warna;
// ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF282f61), width: 2.0),
        borderRadius: BorderRadius.all(
            Radius.circular(10.0) //                 <--- border radius here
            ),
      ),
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, navigation);
        },
        splashColor: Colors.green,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 80.0,
              width: 80,
              child: Ink.image(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
            ),

            // Icon(
            //   icon,
            //   size: 70.0,
            //   color: warna,
            // ),
            Text(title, style: new TextStyle(fontSize: 17.0))
          ],
        )),
      ),
    ));
  }
}
