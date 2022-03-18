import 'dart:convert';
import 'package:clucker_client/models/cluck_model.dart';
import 'package:clucker_client/models/cluck_post_request.dart';
import 'package:clucker_client/models/comment_post_request.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CluckService {
  final storage = const FlutterSecureStorage();

Future<String?> getToken() async {
    return await storage.read(key: 'authorization');
  }
  static const String url =
      'http://cluckerapi-env.eba-zjcqgymj.us-east-2.elasticbeanstalk.com:8080/';

  Future<http.Response> postCluck(CluckPostRequest postRequest) async {
    String? token = await getToken();
    return await http.post(Uri.parse('${url}clucks',), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': token!
    },
      body: jsonEncode(postRequest.toJSON()),);
  }

  Future<http.Response> postComment(CommentPostRequest postRequest) async {
    String? token = await getToken();
    return await http.post(Uri.parse('${url}clucks/${postRequest.cluckId}/comments',), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': token!
    },
      body: jsonEncode(postRequest.toJSON()),);
  }

  Future<List<CluckModel>> getFeed (String _token) async {
    final response = await http.get(Uri.parse('${url}feed/personal/'),
    headers: {'authorization': _token});

    if (response.statusCode == 200) {
      var jsonClucks = json.decode(response.body)['content'];

      return jsonClucks.map<CluckModel>((json) => CluckModel.fromJson(json)).toList();
    }

    throw Exception('An error has occurred on the method getFeed(). Status Code: ${response.statusCode}');
  }

  Future<CluckModel> getCluckByCluckId(String cluckId) async {
    final response = await http.get(Uri.parse('${url}clucks/$cluckId'));

    if (response.statusCode == 200) {
      var cluckJson = json.decode(response.body);
      return CluckModel.fromJson(cluckJson);
    }

    throw Exception('An error has occurred on the method getCluckByCluckId(). Status Code: ${response.statusCode}');
  }

  Future<List<CluckModel>> getCommentsByCluckId (String cluckId) async {
    final response = await http.get(Uri.parse('${url}clucks/$cluckId/comments'));

    if (response.statusCode == 200) {
      var jsonClucks = json.decode(response.body)['content'];
      List<CluckModel> comments = jsonClucks.map<CluckModel>((json) => CluckModel.fromJson(json)).toList();

      return comments;
    } else if (response.statusCode == 404) {
      return [];
    }

    throw Exception('An error has occurred on the method getCommentsByCluckId(). Status Code: ${response.statusCode}');
  }

  Future<List<CluckModel>> getProfileClucksById (int userId) async {
    final response = await http.get(Uri.parse('${url}users/$userId/clucks'));

    if (response.statusCode == 200) {
      var jsonClucks = json.decode(response.body)['content'];
      List<CluckModel> clucks = jsonClucks.map<CluckModel>((json) => CluckModel.fromJson(json)).toList();

      return clucks;
    } else if (response.statusCode == 404) {
      return [];
    }

    throw Exception('An error has occurred on the method getProfileClucksById(). Status Code: ${response.statusCode}');
  }
}
