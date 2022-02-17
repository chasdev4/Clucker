import 'package:flutter/material.dart';

class ImageCircleCrop extends StatelessWidget {

  final String image;

  const ImageCircleCrop({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage(image),
        ),
      ),
    );
  }
}
