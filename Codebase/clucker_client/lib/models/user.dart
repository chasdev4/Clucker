import 'package:flutter/widgets.dart';

class User {
  User(this.id, this.username, this.email, this.joined, this.clucks,
      this.comments);
  int id = -1;
  String username = '';
  String email = '';
  DateTime joined = DateTime.now();
  List<Widget> clucks = [];
  List<Widget> comments = [];

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    joined = json['joined'];
    clucks = json['clucks'];
    comments = json['comments'];
  }
}
