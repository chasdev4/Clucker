import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  StandardButton(this.text, this.routeName, [this.isSecondary = false]);

  final String text;
  final String routeName;
  final bool isSecondary;

  final double width = 250;
  final double height = 50;
  late Color textColor;
  late Color buttonColor;
  late Color secondaryButtonColor;

  @override
  Widget build(BuildContext context) {
    textColor = (isSecondary == true) ? Colors.red : Colors.white;
    buttonColor = (isSecondary == false) ? Colors.red : Colors.white;
    secondaryButtonColor = Colors.white;
    return _ButtonFactory(text, routeName, isSecondary, width, height,
        textColor, buttonColor, secondaryButtonColor);
  }
}

class _ButtonFactory extends StatelessWidget {
  const _ButtonFactory(this.text, this.routeName, this.isSecondary, this.width,
      this.height, this.textColor, this.buttonColor, this.secondaryButtonColor);

  final String text;
  final String routeName;
  final bool isSecondary;
  final double width;
  final double height;
  final Color textColor;
  final Color buttonColor;
  final Color secondaryButtonColor;

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
      onPressed: () {},
    );

    return Container(
      child: button,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
    );
  }
}
