class Cluck {
  Cluck(this.id, this.body, this.username, this.posted, this.eggRating);

  late String id;
  late String body;
  late String username;
  int userId = 0;
  late DateTime posted;
  late int eggRating = 0;

  Cluck.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    body = json['body'];
    username = json['author'];
    // userId: json['authorId'];
    posted = DateTime.parse(json['posted']);
    if(json['eggRating'] == null) {
      eggRating = 0;
    } else {
      eggRating = json['eggRating'];
    }
  }
}
