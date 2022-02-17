import 'package:clucker_client/components/palette.dart';
import 'package:flutter/material.dart';

class CluckerAppBar extends StatelessWidget with PreferredSizeWidget {

  final String title;
  final TextStyle titleStyle;
  final double padding;
  final bool? noDivider;
  final List<Widget> actions;
  final double height;

  const CluckerAppBar({Key? key,
    required this.title,
    this.noDivider = false,
    this.padding = 15,
    this.titleStyle = const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Colors.black,
    ),
    this.actions = const [],
    this.height = 80
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      toolbarHeight: height,

      elevation: 0,
      bottomOpacity: noDivider == true ? 0 : 1,
      bottom: PreferredSize(
          child: Container(
            color: Palette.cluckerRed,
            height: 2.5,
            width: MediaQuery
                .of(context)
                .size
                .width - padding * 2,
          ),
          preferredSize: const Size.fromHeight(2.5)
      ),
      title: Text(
            title,
            style: titleStyle
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

}
