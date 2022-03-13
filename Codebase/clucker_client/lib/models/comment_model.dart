class CommentModel {
  CommentModel(this.commentId, this.body, this.username, this.posted, this.eggRating);

  late String commentId;
  late String body;
  late String username;
  int userId = 0;
  late DateTime posted;
  late int eggRating = 0;

  CommentModel.fromJson(Map<dynamic, dynamic> json) {
    commentId = json['id'];
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
