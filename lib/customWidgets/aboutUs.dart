import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 40,
            child: FlatButton(
                shape: StadiumBorder(),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.grey,
                )),
          ),
          Positioned(
              top: 120,
              left: 80,
              child: Text('About Us', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),)),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
            margin: EdgeInsets.fromLTRB(0, 610, 0, 30),
            alignment: Alignment.bottomCenter,
            height: 40,
            child: Column(
              children: <Widget>[
                Text(
                  'COMSATS University, Islamabad',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('@copyrights All Rights Reserved, 2020')
              ],
            ),
          )
        ],
      ),
    );
  }
}
