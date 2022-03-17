class UserSelfModel {
  UserSelfModel(
    this.id,
    this.username,
    this.role,
  );
  late int id;
  late String username;
  late String role;

  UserSelfModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    role = json['role'];
  }
}
