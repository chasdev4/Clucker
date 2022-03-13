import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';

class Div extends StatelessWidget {
  const Div({Key? key, this.isHeader = false}) : super(key: key);

  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isHeader
          ? Palette.lightGrey.toMaterialColor().shade400
          : Palette.cluckerRed,
      height: 2.5,
      width: MediaQuery.of(context).size.width - 15 * 2,
    );
  }
}