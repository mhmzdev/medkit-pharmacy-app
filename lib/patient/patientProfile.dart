import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medkit/otherWidgetsAndScreen/backBtnAndImage.dart';
import 'package:medkit/patient/patientLogin.dart';

class PatientProfile extends StatelessWidget {
  final PatientDetails doctorDetails;
  PatientProfile({this.doctorDetails});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BackBtn(),
              SizedBox(height: height * 0.05,),
              Center(
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: 'patPic',
                      child: CircleAvatar(
                        radius: height * 0.1,
                        backgroundImage: NetworkImage(doctorDetails.photoUrl),
                      ),
                    ),
                    SizedBox(height: height * 0.03,),
                    Text(
                      doctorDetails.userName,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),SizedBox(height: height * 0.007),
                    Text(doctorDetails.userEmail, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                    SizedBox(height: height * 0.02,),
                    RaisedButton.icon(
                        color: Colors.white,
                        onPressed: () {
                          _logOutAlertBox(context);
                        },
                        icon: Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                          size: height * 0.03,
                        ),
                        label: Text(
                          'Log Out',
                          style: TextStyle(color: Colors.red),
                        )),
                    SizedBox(height: height * 0.28),
                    Text(
                      'Version',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('v 0.1')
                  ],
                ),
              ),
            ],
          ),
        )
    );
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
