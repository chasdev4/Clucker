class UserResultModel {
  UserResultModel(
      this.id,
      this.username,
      this.bio,
      this.followersCount,
      );
  late int id;
  late String username;
  String bio = 'Not Implemented';
  late int followersCount;
  int eggRating = 1010101;
  double hue = 0;

  UserResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    // bio = json['bio'];
    followersCount = json['followerCount'];
    //eggRating = json['eggRating'];
    //hue = json['hue'];
  }
}