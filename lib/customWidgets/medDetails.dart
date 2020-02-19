import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkit/animations/listViewAnimation.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';

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

  MedDetails({this.snapshot});

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
                  child: WidgetAnimator(
                      Row(
                        children: <Widget>[
                          Image(image: AssetImage('assets/pill.png')),
                          Image(image: AssetImage('assets/syrup.png')),
                          Image(image: AssetImage('assets/injection.png')),
                          Image(image: AssetImage('assets/tablets.png'))
                        ],
                      )))),
          Positioned(
            top: 40,
            child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.black,
                )),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(30, 130, 0, 0),
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
                    height: 50,
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
                    width: 320,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(8)),
                    child: WidgetAnimator(
                      Text(
                        widget.snapshot.data['medDesc'],
                        style: TextStyle(height: 1.5, fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text('In case of worse condition, see a doctor as soon as possible!', style: TextStyle(color: Colors.red),)
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: SizedBox(
                width: 340,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  color: Colors.white,
                  shape: StadiumBorder(),
                  onLongPress: () {
                    Toast.show('Press to Open Google Maps', context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.CENTER,
                        backgroundColor: Colors.green);
                  },
                  onPressed: () {
                    MapUtils.openMap('Pharmacy near me');
                  },
                  child: WidgetAnimator(
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/mapicon.png'),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Search Nearest Pharmacy',
                          style: TextStyle(
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
