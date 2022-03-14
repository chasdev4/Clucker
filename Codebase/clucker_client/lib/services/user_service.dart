import 'dart:convert';
import 'package:clucker_client/models/user_account_model.dart';
import 'package:clucker_client/models/user_avatar_model.dart';
import 'package:clucker_client/models/temp_user_model.dart';
import 'package:clucker_client/models/user_profile_model.dart';
import 'package:clucker_client/models/user_result_model.dart';
import 'package:http/http.dart' as http;
import 'package:clucker_client/models/user_registration.dart';

class UserService {
  static const String url =
      'http://cluckerapi-env.eba-zjcqgymj.us-east-2.elasticbeanstalk.com:8080/';

  Future<bool> usernameAvailable(String _username) async {
    final response = await http
        .get(Uri.parse('${url}users/available-usernames?username=$_username'));

    return response.statusCode == 200;
  }

  Future<http.Response> registerUser(UserRegistration _userRegister) async {
    return await http.post(
      Uri.parse('${url}users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(_userRegister.toJSON()),
    );
  }

  Future<UserAccountModel> getUserAccountById(int id) async {
    final response = await http.get(Uri.parse('${url}users/$id'));

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return UserAccountModel.fromJson(userJson);
    }

    throw Exception('${response.statusCode} Error - User Account not found.');
  }

  Future<UserProfileModel> getUserProfileById(int id) async {
    final response = await http.get(Uri.parse('${url}users/$id'));

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return UserProfileModel.fromJson(userJson);
    }

    throw Exception('${response.statusCode} Error - User Profile not found.');
  }

  Future<UserResultModel> getUserResultById(int id) async {
    final response = await http.get(Uri.parse('${url}users/$id'));

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return UserResultModel.fromJson(userJson);
    }
    throw Exception('${response.statusCode} Error - User Result not found.');
  }

  Future<UserAvatarModel> getUserAvatarById(int id) async {
    final response = await http.get(Uri.parse('${url}users/$id'));

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return UserAvatarModel.fromJson(userJson);
    }
    throw Exception('${response.statusCode} Error - User Avatar not found.');
  }

  Future<TempUserModel> getSelf() async {
    final response = await http.get(Uri.parse('${url}users/self'));

    if (response.statusCode == 200) {
      var userJson = json.decode(response.body);
      return TempUserModel.fromJson(userJson);
    }

    throw Exception('${response.statusCode} Error - User \'self\' not found.');
  }

  Future<bool> followUser(int id) async {
    final response = await http.put(Uri.parse('${url}users/$id/followers'));

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception(response.reasonPhrase);
  }
}
