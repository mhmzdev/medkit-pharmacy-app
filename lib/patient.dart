import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkit/animations/fadeAnimation.dart';
import 'package:medkit/customWidgets/customListTiles.dart';
import 'package:medkit/customWidgets/medDetails.dart';

import 'animations/listViewAnimation.dart';

class Patient extends StatefulWidget {
  @override
  _PatientState createState() => _PatientState();
}

class _PatientState extends State<Patient> {
  Future getDiseaseInfo() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Diseases").getDocuments();
    return qn.documents;
  }

  snapshotPassingtoMedPage(DocumentSnapshot snapshot) {
    MedDetails(
      snapshot: snapshot,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            iconContainer(),
            Positioned(
              top: 50,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 15,),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.black,
                      )),
                  SizedBox(width: 10,),
                  Container(
                    width: 285,
                    height: 50,
                    child: WidgetAnimator(
                      TextFormField(
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          labelText: 'Search Disease/Medicine',
                          prefixIcon: WidgetAnimator( Icon(Icons.search,)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)
                          )
                        ),
                      ),
                    ),
                  ),
                ],
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
                            style: GoogleFonts.abel(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text('          Panel', style: TextStyle(fontSize: 18),)
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
                    margin: EdgeInsets.fromLTRB(0, 250, 0, 0),
                    child: ListView.separated(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
        ));
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

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 300);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
