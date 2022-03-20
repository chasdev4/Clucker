import 'package:clucker_client/screens/profile_page.dart';
import 'package:clucker_client/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'circle_crop.dart';

enum AvatarSize { small, smallMedium, medium, large }

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
    SizeConfig().init(context);
    late double size;
    late Color avatarForegroundColor;
    late Color avatarBackgroundColor;

    switch (avatarSize) {
      case AvatarSize.large:
        size = SizeConfig.blockSizeHorizontal * 30.6;
        break;
      case AvatarSize.medium:
        size = SizeConfig.blockSizeHorizontal * 18.6;
        break;
      case AvatarSize.smallMedium:
        size = SizeConfig.blockSizeHorizontal * 16.8;
        break;
      case AvatarSize.small:
        size = SizeConfig.blockSizeHorizontal * 14.6;
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
                  builder: (context) => ProfilePage(userId: userId, hue: hue, avatarImage: avatarImage!,)),
            );
          }
        },
        child: avatarImage == ''
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
