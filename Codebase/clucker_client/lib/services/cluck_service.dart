import 'dart:convert';
import 'package:clucker_client/models/cluck.dart';
import 'package:http/http.dart' as http;

class CluckService {
  static const String url =
      'http://cluckerapi-env.eba-zjcqgymj.us-east-2.elasticbeanstalk.com:8080/';

  Future<Cluck> getCluckByCluckId(int id) async {
    final response = await http.get(Uri.parse('${url}clucks/$id'));

    if (response.statusCode == 200) {
      var cluckJson = json.decode(response.body);
      return Cluck.fromJson(cluckJson);
    }

    throw Exception('Cluck not found');
  }
}
