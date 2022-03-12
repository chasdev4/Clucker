import 'package:flutter/widgets.dart';

class User {
  User(this.id, this.username, this.email, this.bio, this.joined, this.clucks,
      this.comments, this.followerCount, this.followingCount, this.eggRating, this.hue);
  late int id;
  late String username;
  late String email;
  late  String bio;
  late DateTime joined;
  late List<Widget> clucks;
  late List<Widget> comments;
  late int followerCount;
  late int followingCount;
  late int eggRating;
  late double hue;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    bio = json['bio'];
    joined = json['joined'];
    clucks = json['clucks'];
    comments = json['comments'];
    followerCount = json['followerCount'];
    followingCount = json['followingCount'];
    eggRating = json['eggRating'];
    hue = json['hue'];
  }
}
