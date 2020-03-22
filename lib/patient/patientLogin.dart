import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medkit/animations/bottomAnimation.dart';
import 'package:medkit/animations/fadeAnimation.dart';
import 'package:medkit/doctor/doctorLogin.dart';
import 'package:medkit/otherWidgetsAndScreen/backBtn.dart';
import 'package:medkit/otherWidgetsAndScreen/imageAvatar.dart';
import 'package:medkit/patient/patientPanel.dart';

class PatientLogin extends StatelessWidget {
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

    PatientDetails details = new PatientDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => PatientPanel(
                  detailsUser: details,
                )));

    return userDetails;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            BackBtn(),
            ImageAvatar(
              assetImage: 'assets/bigPat.png',
            ),
            Container(
              width: width,
              height: height,
              margin: EdgeInsets.fromLTRB(
                  width * 0.05, height * 0.1, width * 0.05, 0),
              child: FadeAnimation(
                1.5,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: GoogleFonts.abel(
                          fontSize: ScreenUtil.instance.setSp(35),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Text(
                      'Features',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '1. Details about different Diseases/Medicines'
                      '\n2. Add your favorite Doctors'
                      '\n3. Request to add Disease/Medicine'
                      '\n4. Report incorrect Disease/Medicine'
                      '\n5. Search for Nearest Pharmacy'
                      '\n6. Feeback/Complains',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          height: ScreenUtil.instance.setHeight(1.5)),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    FadeAnimation(
                      2,
                      RaisedButton(
                        padding:
                            EdgeInsets.all(ScreenUtil.instance.setHeight(10)),
                        color: Colors.white,
                        shape: StadiumBorder(),
                        onPressed: () {
                          _signIn(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/google.png'),
                              height: ScreenUtil.instance.setHeight(35),
                            ),
                            SizedBox(width: width * 0.02),
                            Text(
                              'Login Using Gmail',
                              style: TextStyle(
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenUtil.instance.setSp(17)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: height * 0.15),
                width: width,
                height: height * 0.07,
                child: WidgetAnimator(
                  Text(
                    '"The Job You are Struggling for will replace \nYou within a week if you found dead.'
                    '\nTake care of yourself!"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.3),
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PatientDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDoctorDetails> providerData;

  PatientDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderPatientDetails {
  ProviderPatientDetails(this.providerDetails);

  final String providerDetails;
}
