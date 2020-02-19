import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medkit/animations/fadeAnimation.dart';
import 'package:medkit/animations/listViewAnimation.dart';
import 'package:medkit/customWidgets/aboutUs.dart';
import 'package:medkit/doctor.dart';
import 'package:medkit/patient.dart';

class PersonCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text(
                "Exit Application",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: new Text("Are You Sure?"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new RaisedButton(
                  shape: StadiumBorder(),
                  color: Colors.white,
                  child: new Text(
                    "Close",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new RaisedButton(
                  shape: StadiumBorder(),
                  color: Colors.white,
                  child: new Text(
                    "Yes",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    exit(0);
                  },
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 40,
                  left: 30,
                  child: FadeAnimation(
                    0.3,
                    Row(
                      children: <Widget>[
                        Text(
                          'Category',
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                        SizedBox(
                          width: 150,
                        ),
                        GestureDetector(
                          onTap: () => _exitAlert(context),
                          child: Icon(
                            Icons.exit_to_app,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  )),
              Positioned(
                top: 180,
                left: 100,
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      0.4,
                      CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.2),
                        radius: 60,
                        child: Image(image: AssetImage("assets/doctor.png")),
                      ),
                    ),
                    WidgetAnimator(patDocBtn('Doctor', context)),
                    SizedBox(
                      height: 100,
                    ),
                    FadeAnimation(
                      0.4,
                      CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.2),
                        radius: 60,
                        child: Image(image: AssetImage("assets/patient.png")),
                      ),
                    ),
                    WidgetAnimator(patDocBtn('Patient', context)),
                    SizedBox(height: 70,),
                    GestureDetector(
                      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => AboutUs())),
                      child: Column(
                        children: <Widget>[
                          Text('Version', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('V 0.1', style: TextStyle(fontSize: 12),)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget patDocBtn(String categoryText, context) {
    return ButtonTheme(
      minWidth: 180,
      child: RaisedButton(
        onPressed: () {
          if (categoryText == 'Doctor') {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Doctor()));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Patient()));
          }
        },
        color: Colors.white,
        child: Text("I am " + categoryText),
        shape: StadiumBorder(),
      ),
    );
  }

  _exitAlert(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Exit Application",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: new Text("Are You Sure?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new RaisedButton(
              shape: StadiumBorder(),
              color: Colors.white,
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new RaisedButton(
              shape: StadiumBorder(),
              color: Colors.white,
              child: new Text(
                "Yes",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }
}
