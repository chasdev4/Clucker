// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';

import 'circle_crop.dart';

class HeaderWithAvatar extends StatelessWidget with PreferredSizeWidget {
  HeaderWithAvatar(this.avatar);

  final String avatar;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      bottomOpacity: 0.0,
      elevation: 0.0,
      title: Text(
        ' ' + avatar,
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        Transform.scale(
          scale: 1.3,
          origin: Offset(66, 0),
          child: IconButton(
            icon: const ImageCircleCrop(image: 'assets/icons/avatar_256x256.png'),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
