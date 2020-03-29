import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorAbout extends StatelessWidget {
  final String docEmail;
  final String docName;

  DoctorAbout({this.docEmail, this.docName});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("Doctor's Information"),),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            StreamBuilder(
              stream: Firestore.instance
                  .collection('docAbout')
                  .document(docEmail)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    width: width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                var docAbout = snapshot.data;
                return Container(
                  padding: EdgeInsets.all(width * 0.015),
                  width: width,
                  height: height * 0.7,
                  margin:
                      EdgeInsets.only(left: width * 0.05, top: height * 0.05  , right: width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Dr. " + docName,
                        style: TextStyle(fontSize: height * 0.04, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height * 0.03,),
                      Row(
                        children: <Widget>[
                          Icon(Icons.stars, size: height * 0.03, color: Colors.red,),SizedBox(width: width * 0.02,),
                          Text(
                            docAbout['spec'],
                            style: GoogleFonts.abel(fontSize: height * 0.025),
                          )
                        ],
                      ),
                      SizedBox(height: height * 0.01,),
                      Row(
                        children: <Widget>[
                          Icon(Icons.phone, size: height * 0.03, color: Colors.blue),
                          SizedBox(width: width * 0.02,),
                          Text(
                            docAbout['phone'],
                            style: GoogleFonts.abel(fontSize: height * 0.025),
                          )
                        ],
                      ),
                      SizedBox(height: height * 0.01,),
                      Row(
                        children: <Widget>[
                          Icon(Icons.email, size: height * 0.03, color: Colors.green),SizedBox(width: width * 0.02,),
                          Text(
                            docEmail,
                            style: GoogleFonts.abel(fontSize: height * 0.025),
                          )
                        ],
                      ),
                      SizedBox(height: height * 0.02,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'About: ',
                            style: TextStyle(
                                fontSize: height * 0.025,
                                fontWeight: FontWeight.bold),
                          ),SizedBox(height: height * 0.01,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black38)
                            ),
                            padding: EdgeInsets.all(5),
                            height: height * 0.3,
                            width: width,
                            child: ListView(
                              children: <Widget>[
                                Text(
                                  docAbout['about'],
                                  style: GoogleFonts.abel(fontSize: height * 0.025),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
