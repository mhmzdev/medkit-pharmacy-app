import 'package:flutter/material.dart';

import '../personCategory.dart';

class WelcomeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
        height: 200,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 0), blurRadius: 5)
            ]),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 80,
              top: 20,
              child: Text(
                'Welcome!',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Center(
              child: Text(
                'Proceed Further for help!',
                style:
                    TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
              ),
            ),
            Positioned(
                bottom: 20,
                left: 50,
                child:
                ButtonTheme(
                  minWidth: 200,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.black54,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonCategory()));
                    },
                    shape: StadiumBorder(),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'PROCEED',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                )
                )
          ],
        ),
      ),
    );
  }
}
