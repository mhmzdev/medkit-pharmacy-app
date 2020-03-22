import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medkit/animations/fadeAnimation.dart';
import 'package:medkit/animations/bottomAnimation.dart';
import 'package:medkit/doctor/doctorPanel.dart';
import 'package:medkit/otherWidgetsAndScreen/backBtn.dart';
import 'package:medkit/otherWidgetsAndScreen/imageAvatar.dart';
import 'package:toast/toast.dart';

class DoctorLogin extends StatefulWidget {
  @override
  _DoctorLoginState createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    FirebaseUser userDetails =
        await _firebaseAuth.signInWithCredential(credential);
    ProviderDoctorDetails providerInfo =
        new ProviderDoctorDetails(userDetails.providerId);

    List<ProviderDoctorDetails> providerData =
        new List<ProviderDoctorDetails>();
    providerData.add(providerInfo);

    DoctorDetails details = new DoctorDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => DoctorPanel(
                  detailsUser: details,
                )));

    return userDetails;
  }

  @override
  Widget build(BuildContext context) {

    final nameTextFieldController = TextEditingController();
    final nameTextField = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      maxLength: 30,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: nameTextFieldController,
      decoration: InputDecoration(
          fillColor: Colors.black.withOpacity(0.07),
          filled: true,
          labelText: 'Enter Name',
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(20)))),
    );

    final phNumberTextController = TextEditingController();
    final phoneTextField = TextField(
      keyboardType: TextInputType.phone,
      autofocus: false,
      maxLength: 11,
      controller: phNumberTextController,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black.withOpacity(0.07),
        labelText: 'Enter Number',
        prefixIcon: Icon(Icons.phone),
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(20)),
        ),
      ),
    );

    final cnicTextController = TextEditingController();
    final cnicTextField = TextFormField(
      keyboardType: TextInputType.number,
      autofocus: false,
      maxLength: 13,
      controller: cnicTextController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black.withOpacity(0.07),
          labelText: 'Enter CNIC',
          prefixIcon: Icon(Icons.card_membership),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                ImageAvatar(
                  assetImage: 'assets/bigDoc.png',
                ),
                Container(
                  width: width,
                  height: height,
                  margin: EdgeInsets.fromLTRB(width * 0.03, 0, width * 0.03, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      BackBtn(),
                      SizedBox(height: height * 0.05,),
                      Text(
                        "\t\tLogin",
                        style: GoogleFonts.abel(
                            fontSize: ScreenUtil.instance.setSp(35),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      WidgetAnimator(nameTextField),
                      WidgetAnimator(phoneTextField),
                      WidgetAnimator(cnicTextField),
                      SizedBox(height: height * 0.01,),
                      FadeAnimation(
                        1.5,
                        SizedBox(
                          width: width,
                          height: height * 0.07,
                          child: RaisedButton(
                            color: Colors.white,
                            shape: StadiumBorder(),
                            onPressed: () {
                              if (nameTextFieldController.text != "" ||
                                  phNumberTextController.text != "" ||
                                  cnicTextController.text != "") {
                                Firestore.instance
                                    .collection('doctorInfo')
                                    .document(nameTextFieldController.text)
                                    .setData({
                                  'cnic': cnicTextController.text,
                                  'phoneNumber': phNumberTextController.text,
                                });
                                _signIn(context)
                                    .then((FirebaseUser user) =>
                                        print('Gmail Logged In'))
                                    .catchError((e) => print(e));
                                nameTextFieldController.clear();
                                cnicTextController.clear();
                                phNumberTextController.clear();
                              } else {
                                Toast.show('Fields Cannot be Empty!', context,
                                    backgroundColor: Colors.red,
                                    gravity: Toast.CENTER,
                                    duration: Toast.LENGTH_SHORT);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  image: AssetImage('assets/google.png'),
                                  height: ScreenUtil.instance.setHeight(35),
                                ),
                                SizedBox(width: ScreenUtil.instance.setWidth(15)),
                                Text(
                                  'Login',
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
                      SizedBox(height: height * 0.02,),
                      FadeAnimation(
                        2,
                        Text(
                          'You Will be asked Question regarding your Qualifications!', textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black.withOpacity(0.5),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class DoctorDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDoctorDetails> providerData;

  DoctorDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderDoctorDetails {
  ProviderDoctorDetails(this.providerDetails);

  final String providerDetails;
}
