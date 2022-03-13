class UserProfileModel {
  UserProfileModel(
      this.id,
      this.username,
      this.bio,
      this.joined,
      this.followersCount,
      this.followingCount,
      );
  late int id;
  late String username;
  String bio = 'Not Implemented';
  late DateTime joined;
  late int followersCount;
  late int followingCount;
  int eggRating = 1010101;
  double hue = 0;

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    // bio = json['bio'];
    followersCount = json['followerCount'];
    followingCount = json['followingCount'];
    joined = json['joined'];
    //eggRating = json['eggRating'];
    //hue = json['hue'];
  }
}