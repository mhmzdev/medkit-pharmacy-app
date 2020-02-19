import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class AddDisease extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final disNameTFController = TextEditingController();
    final medNameTFController = TextEditingController();
    final medTimeTFController = TextEditingController();
    final medDescTFController = TextEditingController();

    final disNameTF = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: disNameTFController,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image(
              image: AssetImage('assets/injection.png'),
              height: 30,
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
      controller: medNameTFController,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image(
              image: AssetImage('assets/tablets.png'),
              height: 30,
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
      controller: medTimeTFController,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image(
              image: AssetImage('assets/pill.png'),
              height: 30,
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
      controller: medDescTFController,
      maxLines: null,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image(
              image: AssetImage('assets/steth.png'),
              height: 30,
            ),
          ),
          labelText: 'Description',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    controllerClear() {
      disNameTFController.clear();
      medNameTFController.clear();
      medTimeTFController.clear();
      medDescTFController.clear();
    }

    final addBtn = Container(
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          onPressed: () {
            if (disNameTFController.text != '' &&
                medNameTFController.text != '' &&
                medTimeTFController.text != '' &&
                medDescTFController.text != '') {
              Firestore.instance
                  .collection('Diseases')
                  .document(disNameTFController.text)
                  .setData({
                'disName': disNameTFController.text,
                'medName': medNameTFController.text,
                'medTime': medTimeTFController.text,
                'medDesc': medDescTFController.text,
              });
              controllerClear();
              Toast.show('Added Successfully!', context,
                  backgroundColor: Colors.blue, duration: Toast.LENGTH_LONG);
              Navigator.pop(context);
            } else {
              Toast.show('Empty Field Found!', context,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  gravity: Toast.CENTER);
            }
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
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 60, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.black,
                    )),
                SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    Text(
                      'Adding',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Disease',
                      style: GoogleFonts.abel(fontSize: 30),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Enter the Following Information',
                  style: GoogleFonts.abel(fontSize: 22),
                ),
                SizedBox(
                  height: 15,
                ),
                disNameTF,
                SizedBox(
                  height: 12,
                ),
                medNameTF,
                SizedBox(
                  height: 12,
                ),
                medTimeTF,
                SizedBox(
                  height: 12,
                ),
                medDescTF,
                SizedBox(
                  height: 15,
                ),
                addBtn,
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
