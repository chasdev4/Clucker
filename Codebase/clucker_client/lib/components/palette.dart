import 'package:flutter/material.dart';

class _PaletteColor extends Color{
  _PaletteColor.fromARGB(this.a, this.r, this.g, this.b) : super.fromARGB(a, r, g, b);

  final int a;
  final int r;
  final int g;
  final int b;

  int argbToHex() {
    return int.parse(
        '0x${a.toRadixString(16)}${r.toRadixString(16)}${g.toRadixString(16)}${b.toRadixString(16)}');
  }

  MaterialColor toMaterialColor() {
    Map<int, Color> colorCodes = {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1),
    };

    return MaterialColor(argbToHex(), colorCodes);
  }
  
}

class Palette {

  // Header Dividers, Hyperlinks, Active Icons, Active Toggle Button, Solid Button Background.
// (Default Theme) Secondary Button Border and Secondary Button Text
  static _PaletteColor cluckerRed = _PaletteColor.fromARGB(255, 255, 87, 87);

  // Plus and minus overlay
  static _PaletteColor cluckerRedLight = _PaletteColor.fromARGB(255, 255, 187, 187);

// (Both) Solid Button Text
// (Default Theme) Background, Text Field Background
// (Dark Mode) Text, Inactive Icon, Inactive Text, Secondary Button Text
  static _PaletteColor white = _PaletteColor.fromARGB(255, 255, 255, 255);

// (Default Theme) Hint text, text box border
    static _PaletteColor lightGrey = _PaletteColor.fromARGB(255, 205, 205, 205);

//#region Default Theme

// Text, Inactive Icon, Inactive Text
  static _PaletteColor black = _PaletteColor.fromARGB(255, 0, 0, 0);
  
 // Inactive Navigation icon
  static _PaletteColor offBlack = _PaletteColor.fromARGB(255, 75, 75, 75);

// Standard Dividers, Inactive Toggle Button, Button Widget (on click)
  static _PaletteColor mercuryGray = _PaletteColor.fromARGB(255, 230, 230, 230);

// Comments and Settings Background Color
  static _PaletteColor porcelain = _PaletteColor.fromARGB(255, 242, 242, 242);

//#endregion
}