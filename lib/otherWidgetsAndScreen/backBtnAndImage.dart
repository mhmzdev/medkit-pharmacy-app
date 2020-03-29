import 'package:flutter/material.dart';
import 'package:medkit/animations/fadeAnimation.dart';

//This is the back button being used on almost every screen
class BackBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          0, MediaQuery.of(context).size.height * 0.1, 0, 0),
      child: FlatButton(
          shape: CircleBorder(),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: MediaQuery.of(context).size.height * 0.045,
          )),
    );
  }
}

//this is the big image at patient and doctor login screen
class ImageAvatar extends StatelessWidget {
  final String assetImage;

  ImageAvatar({@required this.assetImage});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Positioned(
          top: height * 0.05,
          left: width - 250,
          child: Opacity(
            opacity: 0.25,
            child: CircleAvatar(
              radius: height * 0.2,
              backgroundColor: Colors.black54,
              child: Image(
                image: AssetImage(assetImage),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
