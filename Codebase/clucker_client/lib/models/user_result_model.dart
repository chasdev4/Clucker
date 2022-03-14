class UserResultModel {
  UserResultModel(
      this.id,
      this.username,
      this.bio,
      this.followersCount,
      this.eggRating,
      this.hue
      );
  late int id;
  late String username;
  late String bio;
  late int followersCount;
  late int eggRating;
  late double hue;

  UserResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    bio = json['bio'];
    followersCount = json['followerCount'];
    eggRating = json['eggRating'];
    hue = json['hue'];
  }
}