import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';

enum FollowButtonProfile { follow, followSmall, block }

class FollowButton extends StatefulWidget {
  const FollowButton({
    Key? key,
    required this.buttonProfile,
    required this.onPress,
  }) : super(key: key);

  final FollowButtonProfile buttonProfile;
  final Function onPress;

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isSecondary = false;

  @override
  Widget build(BuildContext context) {
    Color textColor =
        (isSecondary == true) ? Palette.cluckerRed : Palette.white;
    Color buttonColor =
        (isSecondary == false) ? Palette.cluckerRed : Palette.white;

    const Size buttonSize = Size(100, 42);

    return Padding(
      child: ElevatedButton(
        child: Text(
          ((widget.buttonProfile == FollowButtonProfile.follow ||
                      widget.buttonProfile ==
                          FollowButtonProfile.followSmall) &&
                  isSecondary == false)
              ? 'Follow'
              : ((widget.buttonProfile == FollowButtonProfile.follow ||
                          widget.buttonProfile ==
                              FollowButtonProfile.followSmall) &&
                      isSecondary == true)
                  ? 'Unfollow'
                  : widget.buttonProfile == FollowButtonProfile.block &&
                          isSecondary == false
                      ? 'Block'
                      : widget.buttonProfile == FollowButtonProfile.block &&
                              isSecondary == true
                          ? 'Unblock'
                          : 'Text...',
          style: TextStyle(
              color: textColor, fontSize: 15, fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: widget.buttonProfile == FollowButtonProfile.follow
              ? Size(buttonSize.width * 1.2, buttonSize.height * 1.1)
              : buttonSize,
          primary: buttonColor,
          side: (isSecondary == true)
              ? BorderSide(
                  color: textColor, width: 2.5, style: BorderStyle.solid)
              : const BorderSide(style: BorderStyle.none),
        ),
        onPressed: () {
          setState(() {
            isSecondary = !isSecondary;
          });

          widget.onPress();
        },
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    );
    ;
  }
}
