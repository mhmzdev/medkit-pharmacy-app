import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medkit/animations/fadeAnimation.dart';
import 'package:medkit/animations/listViewAnimation.dart';
import 'package:medkit/doctorPanel.dart';
import 'package:toast/toast.dart';

class Doctor extends StatefulWidget {
  @override
  _DoctorState createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
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
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails details = new UserDetails(
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

//  @override
//  void dispose() {
//    phNumberTextController.dispose();
//    cnicTextController.dispose();
//    nameTextFieldController.dispose();
//    super.dispose();
//  }

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
              iconContainer(),
              Container(
                margin: EdgeInsets.fromLTRB(30, 120, 0, 0),
                child: FadeAnimation(
                  0.3,
                  Text(
                    "Login",
                    style: GoogleFonts.abel(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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
                margin: EdgeInsets.fromLTRB(10, 0, 10, 280),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    WidgetAnimator(nameTextField),
                    WidgetAnimator(phoneTextField),
                    WidgetAnimator(cnicTextField)
                  ],
                ),
              ),
              Positioned(
                left: 10,
                bottom: 200,
                child: FadeAnimation(
                  1.5,
                  SizedBox(
                    width: 340,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/google.png'),
                            height: 40,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Login',
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
            ],
          )),
    );
  }

  Widget iconContainer() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Opacity(
        opacity: 0.25,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 30,
              right: -100,
              child: FadeAnimation(
                1,
                CircleAvatar(
                  radius: 160,
                  backgroundColor: Colors.black54,
                  child: Image(
                    image: AssetImage('assets/bigDoc.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);

  final String providerDetails;
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 300);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
