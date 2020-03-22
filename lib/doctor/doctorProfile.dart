import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medkit/doctor/doctorLogin.dart';
import 'package:medkit/otherWidgetsAndScreen/backBtn.dart';

class DoctorProfile extends StatelessWidget {
  DoctorDetails doctorDetails;
  DoctorProfile({this.doctorDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BackBtn(),
          SizedBox(height: ScreenUtil.instance.setHeight(50),),
          Center(
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'docPic',
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        NetworkImage(doctorDetails.photoUrl),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil.instance.setHeight(25),
                ),
                Text(
                  'Dr. ' + doctorDetails.userName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil.instance.setSp(24)),
                ),
                SizedBox(
                  height: ScreenUtil.instance.setHeight(7),
                ),
                Text(
                  doctorDetails.userEmail,
                  style: TextStyle(
                      fontSize: ScreenUtil.instance.setSp(16),
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: ScreenUtil.instance.setHeight(20),
                ),
                RaisedButton.icon(
                    color: Colors.white,
                    onPressed: () {
                      _logOutAlertBox(context);
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                    label: Text(
                      'Log Out',
                      style: TextStyle(color: Colors.red),
                    )),
                SizedBox(
                  height: ScreenUtil.instance.setHeight(190),
                ),
                Text(
                  'Version',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('v 0.1'),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  final GoogleSignIn _gSignIn = GoogleSignIn();

  void _logOutAlertBox(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          title: new Text(
            "Are you Sure?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text("You are about to Log Out!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              color: Colors.white,
              child: Text(
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
                "Log Out",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                _gSignIn.signOut();
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 3);
              },
            ),
          ],
        );
      },
    );
  }
}
