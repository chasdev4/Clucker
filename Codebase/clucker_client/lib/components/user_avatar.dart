import 'package:clucker_client/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'circle_crop.dart';

enum AvatarSize { small, medium, large }

class UserAvatar extends StatelessWidget {
  const UserAvatar(
      {Key? key,
        required this.hue,
        required this.userId,
        required this.username,
        required this.avatarSize,
        this.onProfile = false,
        this.avatarImage})
      : super(key: key);

  final double hue;
  final int userId;
  final String username;
  final AvatarSize avatarSize;
  final bool onProfile;
  final String? avatarImage;

  @override
  Widget build(BuildContext context) {
    late double size;
    late Color avatarForegroundColor;
    late Color avatarBackgroundColor;

    switch (avatarSize) {
      case AvatarSize.large:
        size = 130;
        break;
      case AvatarSize.medium:
        size = 75;
        break;
      case AvatarSize.small:
        size = 60;
        break;
    }

    avatarBackgroundColor =
        HSLColor.fromColor(const Color.fromARGB(255, 210, 210, 210))
            .withHue(hue)
            .withSaturation(0.5)
            .withLightness(0.88)
            .toColor();
    avatarForegroundColor =
        HSLColor.fromColor(const Color.fromARGB(255, 210, 210, 210))
            .withHue(hue)
            .withSaturation(0.62)
            .withLightness(0.5)
            .toColor();

    return Container(
      padding: const EdgeInsets.all(5),
      width: size,
      height: size,
      child: RawMaterialButton(
        onPressed: () {
          if (!onProfile) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(userId: userId, hue: hue, avatarImage: avatarImage,)),
            );
          }
        },
        child: avatarImage == null
            ? Stack(
                children: [
                  Positioned(
                      top: (size * -0.05),
                      left: (size * -0.008),
                      child: Icon(FontAwesomeIcons.solidCircle,
                          color: avatarBackgroundColor,
                          size: size + (size * 0.02) - 10)),
                  Positioned(
                      top: (size * -0.05),
                      left: (size * -0.008),
                      child: Icon(
                        FontAwesomeIcons.solidUserCircle,
                        color: avatarForegroundColor,
                        size: size + (size * 0.021) - 10,
                      )),
                ],
              )
            : ImageCircleCrop(image: avatarImage!),
      ),
    );
  }
}
