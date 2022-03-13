import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';

enum FollowButtonProfile { follow, followSmall, block }

class FollowButton extends StatefulWidget {
  const FollowButton({
    Key? key,
    required this.buttonProfile,
    required this.userId,
    this.onPressed,
  }) : super(key: key);

  final FollowButtonProfile buttonProfile;
  final int userId;
  final Function? onPressed;

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
          isNotFollowed()
              ? 'Follow'
              : isFollowed()
                  ? 'Unfollow'
                  : isNotBlocked()
                      ? 'Block'
                      : isBlocked()
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

            if (isFollowButton()) {
              // TODO: Follow / Unfollow
            } else if (isBlockButton()) {
              //TODO: Block / Unblock
            }

          });

          widget.onPressed!();
        },
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    );
  }

  bool isFollowButton() {
    return widget.buttonProfile == FollowButtonProfile.follow ||
        widget.buttonProfile ==
            FollowButtonProfile.followSmall;
  }

  bool isBlockButton() {
    return widget.buttonProfile == FollowButtonProfile.block;
  }

  bool isFollowed() {
    return isFollowButton() && isSecondary;
  }

  bool isNotFollowed() {
    return isFollowButton() && !isSecondary;
  }

  bool isBlocked() {
    return isBlockButton() && isSecondary;
  }

  bool isNotBlocked() {
    return isBlockButton() && !isSecondary;
  }
}
