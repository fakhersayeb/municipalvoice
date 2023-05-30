import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCards extends StatelessWidget {
  MyCards({required this.title, this.img, required this.warna,required this.navigation});
  final String title;
  final img;
  final MaterialPageRoute navigation;

  final MaterialColor warna;
// ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(15.0),
        elevation: 10,
        color: Color(0xFFf5f5f7),
        child: Container(
          // decoration: BoxDecoration(
          //   // border: Border.all(color: Color(0xFF282f61), width: .9),
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(75.0), //                 <--- border radius here
          //   ),
          // ),
          margin: EdgeInsets.all(.9),
          child: InkWell(
            onTap: () {
              Navigator.push(context, navigation);
            },
            // splashColor: Colors.green,
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 40.0,
                  width: 40,
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
                Text(
                  title,
                  style: new TextStyle(fontSize: 17.0),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
          ),
        ));
  }
}
