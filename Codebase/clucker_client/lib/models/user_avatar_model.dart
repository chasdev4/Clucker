class UserAvatarModel {
  UserAvatarModel(this.id, this.username, this.image,
      this.hue
  );
  late int id;
  late String username;
  late String? image;
  late double hue;

  UserAvatarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    image = json['image'];
    if (json['hue'] == null) {
      hue = 0;
    } else {
      hue = json['hue'];
    }
  }
}
