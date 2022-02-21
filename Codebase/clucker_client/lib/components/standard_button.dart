import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {

  final String text;
  final String routeName;
  final Function onPress;
  final bool isSecondary;

  final double width = 250;
  final double height = 50;

  const StandardButton({Key? key, required this.text,
    required this.routeName, required this.onPress, this.isSecondary = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textColor = (isSecondary == true) ? Colors.red : Colors.white;
    var buttonColor = (isSecondary == false) ? Colors.red : Colors.white;
    return _ButtonFactory(text, routeName, onPress, isSecondary, width, height,
        textColor, buttonColor);
  }
}

class _ButtonFactory extends StatelessWidget {
  const _ButtonFactory(this.text, this.routeName, this.onPress, this.isSecondary, this.width,
      this.height, this.textColor, this.buttonColor);

  final String text;
  final String routeName;
  final Function onPress;
  final bool isSecondary;
  final double width;
  final double height;
  final Color textColor;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    ElevatedButton button = ElevatedButton(
      child: Text(
        text,
        style: TextStyle(
            color: textColor, fontSize: 15, fontWeight: FontWeight.w500),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height),
        primary: buttonColor,
        side: (isSecondary == true)
            ? BorderSide(color: textColor, width: 2.5, style: BorderStyle.solid)
            : const BorderSide(style: BorderStyle.none),
      ),
      onPressed: () {
        onPress();
      },
    );

    return Container(
      child: button,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
    );
  }
}
