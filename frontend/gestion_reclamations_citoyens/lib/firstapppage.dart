import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_reclamations_citoyens/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'connexion.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }
  SharedPreferences? log;
  String? page;
void checkdata() async{
       log = await SharedPreferences.getInstance();
       page = log?.getString('keystring') ?? '';
       if(page=='nextstep'){
Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
       }
       }
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
 String dropdownValue = 'Français';
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
               SizedBox(
                 height: 10,
               ),
              
      Row(
        children: [
                   Container(
                  alignment: Alignment.centerLeft,
                  child: FlatButton(
                    onPressed: () => context.locale=Locale("fr","FR"),
                    child: Text(
                      'Langue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ).tr(),
                  ),
                ),
                DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward,color: Colors.black,),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
     
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
            if(dropdownValue=='Français'){
   context.locale=Locale("fr","FR");
        }else{
          context.locale=Locale("ar","AR");
        }
        });
      },
     
      items: <String>['Français', 'Arabe']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value).tr(),
        );
      }).toList(),
       
     ),
  
                SizedBox(
                  width: 90,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => {
                      log?.setString('keystring', 'nextstep'),
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen())),
                    },
                    child: Text(
                      'Sauter'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
        ],
      ),
                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/protest.png',
                                ),
                                height: 200.0,
                                width: 200.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Bienvenue dans \ncette application'.tr(),
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Voulez-vous un moyen plus rapide et plus efficace de déposer votre réclamation auprès de la municipalité sans vous y rendre?'.tr(),
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/mobile.png',
                                ),
                                height: 200.0,
                                width: 200.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Vivez votre vie plus intelligemment avec nous!'.tr(),
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Vous pouvez rédiger votre réclamation ',
                              style: kSubtitleStyle,
                            ).tr(),
                            Text(
                              'et l’envoyer à la municipalité en utilisant cette application sur votre téléphone en quelques instants.',
                              style: kSubtitleStyle,
                            ).tr(),
                           
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/map.png',
                                ),
                                height: 200.0,
                                width: 200.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Utilisez votre localisation',
                              style: kTitleStyle,
                            ).tr(),
                            SizedBox(height: 15.0),
                            Text(
                              'Vous pouvez utiliser la carte et déterminer votre emplacement.'.tr(),
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                    Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Suivant',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ).tr(),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      
      bottomSheet: _currentPage == _numPages - 1
          ? 
          Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.white,
              child: FlatButton(
                
                onPressed: () => {
                  log?.setString('keystring', 'nextstep'),
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen())),
                },
                  
                  
                
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Commencer',
                      style: TextStyle(
                        color: Color(0xFF5B16D0),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}