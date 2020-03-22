import 'package:flutter/material.dart';
import 'package:medkit/animations/fadeAnimation.dart';

class ImageAvatar extends StatelessWidget {
  final String assetImage;

  ImageAvatar({@required this.assetImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: MediaQuery.of(context).size.height * 0.05,
          left: MediaQuery.of(context).size.width - 250,
          child: Opacity(
            opacity: 0.25,
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
        ),
      ],
    );
  }
}
