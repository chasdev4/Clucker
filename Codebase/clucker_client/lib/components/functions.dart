import 'package:flutter/material.dart';

class Functions {

  void oneButtonDialog(BuildContext _context, String _title, String _body) {
    showDialog(
        context: _context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(_title),
          content: Text(_body),
          actions: <Widget> [
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        )
    );
  }

  void twoButtonDialog() {

  }
}