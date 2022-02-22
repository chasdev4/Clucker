import 'package:flutter/material.dart';

enum StandardButtonProfile { standard, save, cancel, revert }

enum FollowButtonProfile { standard, small, block }

class StandardButton extends StatelessWidget {
  const StandardButton(
      {Key? key,
      required this.text,
      required this.routeName,
      required this.onPress,
      this.isSecondary = false,
      this.standardButtonProfile = StandardButtonProfile.standard})
      : super(key: key);

  final String text;
  final String routeName;
  final Function onPress;
  final bool isSecondary;
  final StandardButtonProfile standardButtonProfile;

  @override
  Widget build(BuildContext context) {
    double horizontalPadding =
        (standardButtonProfile == StandardButtonProfile.standard) ? 50 : 6;

    Color textColor = (isSecondary == true) ? Colors.red : Colors.white;
    Color buttonColor = (isSecondary == false) ? Colors.red : Colors.white;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        width: horizontalPadding,
      ),
      Expanded(
        child: ElevatedButton(
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: 15, fontWeight: FontWeight.w500),
          ),
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            side: (isSecondary == true)
                ? BorderSide(
                    color: textColor, width: 2.5, style: BorderStyle.solid)
                : const BorderSide(style: BorderStyle.none),
          ),
          onPressed: () {
            onPress();
          },
        ),
      ),
      SizedBox(
        width: horizontalPadding,
      ),
    ]);
  }
}

// class FollowButton extends StatefulWidget {
//   const FollowButton({Key? key}) : super(key: key);
//
//   final String text;
//   final String routeName;
//   final Function onPress;
//   final bool isSecondary;
//   final Color textColor;
//   final Color buttonColor;
//
//   final double width = 250;
//   final double height = 50;
//
//   @override
//   _FollowButtonState createState() => _FollowButtonState();
// }
//
// class _FollowButtonState extends State<FollowButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       child: ElevatedButton(
//         child: Text(
//           text,
//           style: TextStyle(
//               color: textColor, fontSize: 15, fontWeight: FontWeight.w500),
//         ),
//         style: ElevatedButton.styleFrom(
//           fixedSize: Size(width, height),
//           primary: buttonColor,
//           side: (isSecondary == true)
//               ? BorderSide(color: textColor, width: 2.5, style: BorderStyle.solid)
//               : const BorderSide(style: BorderStyle.none),
//         ),
//         onPressed: () {
//           onPress();
//         },
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: horizontalPadding),
//     );;
//   }
// }
