import 'package:clucker_client/models/user.dart';
import 'package:clucker_client/services/user_service.dart';

class Cluck {
  Cluck(this.id, this.body, this.username, this.posted, this.eggRating);

  late String id;
  late String body;
  late String username;
  //late int userId:
  late DateTime posted;
  late int eggRating = 0;
  final UserService userService = UserService();

  Cluck.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    body = json['body'];
    username = json['author'];
    posted = DateTime.parse(json['posted']);
    if(json['eggRating'] == null) {
      eggRating = 0;
    } else {
      eggRating = json['eggRating'];
    }
  }
}
