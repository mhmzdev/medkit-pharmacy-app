import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkit/animations/bottomAnimation.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';

import 'backBtn.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(String location) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$location';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

class MedDetails extends StatefulWidget {
  final DocumentSnapshot snapshot;
  final String doctorName;

  MedDetails({@required this.snapshot, this.doctorName});

  @override
  _MedDetailsState createState() => _MedDetailsState();
}

class _MedDetailsState extends State<MedDetails> {
  var location = new Location();
  var currentLocation = LocationData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 50,
              right: 30,
              child: Opacity(
                  opacity: 0.3,
                  child: WidgetAnimator(Row(
                    children: <Widget>[
                      Image(image: AssetImage('assets/pill.png')),
                      Image(image: AssetImage('assets/syrup.png')),
                      Image(image: AssetImage('assets/injection.png')),
                      Image(image: AssetImage('assets/tablets.png'))
                    ],
                  )))),
          BackBtn(),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.fromLTRB(0, 130, 0, 0),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    WidgetAnimator(
                      Text(
                        widget.snapshot.data['disName'],
                        style: GoogleFonts.abel(fontSize: 50),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Posted by: ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Dr. ' + widget.snapshot.data['post'],
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Medicine: ',
                          style: TextStyle(fontSize: 22),
                        ),
                        WidgetAnimator(
                          Text(
                            widget.snapshot.data['medName'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Dose: ',
                          style: TextStyle(fontSize: 22),
                        ),
                        WidgetAnimator(
                          Text(
                            widget.snapshot.data['medTime'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(8)),
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        children: <Widget>[
                          WidgetAnimator(
                            Text(
                              widget.snapshot.data['medDesc'],
                              style: TextStyle(height: 1.5, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'In case of worse condition, see a doctor as soon as possible!',
                      style: TextStyle(color: Colors.red),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          color: Colors.white,
                          shape: StadiumBorder(),
                          onPressed: () {
                            MapUtils.openMap('Pharmacy near me');
                          },
                          child: WidgetAnimator(
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage('assets/mapicon.png'),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Search Nearest Pharmacy',
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
