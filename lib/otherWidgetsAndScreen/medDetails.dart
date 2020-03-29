import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkit/animations/bottomAnimation.dart';
import 'package:medkit/otherWidgetsAndScreen/doctorAbout.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'backBtnAndImage.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: height * 0.02),
                width: width * 0.75,
                child: Opacity(
                    opacity: 0.3,
                    child: Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/pill.png'),
                          height: height * 0.1,
                        ),
                        Image(
                          image: AssetImage('assets/syrup.png'),
                          height: height * 0.1,
                        ),
                        Image(
                          image: AssetImage('assets/tablets.png'),
                          height: height * 0.07,
                        ),
                        Image(
                          image: AssetImage('assets/injection.png'),
                          height: height * 0.07,
                        )
                      ],
                    )),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BackBtn(),
                Container(
                    width: width,
                    margin:
                        EdgeInsets.fromLTRB(width * 0.025, 0, width * 0.025, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.snapshot.data['disName'],
                              style: GoogleFonts.abel(fontSize: height * 0.06),
                            ),
                            RaisedButton(
                              color: Colors.blue,
                              shape: CircleBorder(),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorAbout(
                                  docEmail: widget.snapshot.data['docEmail'],
                                  docName: widget.snapshot.data['post'],
                                )));
                              },
                              child: Icon(Icons.info, color: Colors.white, size: height * 0.05,),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
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
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Medicine: ',
                              style: TextStyle(fontSize: height * 0.03),
                            ),
                            WidgetAnimator(
                              Text(
                                widget.snapshot.data['medName'],
                                style: GoogleFonts.averageSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.03),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Dose: ',
                              style: TextStyle(fontSize: height * 0.03),
                            ),
                            WidgetAnimator(
                              Text(
                                widget.snapshot.data['medTime'],
                                style: GoogleFonts.averageSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.03),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                          width: width,
                          height: height * 0.3,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(8)),
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            children: <Widget>[
                              Text(
                                widget.snapshot.data['medDesc'],
                                style: TextStyle(height: 1.5, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        WidgetAnimator(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.warning,
                                size: height * 0.02,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                'See a Doctor if condition gets Worse!',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                          child: SizedBox(
                            width: width,
                            height: height * 0.075,
                            child: RaisedButton(
                              color: Colors.white,
                              shape: StadiumBorder(),
                              onPressed: () {
                                MapUtils.openMap('Pharmacy near me');
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    WidgetAnimator(Image.asset(
                                      'assets/mapicon.png',
                                      height: height * 0.045,
                                    )),
                                    SizedBox(width: width * 0.01),
                                    Text(
                                      'Search Nearest Pharmacy',
                                      style: TextStyle(
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.bold,
                                          fontSize: height * 0.021),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
