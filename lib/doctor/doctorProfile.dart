import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medkit/animations/bottomAnimation.dart';
import 'package:medkit/doctor/doctorLogin.dart';
import 'package:medkit/otherWidgetsAndScreen/backBtnAndImage.dart';
import 'package:toast/toast.dart';

final controllerBio = TextEditingController();
final controllerPhone = TextEditingController();
final controllerSpec = TextEditingController();

class DoctorProfile extends StatefulWidget {
  final DoctorDetails doctorDetails;

  DoctorProfile({this.doctorDetails});

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  bool aboutCheck = false;
  bool validInfo = true;

  validatePhone(String phone) {
    if(!(phone.length == 11) && phone.isNotEmpty) {
      return "Invalid Phone Number Length";
    }
    return null;
  }

  profileUpdate() {
    Firestore.instance
        .collection('docAbout')
        .document(
        widget.doctorDetails.userEmail)
        .setData(
        {'about': controllerBio.text,
        'phone' : controllerPhone.text,
        'spec' : controllerSpec.text});
    Toast.show('Profile Updated!', context, backgroundColor: Colors.blue, backgroundRadius: 5,
        duration: 2);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final bio = TextField(
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.done,
      autofocus: false,
      maxLines: 6,
      maxLength: 200,
      controller: controllerBio,
      decoration: InputDecoration(
        hintText: 'Tell us more about yourself.',
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );

    final phone = TextField(
      keyboardType: TextInputType.phone,
      autofocus: false,
      maxLength: 11,
      controller: controllerPhone,
      decoration:  InputDecoration (
          hintText: 'Enter Phone',
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );

    final specialization = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controllerSpec,
        decoration:  InputDecoration (
          hintText: 'Your Specialization',
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.red)),
        )
    );

    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BackBtn(),
              Center(
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: 'docPic',
                      child: CircleAvatar(
                        radius: height * 0.05,
                        backgroundImage:
                            NetworkImage(widget.doctorDetails.photoUrl),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Text(
                      'Dr. ' + widget.doctorDetails.userName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(height: height * 0.007),
                    Text(
                      "Email: " + widget.doctorDetails.userEmail,
                      style: TextStyle(
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.w300,
                          color: Colors.black54),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Container(
                      width: width * 0.7,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "About:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.02),
                              ),
                              Container(
                                height: height * 0.032,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    !aboutCheck ? FloatingActionButton(
                                      shape: CircleBorder(),
                                        backgroundColor: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            aboutCheck = !aboutCheck;
                                          });
                                        },
                                        child: WidgetAnimator(
                                          Icon(
                                            Icons.edit,
                                            size: height * 0.02,
                                            color: Colors.black,
                                          ),
                                        )) : Container(),
                                    aboutCheck ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        FloatingActionButton(
                                          backgroundColor: Colors.green,
                                          onPressed: () {
                                            setState(() {
                                              controllerPhone.text.isEmpty ? validInfo = false : validInfo = true;
                                              if (validInfo == true) {
                                                aboutCheck = !aboutCheck;
                                              }
                                            });
                                            !aboutCheck ? profileUpdate() :
                                            Toast.show('Empty Field Found!', context, backgroundColor: Colors.red, backgroundRadius: 5, duration: 3);
                                          },
                                          child: WidgetAnimator(
                                            Icon(
                                              Icons.done,
                                              size: height * 0.025,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        FloatingActionButton(
                                          backgroundColor: Colors.white,
                                          onPressed: (){
                                            setState(() {
                                              aboutCheck = !aboutCheck;
                                            });
                                          },
                                          child: WidgetAnimator(
                                            Icon(Icons.close, size: height * 0.025,
                                              color: Colors.red,),
                                          ),
                                        ),
                                      ],
                                    ) : Container()
                                  ],
                                )
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          !aboutCheck
                              ? StreamBuilder(
                                  stream: Firestore.instance.document('docAbout/${widget.doctorDetails.userEmail}').snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        height: height * 0.21,
                                        width: width * 0.7,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black12),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                          ),
                                        ),
                                      );
                                    }
                                    var docAbout = snapshot.data;
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.01,
                                            vertical: height * 0.01),
                                        height: height * 0.21,
                                        width: width * 0.7,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black12),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: ListView(
                                          children: <Widget>[
                                            Text(
                                              docAbout['about'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500, fontSize: height * 0.019),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  )
                              : bio,
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.01,),
                    Container(
                      width: width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Mobile No:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: height * 0.02),
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          !aboutCheck
                              ? StreamBuilder(
                              stream: Firestore.instance.document('docAbout/${widget.doctorDetails.userEmail}').snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    height: height * 0.041,
                                    width: width * 0.7,
                                    decoration: BoxDecoration(
                                      border:
                                      Border.all(color: Colors.black12),
                                      borderRadius:
                                      BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                      ),
                                    ),
                                  );
                                }
                                var docAbout = snapshot.data;
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.01,
                                      vertical: height * 0.01),
                                  height: height * 0.041,
                                  width: width * 0.7,
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: Colors.black12),
                                    borderRadius:
                                    BorderRadius.circular(5),
                                  ),
                                  child: ListView(
                                    children: <Widget>[
                                      Text(
                                        docAbout['phone'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500, fontSize: height * 0.019),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          )
                              : phone,
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.01,),
                    Container(
                      width: width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Specialization:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: height * 0.02),
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          !aboutCheck
                              ? StreamBuilder(
                              stream: Firestore.instance.document('docAbout/${widget.doctorDetails.userEmail}').snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    height: height * 0.05,
                                    width: width * 0.7,
                                    decoration: BoxDecoration(
                                      border:
                                      Border.all(color: Colors.black12),
                                      borderRadius:
                                      BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                      ),
                                    ),
                                  );
                                }
                                var docAbout = snapshot.data;
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.01,
                                      vertical: height * 0.01),
                                  height: height * 0.05,
                                  width: width * 0.7,
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: Colors.black12),
                                    borderRadius:
                                    BorderRadius.circular(5),
                                  ),
                                  child: ListView(
                                    children: <Widget>[
                                      Text(
                                        docAbout['spec'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500, fontSize: height * 0.019),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          )
                              : specialization,
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.01,),
                    RaisedButton.icon(
                        color: Colors.white,
                        onPressed: () {
                          _logOutAlertBox(context);
                        },
                        icon: Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                          size: height * 0.03,
                        ),
                        label: Text(
                          'Log Out',
                          style: TextStyle(color: Colors.red),
                        )),
                    SizedBox(height: height * 0.02),
                    Text(
                      'Version',
                      style: TextStyle(
                          fontSize: height * 0.017,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45),
                    ),
                    Text(
                      'v 0.1',
                      style: TextStyle(
                          fontSize: height * 0.016, color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  final GoogleSignIn _gSignIn = GoogleSignIn();

  void _logOutAlertBox(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: new Text(
            "Are you Sure?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text("You are about to Log Out!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              color: Colors.white,
              child: Text(
                "Close",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              color: Colors.white,
              child: Text(
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
