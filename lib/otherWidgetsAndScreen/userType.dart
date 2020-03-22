import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medkit/animations/fadeAnimation.dart';
import 'package:medkit/animations/bottomAnimation.dart';

class UserType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              title: new Text(
                "Exit Application",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: new Text("Are You Sure?"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                 FlatButton(
                  color: Colors.white,
                  child:  Text(
                    "Close",
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  color: Colors.white,
                  child: Text(
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
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
            height: height,
            width: width,
            child: Column(
              children: <Widget>[
                SizedBox(height:  height * 0.08,),
                FadeAnimation(
                  0.3,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Category',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil.instance.setSp(35)),
                      ),
                      GestureDetector(
                        onTap: () => _exitAlert(context),
                        child: Icon(
                          Icons.exit_to_app,
                          size: height * 0.045,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: height * 0.08,),
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
                  height: height * 0.1,
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
                SizedBox(
                  height: height * 0.12,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'AboutUs'),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Version',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'V 0.1',
                        style: TextStyle(
                            fontSize: ScreenUtil.instance.setSp(12)),
                      )
                    ],
                  ),
                )
              ],
            ),
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
