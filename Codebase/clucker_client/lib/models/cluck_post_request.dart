class CluckPostRequest {
  CluckPostRequest(this.body, this.username, this.userId, this.posted,
      this.commentCount, this.eggRating);

  late String body;
  late String username;
  late int userId;
  late DateTime posted;
  late int commentCount;
  late int eggRating;

  Map<String, dynamic> toJSON() => {
    'body': body,
    'username': username,
    'authorId': userId,
    'posted': posted,
    'commentCount': commentCount,
    'eggRating' : eggRating
  };
}


