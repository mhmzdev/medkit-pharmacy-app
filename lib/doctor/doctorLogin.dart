import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medkit/animations/fadeAnimation.dart';
import 'package:medkit/animations/bottomAnimation.dart';
import 'package:medkit/doctor/doctorPanel.dart';
import 'package:medkit/otherWidgetsAndScreen/backBtnAndImage.dart';
import 'package:toast/toast.dart';

class DoctorLogin extends StatefulWidget {
  @override
  _DoctorLoginState createState() => _DoctorLoginState();
}

final _controllerName = TextEditingController();
final _controllerPhone = TextEditingController();
final _controllerCNIC = TextEditingController();

class _DoctorLoginState extends State<DoctorLogin> {

  //bool validatePhoneVar = false;
  bool validateCNICVar = false;
  bool validateName = false;


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

  controllerClear(){
    _controllerName.clear();
    _controllerPhone.clear();
    _controllerCNIC.clear();
  }

  validatePhone (String phone) {
    if(!(phone.length == 11) && phone.isNotEmpty){
      return "Invalid Phone Number length";
    }
    return null;
  }

  validateCNIC(String idNumber) {
    if(!(idNumber.length == 13) && idNumber.isNotEmpty) {
      return "CNIC must be of 13-Digits";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final nameTextField = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      maxLength: 30,
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      controller: _controllerName,
      decoration: InputDecoration(
          fillColor: Colors.black.withOpacity(0.07),
          filled: true,
          labelText: 'Enter Name',
          prefixIcon: WidgetAnimator(Icon(Icons.person)),
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(20)))),
    );

    final cnicTextField = TextField(
      keyboardType: TextInputType.number,
      autofocus: false,
      maxLength: 13,
      controller: _controllerCNIC,
      onSubmitted: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
          filled: true,
          errorText: validateCNIC(_controllerCNIC.text),
          fillColor: Colors.black.withOpacity(0.07),
          labelText: 'NIC Number',
          prefixIcon: WidgetAnimator(Icon(Icons.credit_card)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );

    getInfoAndLogin() {
      Firestore.instance
          .collection('doctorInfo')
          .document(_controllerName.text)
          .setData({
        'cnic': _controllerCNIC.text,
      });
      _signIn(context)
          .then((FirebaseUser user) =>
          print('Gmail Logged In'))
          .catchError((e) => print(e));
      controllerClear();
    }

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
            child: Container(
              width: width,
              height: height,
              child: Stack(
                children: <Widget>[
                  BackBtn(),
                  ImageAvatar(
                    assetImage: 'assets/bigDoc.png',
                  ),
                  Container(
                    width: width,
                    height: height,
                    margin:
                        EdgeInsets.fromLTRB(width * 0.03, 0, width * 0.03, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Text(
                          "\t\tLogin",
                          style: GoogleFonts.abel(
                              fontSize: height * 0.044,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        nameTextField,
                        //phoneTextField,
                        cnicTextField,
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SizedBox(
                          width: width,
                          height: height * 0.07,
                          child: RaisedButton(
                            color: Colors.white,
                            shape: StadiumBorder(),
                            onPressed: ()  {
                              setState(() {
                                _controllerCNIC.text.isEmpty ? validateCNICVar = true
                                : validateCNICVar = false;
                                _controllerName.text.isEmpty ? validateName = true
                                : validateName = false;
                              });
                                !validateName & !validateCNICVar ? getInfoAndLogin() :
                                    Toast.show("Empty Field(s) Found!", context, backgroundColor: Colors.red, backgroundRadius: 5, duration: Toast.LENGTH_LONG);

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                WidgetAnimator(
                                  Image(
                                    image: AssetImage('assets/google.png'),
                                    height: height * 0.035,
                                  ),
                                ),
                                SizedBox(width: height * 0.015),
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: height * 0.022),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        WidgetAnimator(
                          Text(
                            'You Will be asked Question regarding your Qualifications!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.2,)
                      ],
                    ),
                  ),
                ],
              ),
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
