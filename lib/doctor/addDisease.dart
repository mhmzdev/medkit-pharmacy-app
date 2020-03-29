import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkit/animations/bottomAnimation.dart';
import 'package:medkit/otherWidgetsAndScreen/backBtnAndImage.dart';
import 'package:toast/toast.dart';


final controllerDisName = TextEditingController();
final controllerMedName = TextEditingController();
final controllerMedDose = TextEditingController();
final controllerDesc = TextEditingController();

class AddDisease extends StatefulWidget {
  final String doctorName;
  final String doctorEmail;
  AddDisease({this.doctorName, this.doctorEmail});

  @override
  _AddDiseaseState createState() => _AddDiseaseState();
}

class _AddDiseaseState extends State<AddDisease> {
  bool validDisName = false;
  bool validMedName = false;
  bool validMedDose = false;
  bool validDesc = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final disNameTF = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controllerDisName,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: WidgetAnimator(
              Image(
                image: AssetImage('assets/injection.png'),
                height: height * 0.04
              ),
            ),
          ),
          labelText: 'Disease Name',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final medNameTF = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controllerMedName,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: WidgetAnimator(
              Image(
                image: AssetImage('assets/tablets.png'),
                height: height * 0.04,
              ),
            ),
          ),
          labelText: 'Medicine Name',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final medTimeTF = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controllerMedDose,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: WidgetAnimator(
              Image(
                image: AssetImage('assets/pill.png'),
                height: height * 0.04,
              ),
            ),
          ),
          labelText: 'Medicine Dose',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final medDescTF = TextField(
      keyboardType: TextInputType.multiline,
      autofocus: false,
      controller: controllerDesc,
      maxLines: null,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: WidgetAnimator(
              Image(
                image: AssetImage('assets/steth.png'),
                height: height * 0.04,
              ),
            ),
          ),
          labelText: 'Description',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    controllerClear() {
      controllerDisName.clear();
      controllerMedName.clear();
      controllerMedDose.clear();
      controllerDesc.clear();
    }

    addingDisease () {
      Firestore.instance
          .collection('Diseases')
          .document(controllerDisName.text)
          .setData({
        'disName': controllerDisName.text,
        'medName': controllerMedName.text,
        'medTime': controllerMedDose.text,
        'medDesc': controllerDesc.text,
        'post' : widget.doctorName,
        'docEmail' : widget.doctorEmail
      });
      controllerClear();
      Toast.show('Added Successfully!', context,
         backgroundRadius: 5, backgroundColor: Colors.blue, duration: 3);
      Navigator.pop(context);
    }

    final addBtn = Container(
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          onPressed: () {
              setState(() {
                controllerDisName.text.isEmpty ? validDisName = true : validDisName = false;
                controllerMedName.text.isEmpty ? validMedName = true : validMedName = false;
                controllerMedDose.text.isEmpty ? validMedDose = true : validMedDose = false;
                controllerDesc.text.isEmpty ? validDesc = true : validDesc = false;
              });
              !validDisName & !validMedName & !validMedDose & !validDesc ? addingDisease() :
              Toast.show("Empty Field(s) Found!", context, backgroundColor: Colors.red, backgroundRadius: 5, duration: 2);
          },
          color: Colors.white,
          shape: StadiumBorder(),
          child: Text(
            'Add',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
        ));

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: width,
              margin: EdgeInsets.fromLTRB(width * 0.025, 0, width * 0.025, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BackBtn(),
                  SizedBox(height: height * 0.05),
                  Row(
                    children: <Widget>[
                      Text(
                        'Adding',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: height * 0.04),
                      ),
                      SizedBox(
                        width: height * 0.015
                      ),
                      Text(
                        'Disease',
                        style: GoogleFonts.abel(fontSize: height * 0.04)
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'Enter the Following Information',
                    style: GoogleFonts.abel(fontSize: height * 0.025),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  disNameTF,
                  SizedBox(
                    height: height * 0.015,
                  ),
                  medNameTF,
                  SizedBox(
                    height: height * 0.015,
                  ),
                  medTimeTF,
                  SizedBox(
                    height: height * 0.015,
                  ),
                  medDescTF,
                  SizedBox(
                    height: height * 0.02,
                  ),
                  addBtn,
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
