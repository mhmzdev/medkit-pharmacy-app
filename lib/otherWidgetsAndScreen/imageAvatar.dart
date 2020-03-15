import 'package:flutter/material.dart';
import 'package:medkit/animations/topAnimation.dart';

class ImageAvatar extends StatelessWidget {
  final String assetImage;

  ImageAvatar({@required this.assetImage});

  @override
  Widget build(BuildContext context) {
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
                    image: AssetImage(assetImage),
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
