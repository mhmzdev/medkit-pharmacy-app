import 'package:flutter/material.dart';
import 'package:medkit/otherWidgetsAndScreen/backBtn.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BackBtn(),
            SizedBox(height: height * 0.02,),
            Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'About Us',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  ),SizedBox(height: height * 0.05,),
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
                    height: height * 0.05,
                  ),
                  Text("Developed By"),
                  Text(
                    'Muhammad Hamza',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text('Email'),
                  Text('hamza.6.shakeel@gmail.com',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: height * 0.2,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'COMSATS University, Islamabad',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('@Copyrights All Rights Reserved, 2020')
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
