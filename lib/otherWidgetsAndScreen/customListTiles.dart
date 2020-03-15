import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkit/doctor/delDisease.dart';
import 'package:medkit/otherWidgetsAndScreen/medDetails.dart';
import 'package:medkit/doctor/doctorPanel.dart';

import '../doctor/delDisease.dart';

class CustomTile extends StatefulWidget {
  final bool delBtn;
  final DocumentSnapshot snapshot;

  CustomTile({this.delBtn, this.snapshot});

  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  tileNumber(int num) {
    if (num % 2 == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => MedDetails(
                      snapshot: widget.snapshot,
                    )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: new LinearGradient(colors: [
            Colors.white.withOpacity(0.8),
            !widget.delBtn
                ? Colors.blueGrey.withOpacity(0.2)
                : Colors.redAccent.withOpacity(0.2),
          ]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.snapshot.data['disName'],
              style: GoogleFonts.lato(fontSize: 25, letterSpacing: 2),
            ),
            Container(
              height: 35,
              child: FlatButton(
                onPressed: () {
                  widget.delBtn
                      ? Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => DelDisease(
                                    snapshot: widget.snapshot,
                                  )))
                      : Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => MedDetails(
                                    snapshot: widget.snapshot,
                                  )));
                },
                shape: StadiumBorder(),
                child: widget.delBtn
                    ? Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      )
                    : Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 20,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
