import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: height * 0.025),
                width: width * 0.72,
                child: Opacity(
                    opacity: 0.3,
                    child: WidgetAnimator(Row(
                      children: <Widget>[
                        Image(image: AssetImage('assets/pill.png')),
                        Image(image: AssetImage('assets/syrup.png')),
                        Image(image: AssetImage('assets/injection.png')),
                        Image(image: AssetImage('assets/tablets.png'))
                      ],
                    ))),
              ),
            ),
            BackBtn(),
            Container(
                width: width,
                height: height,
                margin: EdgeInsets.fromLTRB(
                    width * 0.025, height * 0.17, width * 0.025, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    WidgetAnimator(
                      Text(
                        widget.snapshot.data['disName'],
                        style: GoogleFonts.abel(
                            fontSize: ScreenUtil.instance.setSp(50)),
                      ),
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
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.instance.setHeight(10),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Medicine: ',
                          style: TextStyle(
                              fontSize: ScreenUtil.instance.setSp(25)),
                        ),
                        WidgetAnimator(
                          Text(
                            widget.snapshot.data['medName'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil.instance.setSp(25)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.instance.setHeight(12),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Dose: ',
                          style: TextStyle(
                              fontSize: ScreenUtil.instance.setSp(25)),
                        ),
                        WidgetAnimator(
                          Text(
                            widget.snapshot.data['medTime'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenUtil.instance.setSp(25)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil.instance.setHeight(12),
                    ),
                    Container(
                      width: width,
                      height: height * 0.3,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(8)),
                      child: ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil.instance.setWidth(5.0)),
                        children: <Widget>[
                          WidgetAnimator(
                            Text(
                              widget.snapshot.data['medDesc'],
                              style: TextStyle(
                                  height: 1.5,
                                  fontSize: ScreenUtil.instance.setSp(17)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.warning, size: height * 0.02, color: Colors.red,),
                        SizedBox(width:  width * 0.02,),
                        Text(
                          'See a Doctor if condition gets Worse!',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0, ScreenUtil.instance.setHeight(10), 0, 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil.instance.setWidth(10),
                              horizontal: ScreenUtil.instance.setHeight(15)),
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
                                SizedBox(width: ScreenUtil.instance.setWidth(5)),
                                Text(
                                  'Search Nearest Pharmacy',
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil.instance.setSp(18)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
