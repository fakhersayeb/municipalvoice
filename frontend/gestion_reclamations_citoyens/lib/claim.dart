import 'package:flutter/material.dart';
import 'package:gestion_reclamations_citoyens/map.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:easy_localization/easy_localization.dart';
class LanguagesScreen extends StatefulWidget {
  String txt;
  LanguagesScreen({Key? key,required this.txt}) : super(key: key);
  
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.txt);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home:Scaffold(
      appBar: AppBar(
           leading: IconButton(
             icon: Icon(Icons.arrow_back_ios),
             onPressed: () {
               Navigator.pop(context);
             },
           ),
           title: Text('Langues').tr(),
         ),
         body: SettingsList(
   
        sections: [
          SettingsSection(
            title: 'choisir une langue'.tr(),
            tiles: [
              SettingsTile(
                title: 'Français'.tr(),
                
                leading: Icon(Icons.language),
                onTap: () {
                  context.locale=Locale("fr","FR");
                //  Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewExample(value:widget.txt)));
                },
              ),
              SettingsTile(
               
                  title: 'Arabe'.tr(),
                  
                  leading: Icon(Icons.language),
onTap: () {
                  context.locale=Locale("ar","AR");
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewExample(value:widget.txt)));
                },                  
                  ),
                  
            ],
          ),
         ] ) ));
  }
}