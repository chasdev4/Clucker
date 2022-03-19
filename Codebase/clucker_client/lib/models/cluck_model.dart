class CluckModel {
  CluckModel(
      this.id,
      this.body,
      this.username,
      this.userId,
      this.posted,
       this.commentCount,
      this.eggRating);

  late String id;
  late String body;
  late DateTime posted;
  late int userId;
  late String username;
  late int? commentCount;
  late int? eggRating;
  late int currentRating;

  CluckModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    body = json['body'];
    posted = DateTime.parse(json['posted']);
    userId = json['authorId'];
    username = json['author'];
    eggRating = json['eggRating'] ?? 0;
    commentCount = json['commentCount'] ?? 0;
    currentRating = json['liked'] ?? 0;
  }
}
