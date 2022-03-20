class UserResultModel {
  UserResultModel(
      this.id,
      this.username,
      this.bio,
      this.followersCount,
      this.eggRating,
      this.hue,
      this.avatarImage
      );
  late int id;
  late String username;
  late String bio;
  late int followersCount;
  late int eggRating;
  late double hue;
  late String? avatarImage;

  UserResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    bio = json['bio'] ?? '';
    followersCount = json['followersCount'];
    eggRating = json['eggRating'];
    hue = json['avatarHue'];
    avatarImage = json['avatarImage'];
  }
}