import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'circle_crop.dart';

enum AvatarSize { small, medium, large }

class UserAvatar extends StatefulWidget {
  final AvatarSize avatarSize;
  final String username;
  final String? avatarImage;

  const UserAvatar(
      {Key? key,
      required this.avatarSize,
      required this.username,
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
        onPressed: () {},
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
    double hue = 0;
    double foregroundSaturation = 0.678;
    double foregroundLightness = 0.4;
    double backgroundSaturation = 0.5;
    double backgroundLightness = 0.88;

    if (widget.username.codeUnitAt(3) >= 48 &&
        widget.username.codeUnitAt(3) <= 57) {
      hue = (110 - widget.username.codeUnitAt(3)) * 5.7;
      foregroundSaturation = 0.7;
      foregroundLightness = 0.5;
    } else if (widget.username.codeUnitAt(3) >= 65 &&
        widget.username.codeUnitAt(3) <= 77) {
      hue = (78 - widget.username.codeUnitAt(3)) * 27.5;
    } else if (widget.username.codeUnitAt(3) >= 78 &&
        widget.username.codeUnitAt(3) <= 90) {
      hue = (91 - widget.username.codeUnitAt(3)) * 27.5;
      foregroundSaturation = 0.77;
      foregroundLightness = 0.33;
    } else if (widget.username.codeUnitAt(3) >= 95 &&
        widget.username.codeUnitAt(3) <= 109) {
      hue = (110 - widget.username.codeUnitAt(3)) * 24;
    } else if (widget.username.codeUnitAt(3) >= 110 &&
        widget.username.codeUnitAt(3) <= 122) {
      hue = (123 - widget.username.codeUnitAt(3)) * 27.5;
      foregroundLightness = 0.5;
      foregroundSaturation = 0.5;
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
