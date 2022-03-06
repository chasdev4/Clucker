import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'circle_crop.dart';
class UserAvatar extends StatelessWidget {

  final String? avatarImage;
  final double size;
  const UserAvatar({Key? key, this.avatarImage = 'assets/icons/chicken.jpg', this.size = 70}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size, height: size,
      child: IconButton(
        onPressed: () => {
          // Implement this
        },
        icon: avatarImage == null ?
        const Icon(FontAwesomeIcons.solidUserCircle) :
        ImageCircleCrop(image: avatarImage!),
        iconSize: 40,
        color: Colors.black,
      ),
    );
  }
}