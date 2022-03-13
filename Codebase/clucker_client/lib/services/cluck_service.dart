import 'dart:convert';
import 'package:clucker_client/models/cluck.dart';
import 'package:http/http.dart' as http;

class CluckService {
  static const String url =
      'http://cluckerapi-env.eba-zjcqgymj.us-east-2.elasticbeanstalk.com:8080/';

  Future<List<Cluck>> getClucks () async {
    final response = await http.get(Uri.parse('${url}clucks'));

    if (response.statusCode == 200) {
      var jsonClucks = json.decode(response.body)['content'];
      List<Cluck> clucks = jsonClucks.map<Cluck>((json) => Cluck.fromJson(json)).toList();

      return clucks;
    }

    throw Exception('An error has occurred on the method getClucks()');
  }

  Future<Cluck> getCluckByCluckId(String cluckId) async {
    final response = await http.get(Uri.parse('${url}clucks/$cluckId'));

    if (response.statusCode == 200) {
      var cluckJson = json.decode(response.body);
      return Cluck.fromJson(cluckJson);
    }

    throw Exception('An error has occurred on the method getCluckByCluckId()');
  }

  Future<List<Cluck>> getComments (String cluckId) async {
    final response = await http.get(Uri.parse('${url}clucks/$cluckId/comments'));
    List<Cluck> comments = [];

    print(response.body);

    if (response.statusCode == 200) {
      var jsonClucks = json.decode(response.body)['content'];
      comments = jsonClucks.map<Cluck>((json) => Cluck.fromJson(json)).toList();

      return comments;
    } else if (response.statusCode == 404) {
      return [];
    }

    throw Exception('An error has occurred on the method getComments()');
  }
}
