// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:clucker_client/components/palette.dart';

class TextBox extends StatelessWidget {
  const TextBox(this.text, [this.isObscuredText = false]);

  final String text;
  final bool isObscuredText;

  @override
  Widget build(BuildContext context) {
    _TextBoxPackager packager = _TextBoxPackager(text, false, isObscuredText);
    return _TextBoxFactory(packager.buildPackage());
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _TextBoxPackager packager = _TextBoxPackager('Search', true, false);
    return _TextBoxFactory(packager.buildPackage());
  }
}

class _TextBoxPackager {
  final String text;
  final bool isSearchField;
  final bool isObscuredText;

  _TextBoxPackager(this.text, this.isSearchField, this.isObscuredText);

  List<Widget> buildPackage() {
    var package = <Widget>[];

    package.add(_TextBoxBuilder(text, isSearchField, isObscuredText));

    if (isSearchField == true) {
      package.add(
        IconButton(
          icon: const ImageIcon(
            AssetImage('assets/icons/search_icon_256x256.png'),
            color: black,
            size: 22,
          ),
          onPressed: () {
            // do something
          },
        )
      );
    }

    return package;
  }
}

class _TextBoxFactory extends StatelessWidget {
  const _TextBoxFactory(this.package);

  final List<Widget> package;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
      child: Stack(
        alignment: Alignment.centerRight,
        children: package
      ),
    );
  }
}

class _TextBoxBuilder extends StatelessWidget {
  const _TextBoxBuilder(this.text, this.isSearchField, this.isObscuredText);

  final String text;
  final bool isSearchField;
  final bool isObscuredText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscuredText,
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
        hintText: text,
        hintStyle: const TextStyle(
          color: lightGrey,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
