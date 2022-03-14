import 'package:clucker_client/models/user_model.dart';

class CluckModel {
   CluckModel(this.id, this.body, this.author, this.posted, this.eggRating);

  int? id;
  String? body;
  UserModel? author;
  DateTime? posted;
  int? eggRating;


  CluckModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    author = json['author'];
    posted = json['posted'];
    eggRating = json['eggRating'];

  }
}