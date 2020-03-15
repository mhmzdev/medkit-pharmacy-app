import 'package:flutter/material.dart';
import 'package:medkit/otherWidgetsAndScreen/backBtn.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackBtn(),
          Container(
            margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
              alignment: Alignment.topCenter,
              child: Text('About Us', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),)),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage('assets/medkit.png')),
                Text(
                  "MEDKIT",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Version",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Alpha 0.1"),
                SizedBox(
                  height: 30,
                ),
                Text("Developed By"),
                Text(
                  'Muhammad Hamza',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Email'),
                Text('hamza.6.shakeel@gmail.com',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'COMSATS University, Islamabad',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('@Copyrights All Rights Reserved, 2020')
              ],
            ),
          )
        ],
      ),
    );
  }
}
