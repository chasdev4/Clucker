import 'package:clucker_client/models/user.dart';
import 'package:clucker_client/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'circle_crop.dart';

enum AvatarSize { small, medium, large }

class UserAvatar extends StatefulWidget {
  final User user;
  final AvatarSize avatarSize;
  final bool onProfile;
  final String? avatarImage;

  const UserAvatar(
      {Key? key,
        required this.user,
      required this.avatarSize,
        this.onProfile = false,
      this.avatarImage})
      : super(key: key);

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  late double size;
  late Color avatarForegroundColor;
  late Color avatarBackgroundColor;

  @override
  void initState() {
    super.initState();
    initSizes();
    setAvatarColor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: size,
      height: size,
      child: RawMaterialButton(
        onPressed: () {
          if (!widget.onProfile) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(user: widget.user)),
            );
          }
        },
        child: widget.avatarImage == null
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
            : ImageCircleCrop(image: widget.avatarImage!),
      ),
    );
  }

  void setAvatarColor() {

    avatarBackgroundColor =
        HSLColor.fromColor(const Color.fromARGB(255, 210, 210, 210))
            .withHue(widget.user.hue)
            .withSaturation(0.5)
            .withLightness(0.88)
            .toColor();
    avatarForegroundColor =
        HSLColor.fromColor(const Color.fromARGB(255, 210, 210, 210))
            .withHue(widget.user.hue)
            .withSaturation(0.62)
            .withLightness(0.5)
            .toColor();
  }

  void initSizes() {
    switch (widget.avatarSize) {
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
  }
}
