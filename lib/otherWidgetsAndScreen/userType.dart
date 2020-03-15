import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medkit/animations/topAnimation.dart';
import 'package:medkit/animations/bottomAnimation.dart';
import 'package:medkit/doctor/doctorLogin.dart';
import 'package:medkit/patient/patientLogin.dart';
import 'package:medkit/patient/patientPanel.dart';

import 'aboutUs.dart';

class UserType extends StatelessWidget {
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
              Container(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                width: MediaQuery.of(context).size.width,
                child: FadeAnimation(
                  0.3,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Category',
                        style: TextStyle(color: Colors.black, fontSize: 30),
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
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                    ),
                    SizedBox(height: 5,)
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
            Navigator.pushNamed(context, 'DoctorLogin');
          } else {
            Navigator.pushNamed(context, 'PatientLogin');
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
