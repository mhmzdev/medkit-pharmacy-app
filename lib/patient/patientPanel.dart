import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medkit/animations/topAnimation.dart';
import 'package:medkit/otherWidgetsAndScreen/medDetails.dart';
import 'package:medkit/otherWidgetsAndScreen/customListTiles.dart';
import 'package:medkit/patient/patientLogin.dart';
import 'package:medkit/patient/patientProfile.dart';

import '../animations/bottomAnimation.dart';

class PatientPanel extends StatefulWidget {
  final PatientDetails detailsUser;

  PatientPanel({Key key, @required this.detailsUser}) : super(key: key);

  @override
  _PatientPanelState createState() => _PatientPanelState();
}

class _PatientPanelState extends State<PatientPanel> {
  int listIndex;

  Future getDiseaseInfo() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Diseases").getDocuments();
    return qn.documents;
  }

  final GoogleSignIn _gSignIn = GoogleSignIn();

  snapshotPassingToMedPage(DocumentSnapshot snapshot) {
    MedDetails(
      snapshot: snapshot,
    );
  }


  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
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
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                },
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            iconContainer(),
            SafeArea(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => PatientProfile(
                                    doctorDetails: widget.detailsUser,
                                  ))),
                      child: Hero(
                        tag: 'patPic',
                        child: CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.2),
                            backgroundImage:
                                NetworkImage(widget.detailsUser.photoUrl)),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.25,
                      height: 40,
                      child: WidgetAnimator(
                        TextFormField(
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                              labelText: 'Disease/Medicine',
                              prefixIcon: WidgetAnimator(Icon(
                                Icons.search,
                              )),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(110, 150, 0, 0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    FadeAnimation(
                      0.3,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Patient's",
                            style: GoogleFonts.abel(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '          Panel',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    )
                  ],
                )),
            FutureBuilder(
              future: getDiseaseInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: WidgetAnimator(
                      CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.fromLTRB(0, 260, 0, 0),
                    child: ListView.separated(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.transparent,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return WidgetAnimator(
                          CustomTile(
                            delBtn: false,
                            snapshot: snapshot.data[index],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget iconContainer() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 60,
            right: -20,
            child: FadeAnimation(
              1,
              Image(
                height: 155,
                image: AssetImage('assets/bigPat.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
