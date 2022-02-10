import 'package:flutter/material.dart';

class StandardDivider extends StatelessWidget {
  const StandardDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DividerFactory();
  }
}

class HeaderDivider extends StatelessWidget {
  const HeaderDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DividerFactory(true);
  }
}


class _DividerFactory extends StatelessWidget {
   _DividerFactory([this.isHeaderStyle = false]);

  final bool isHeaderStyle;

  @override
  Widget build(BuildContext context) {
    // TODO: Use colors from color palette class, Colors will vary on dark mode too!
    Color divColor = (isHeaderStyle == true) ? Colors.red : Colors.grey;

    return Divider(
      color: divColor,
      height: 6,
      thickness: 2,
      indent: 20,
      endIndent: 20,
    );
  }
}