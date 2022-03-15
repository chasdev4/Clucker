class AuthRequest {

  String username;
  String password;

  AuthRequest({required this.username, required this.password});

  Map<String, String> toJSON() => {
    'username': username,
    'password': password,
  };

}
