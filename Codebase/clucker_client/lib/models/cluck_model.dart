class CluckModel {
  CluckModel(this.id, this.body, this.username, this.userId, this.posted,
     // this.commentCount,
  this.eggRating);

  late String id;
  late String body;
  late DateTime posted;
  late int userId;
  late String username;
  //late int commentCount;
  late int eggRating;

  CluckModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    body = json['body'];
    username = json['author'];
    userId = json['authorId'];
    posted = DateTime.parse(json['posted']);
    if (json['eggRating'] == null) {
      eggRating = 0;
    } else {
      eggRating = json['eggRating'];
    }
  }
}
