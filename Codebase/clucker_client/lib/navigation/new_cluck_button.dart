import 'package:flutter/material.dart';

class NewCluckButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add, size: 30,),
        elevation: 5,
        tooltip: 'New Cluck',
      ),
    );
  }

}