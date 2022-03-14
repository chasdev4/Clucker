import 'package:flutter/widgets.dart';

class UserModel {
  UserModel(this.id, this.username, this.email, this.joined, this.clucks,
      this.comments);
  int? id;
  String? username;
  String? email;
  DateTime? joined;
  List<Widget>? clucks;
  List<Widget>? comments;
  int? eggRating;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    joined = json['joined'];
    clucks = json['clucks'];
    comments = json['comments'];
    eggRating = json['eggRating'];
  }
}
