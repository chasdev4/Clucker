// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:clucker_client/components/palette.dart';

class TextBox extends StatelessWidget {
  const TextBox(this.hintText, [this.obscureText = false]);

  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    _TextBoxPackager packager =
        _TextBoxPackager(hintText, false, false, obscureText);
    return _TextBoxFactory(packager.buildPackage(), 50);
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _TextBoxPackager packager = _TextBoxPackager('Search', true, false, false);
    return _TextBoxFactory(packager.buildPackage(), 10);
  }
}

class CluckBox extends StatelessWidget {
  const CluckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _TextBoxPackager packager = _TextBoxPackager('Cluck', false, true, false);
    return _TextBoxFactory(packager.buildPackage(), 25);
  }
}

class _TextField extends StatefulWidget {
  _TextField({Key? key}) : super(key: key);
  late String hintText;
  late bool isSearchField;
  late bool isCluckField;
  late bool isObscuredText;

  int counter = 0;

  int setValues(String hintText, bool isSearchField, bool isCluckField,
      bool isObscuredText) {
    this.hintText = hintText;
    this.isSearchField = isSearchField;
    this.isCluckField = isCluckField;
    this.isObscuredText = isObscuredText;

    return counter;
  }

  void setCounter(int counter) {
    this.counter = counter;
  }

  @override
  _TextFieldState createState() => _TextFieldState();
}

class _TextFieldState extends State<_TextField> {

  String enteredText = '';
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isObscuredText,
      cursorColor: const Color.fromARGB(255, 100, 100, 100),
      cursorWidth: 1.1,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: lightGrey, width: 1.3),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: lightGrey,
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(3, 3))),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: lightGrey,
          fontWeight: FontWeight.w400,
        ),
      ),

      onChanged: (value) {
        setState(() {
          enteredText = value;
          counter = 0;
          for (int i = 0; i < enteredText.length; i++) {
            if (enteredText[i] == ' ') {
              counter++;
              widget.setCounter(counter);
            }
          }
        });
      },
    );
  }
}

class _TextBoxPackager {
  final String hintText;
  final bool isSearchField;
  final bool isCluckField;
  final bool isObscuredText;

  _TextBoxPackager(this.hintText, this.isSearchField, this.isCluckField,
      this.isObscuredText);

  List<Widget> buildPackage() {
    _TextField textField = _TextField();
    int counter = textField.setValues(hintText, isSearchField, isCluckField, isObscuredText);

    var package = <Widget>[];

    package.add(textField);

    if (isSearchField == true) {
      package.add(IconButton(
        icon: const ImageIcon(
          AssetImage('assets/icons/search_icon_256x256.png'),
          color: black,
          size: 22,
        ),
        onPressed: () {
          // do something
        },
      ));

      if (isCluckField == true) {
        package.add(Text(
          '$counter/6  ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 22,
          ),
        ));
      }
    }

    return package;
  }
}

class _TextBoxFactory extends StatelessWidget {
  const _TextBoxFactory(this.package, this.horizontalPadding);

  final List<Widget> package;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 6),
      child: Stack(alignment: Alignment.centerRight, children: package),
    );
  }
}
