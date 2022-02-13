// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';

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
            icon: const CircleCrop('assets/icons/avatar_256x256.png'),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class CircleCrop extends StatelessWidget {
  const CircleCrop(this.image);

  final String image;

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