import 'package:clucker_client/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'circle_crop.dart';

enum AvatarSize { small, medium, large }

class UserAvatar extends StatefulWidget {
  final AvatarSize avatarSize;
  final String username;
  final bool onProfile;
  final String? avatarImage;

  const UserAvatar(
      {Key? key,
      required this.avatarSize,
      required this.username,
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
      padding: EdgeInsets.all(5),
      width: size,
      height: size,
      child: RawMaterialButton(
        onPressed: () {
          if (!widget.onProfile) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(username: widget.username)),
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
    int index = 3;
    double hue = 0;
    double foregroundSaturation = 0.62;
    double foregroundLightness = 0.5;
    double backgroundSaturation = 0.5;
    double backgroundLightness = 0.88;

    if (widget.username.codeUnitAt(index) >= 48 &&
        widget.username.codeUnitAt(index) <= 57) {
      hue = (58 - widget.username.codeUnitAt(3)) * 30;
    } else if (widget.username.codeUnitAt(index) >= 65 &&
        widget.username.codeUnitAt(index) <= 77) {
      hue = (78 - widget.username.codeUnitAt(index)) * 27.5;
    } else if (widget.username.codeUnitAt(index) >= 78 &&
        widget.username.codeUnitAt(index) <= 90) {
      hue = (91 - widget.username.codeUnitAt(index)) * 27.5;
    } else if (widget.username.codeUnitAt(index) >= 95 &&
        widget.username.codeUnitAt(index) <= 109) {
      hue = (110 - widget.username.codeUnitAt(index)) * 24;
    } else if (widget.username.codeUnitAt(index) >= 110 &&
        widget.username.codeUnitAt(index) <= 122) {
      hue = (123 - widget.username.codeUnitAt(index)) * 27.5;
    }

    if (widget.username[index] == '7' ||
        widget.username[index] == '8' ||
        widget.username[index] == 'x' ||
        widget.username[index] == 'X' ||
        widget.username[index] == 'y' ||
        widget.username[index] == 'Y' ||
        widget.username[index] == 'l' ||
        widget.username[index] == 'L' ||
        widget.username[index] == 'k' ||
        widget.username[index] == 'K') {
      hue = hue - 45;
    }
    Color backgroundColor =
        HSLColor.fromColor(const Color.fromARGB(255, 210, 210, 210))
            .withHue(hue)
            .withSaturation(backgroundSaturation)
            .withLightness(backgroundLightness)
            .toColor();
    Color foregroundColor =
        HSLColor.fromColor(const Color.fromARGB(255, 210, 210, 210))
            .withHue(hue)
            .withSaturation(foregroundSaturation)
            .withLightness(foregroundLightness)
            .toColor();

    avatarForegroundColor = foregroundColor;
    avatarBackgroundColor = backgroundColor;
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
