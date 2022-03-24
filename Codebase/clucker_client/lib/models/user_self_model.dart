class UserSelfModel {
  UserSelfModel(this.id, this.username, this.role, this.hue, this.avatarImage);
  late int id;
  late String username;
  late String role;
  late double hue;
  late String avatarImage;

  UserSelfModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    role = json['role'];
    hue = json['avatarHue'];
    avatarImage = json['avatarImage'] ?? '';
  }
}
