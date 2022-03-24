class CluckModel {
  CluckModel(
      this.id,
      this.body,
      this.username,
      this.userId,
      this.posted,
       this.commentCount,
      this.eggRating,
      this.currentRating);

  late int userId;
  late String id;
  late String body;
  late String username;
  late DateTime posted;
  late int? commentCount;
  late int? eggRating;
  late int currentRating;
  late double hue;
  late String avatarImage;
  late String timezone;

  CluckModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    body = json['body'];
    posted = DateTime.parse(json['posted']);
    userId = json['authorId'];
    username = json['author'];
    eggRating = json['eggRating'] ?? 0;
    commentCount = json['commentCount'] ?? 0;
    currentRating = json['liked'] ?? 0;
    hue = 0;
    avatarImage = '';
  }

  void update(double hue, String avatarImage) {
    this.hue = hue;
    this.avatarImage = avatarImage;
  }
}
