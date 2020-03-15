import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medkit/otherWidgetsAndScreen/backBtn.dart';
import 'package:medkit/patient/patientLogin.dart';


class PatientProfile extends StatelessWidget {
  PatientDetails doctorDetails;

  PatientProfile({this.doctorDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BackBtn(),
            SizedBox(height: MediaQuery.of(context).size.height/6,),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height/1.55,
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: 'patPic',
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(doctorDetails.photoUrl),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      doctorDetails.userName,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),SizedBox(height: 5,),
                    Text(doctorDetails.userEmail, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                    SizedBox(height: 20,),
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
                    SizedBox(height: MediaQuery.of(context).size.height/5.5,),
                    Text(
                      'Version',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('v 0.1'), SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          ],
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
          title: new Text(
            "Log Out",
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
