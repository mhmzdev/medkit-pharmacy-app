import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medkit/animations/topAnimation.dart';
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
    ProviderDoctorDetails providerInfo = new ProviderDoctorDetails(userDetails.providerId);

    List<ProviderDoctorDetails> providerData = new List<ProviderDoctorDetails>();
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

  static final phNumberTextController = TextEditingController();
  final phoneTextField = TextFormField(
    keyboardType: TextInputType.phone,
    autofocus: false,
    maxLength: 11,
    controller: phNumberTextController,
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

  static final nameTextFieldController = TextEditingController();
  final nameTextField = TextFormField(
    keyboardType: TextInputType.text,
    autofocus: false,
    maxLength: 30,
    controller: nameTextFieldController,
    decoration: InputDecoration(
        fillColor: Colors.black.withOpacity(0.07),
        filled: true,
        labelText: 'Enter Name',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(20)))),
  );

  static final cnicTextController = TextEditingController();
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
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              ImageAvatar(assetImage: 'assets/bigDoc.png',),
              Positioned(
                left: 20,
                bottom: 160,
                child: FadeAnimation(
                  2,
                  Text(
                    'You Will be asked Question regarding \nYour Qualifications!',
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 220),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: GoogleFonts.abel(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20,),
                    WidgetAnimator(nameTextField),
                    WidgetAnimator(phoneTextField),
                    WidgetAnimator(cnicTextField),
                    FadeAnimation(
                      1.5,
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                                height: 35,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Login',
                                style: TextStyle(
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BackBtn(),
            ],
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
