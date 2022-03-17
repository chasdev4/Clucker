class UserAccountModel {
  UserAccountModel(this.id, this.username, this.hue, this.avatarImage);
  late int id;
  late String username;
  late double hue;
  late String? avatarImage;

  UserAccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    hue = json['hue'];
    avatarImage = json['avatarImage'];
  }
}
