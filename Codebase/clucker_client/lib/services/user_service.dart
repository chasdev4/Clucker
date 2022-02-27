import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clucker_client/models/user_registration.dart';

class UserService {

  Future<bool> usernameAvailable(String _username) async {

    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/users/available-usernames?username=$_username'));

    return response.statusCode == 200;
  }

  Future<http.Response> registerUser(UserRegistration _userRegister) async {

    return await http.post(
      Uri.parse('http://10.0.2.2:8080/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(_userRegister.toJSON()),
    );



  }

}