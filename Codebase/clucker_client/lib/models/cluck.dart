import 'package:clucker_client/models/user.dart';

class Cluck {
  Cluck(this.id, this.body, this.author, this.posted, this.eggRating);

  late int id;
  late String body;
  late User author;
  late DateTime posted;
  late int eggRating;

  Cluck.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    author = json['author'];
    posted = json['posted'];
    eggRating = json['eggRating'];
  }
}
