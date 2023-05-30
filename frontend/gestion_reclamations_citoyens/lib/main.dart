import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gestion_reclamations_citoyens/cards.dart';
import 'package:gestion_reclamations_citoyens/example.dart';

import 'package:gestion_reclamations_citoyens/map.dart';
import 'package:gestion_reclamations_citoyens/inscription.dart';

import 'package:gestion_reclamations_citoyens/firstapppage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'connexion.dart';

import 'inscription.dart';


void main() async{
   
  runApp( EasyLocalization(
      supportedLocales: [Locale('fr', 'FR'), Locale('ar', 'AR')],
      path: 'assets/locales', // <-- change the path of the translation files 
      fallbackLocale: Locale('fr', 'FR'),
      child: My()
    ),);
}
class My extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}
void test(){
  
}
class _MyState extends State<My> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      
      home: OnboardingScreen(),
    );
  }
}



