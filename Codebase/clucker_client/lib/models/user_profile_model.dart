class UserProfileModel {
  UserProfileModel(
      this.id,
      this.username,
      this.bio,
      this.joined,
      this.followersCount,
      this.followingCount,
      this.eggRating,
      this.hue,
      this.avatarImage
      );
  late int id;
  late String username;
  late String bio;
  late DateTime joined;
  late int followersCount;
  late int followingCount;
  late int eggRating;
  late double hue;
  late String avatarImage;

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    bio = json['bio'];
    followersCount = json['followerCount'];
    followingCount = json['followingCount'];
    joined = json['joined'];
    eggRating = json['eggRating'];
    hue = json['hue'];
    avatarImage = json['avatarImage'];
  }
}