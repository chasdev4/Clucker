import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox(this.text, [this.isObscuredText = false]);

  final String text;
  final bool isObscuredText;

  @override
  Widget build(BuildContext context) {
    return _TextBoxFactory(text, isObscuredText);
  }
}

class _TextBoxFactory extends StatelessWidget {
  const _TextBoxFactory(this.text, this.isObscuredText);

  final String text;
  final bool isObscuredText;

  @override
  Widget build(BuildContext context) {
    const exampleGrey = Color.fromARGB(255, 205, 205, 205);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
      child: TextField(
        obscureText: isObscuredText,
        cursorColor: const Color.fromARGB(255, 100, 100, 100),
        cursorWidth: 1.1,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: exampleGrey, width: 1.3),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: exampleGrey,
              width: 1,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(3, 3))),
          hintText: text,
          hintStyle: const TextStyle(
            color: exampleGrey,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
