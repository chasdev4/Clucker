import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'circle_crop.dart';

class UserAvatar extends StatelessWidget {

  final String? avatarImage;

  const UserAvatar({Key? key, this.avatarImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => {
        // Implement this
      },
      icon: avatarImage == null ?
            const Icon(FontAwesomeIcons.solidUserCircle) :
            ImageCircleCrop(image: avatarImage!),
      iconSize: 40,
    );
  }

}
