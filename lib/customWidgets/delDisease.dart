import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkit/animations/listViewAnimation.dart';
import 'package:toast/toast.dart';

class DelDisease extends StatelessWidget {
  final DocumentSnapshot snapshot;

  DelDisease({this.snapshot});

  static final disNameTFController = TextEditingController();
  final disNameToDeleteTextField = TextField(
    keyboardType: TextInputType.text,
    controller: disNameTFController,
    autofocus: false,
    decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        labelText: 'Enter Disease Name',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(const Radius.circular(15)))),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 30,
              right: -70,
              child: WidgetAnimator(
                Opacity(
                    opacity: 0.2,
                    child: Icon(
                      Icons.cancel,
                      color: Colors.redAccent,
                      size: 250,
                    )),
              ),
            ),
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
            Positioned(
              top: 130,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Deleting',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                  ),
                  Text(
                    snapshot.data['disName'],
                    style: GoogleFonts.abel(fontSize: 25),
                  )
                ],
              ),
            ),
            Container(
                height: 170,
                margin: EdgeInsets.fromLTRB(10, 250, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.warning,
                          color: Colors.red,
                        ),
                        Text(
                          '  Name Entered here is Case Sensitive',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    disNameToDeleteTextField,
                    Container(
                      width: 340,
                      height: 45,
                      child: FlatButton(
                        shape: StadiumBorder(),
                        color: Colors.redAccent.withOpacity(0.2),
                        onPressed: () {
                          if (disNameTFController.text == snapshot.data['disName'] &&
                              disNameTFController.text != "") {
                            Firestore.instance
                                .collection('Diseases')
                                .document(snapshot.data['disName'])
                                .delete();
                            disNameTFController.clear();
                            Toast.show('Deleted Successfully!', context, textColor: Colors.white, backgroundColor: Colors.blue);
                            Navigator.pop(context);
                          } else {
                            Toast.show('Name Mismatch!', context,
                                backgroundColor: Colors.deepOrange,
                                gravity: Toast.CENTER);
                          }
                        },
                        child: Text(
                          'Confirm Delete',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
