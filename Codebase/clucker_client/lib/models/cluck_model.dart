class CluckModel {
  CluckModel(this.cluckId, this.body, this.username, this.posted, this.eggRating);

  late String cluckId;
  late String body;
  late String username;
  int userId = 0;
  late DateTime posted;
  int commentCount = 0;
  late int eggRating = 0;

  CluckModel.fromJson(Map<dynamic, dynamic> json) {
    cluckId = json['id'];
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
