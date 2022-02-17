// ignore_for_file: use_key_in_widget_constructors
import 'package:clucker_client/components/divider.dart';
import 'package:flutter/material.dart';

class HeaderWithAvatar extends StatelessWidget with PreferredSizeWidget {
  HeaderWithAvatar(this.titleText);

  final String titleText;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return _HeaderFactory(titleText, true);
  }
}

class HeaderWithoutAvatar extends StatelessWidget with PreferredSizeWidget {
  HeaderWithoutAvatar(this.titleText);

  final String titleText;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return _HeaderFactory(titleText, false);
  }
}

class HeaderCentered extends StatelessWidget with PreferredSizeWidget {
  HeaderCentered(this.titleText);

  final String titleText;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return _HeaderFactory(titleText, false, true);
  }
}


class _HeaderFactory extends StatelessWidget {
  _HeaderFactory(this.titleText, this.withAvatar, [this.isCentered = false]);

  final String titleText;
  final bool withAvatar;
  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AppBar(
            backgroundColor: Colors.transparent,
            bottomOpacity: 0.0,
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              ' ' + titleText,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            actions: (withAvatar == false) ? [const SizedBox()] : [const AvatarButton(),],
          ),
        ),
        const HeaderDivider(),
      ],
    );
  }
}


class AvatarButton extends StatelessWidget {
  const AvatarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.3,
      origin: Offset(66, 0),
      child: IconButton(
        icon: const CircleCrop('assets/icons/avatar_256x256.png'),
        onPressed: () {},
      ),
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
