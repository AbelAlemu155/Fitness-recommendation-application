import 'dart:convert';

import 'package:firsstapp/FitnessApp/models/MealPlan.dart';
import 'package:firsstapp/FitnessApp/models/Trainer.dart';
import 'package:firsstapp/FitnessApp/models/factor.dart';
import 'package:firsstapp/FitnessApp/models/user.dart';
import 'package:firsstapp/FitnessApp/screens/login_screen.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final http.Client httpClient;

  UserProvider({required this.httpClient}) : assert(httpClient != null);

  Future<User> getUser(String url) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(Uri.http('10.0.2.2:8080', url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        });
    if (response.statusCode != 200) {
      throw Exception('Unable to get user');
    }
    User user = User.fromJson(jsonDecode(response.body));
    return user;
  }

  Future<User> getUserByemail(String email) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
        Uri.http('10.0.2.2:8080', '/api/v1/user/$username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        });
    if (response.statusCode != 200) {
      throw Exception('Unable to get user');
    }
    User user = User.fromJson(jsonDecode(response.body));
    return user;
  }

  Future<Factor> getUserData(String email) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
        Uri.http('10.0.2.2:8080', '/api/v1/userdata/$username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        });
    if (response.statusCode != 200) {
      throw Exception('Unable to get user data');
    }
    Factor factor = Factor.fromJson(jsonDecode(response.body));
    return factor;
  }

  Future<List<Trainer>> getApprovedTrainers() async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
        Uri.http('10.0.2.2:8080', '/api/v1/getapprovedtrainers/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        });
    if (response.statusCode != 200) {
      throw Exception('Unable to get Trainers');
    }
    List<dynamic> trs = jsonDecode(response.body);
    List<Trainer> trs2 = trs.map((t) => Trainer.fromJson(t)).toList();
    return trs2;
  }

  Future<List<Breakfast>> foodFromList(List<int> ids, int id) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    if (id == 1) {
      final response1 = await httpClient.post(
          Uri.http('10.0.2.2:8080', '/api/v1/getbfastfromlist/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': basicAuth
          },
          body: jsonEncode(<String, dynamic>{'ids': ids}));
      if (response1.statusCode != 200) {
        throw Exception('Unable to get food');
      }
      List<dynamic> bfs = jsonDecode(response1.body);
      List<Breakfast> bfs2 = bfs.map((e) => Breakfast.fromJson(e)).toList();
      return bfs2;
    } else if (id == 2) {
      final response2 = await httpClient.post(
          Uri.http('10.0.2.2:8080', '/api/v1/getlunchfromlist/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': basicAuth
          },
          body: jsonEncode(<String, dynamic>{'ids': ids}));

      if (response2.statusCode != 200) {
        throw Exception('Unable to get food');
      }
      List<dynamic> bfs = jsonDecode(response2.body);
      List<Breakfast> bfs2 = bfs.map((e) => Breakfast.fromJson(e)).toList();
      return bfs2;
    } else {
      final response3 = await httpClient.post(
          Uri.http('10.0.2.2:8080', '/api/v1/getdinnerfromlist/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': basicAuth
          },
          body: jsonEncode(<String, dynamic>{'ids': ids}));

      if (response3.statusCode != 200) {
        throw Exception('Unable to get food');
      }
      List<dynamic> bfs = jsonDecode(response3.body);
      List<Breakfast> bfs2 = bfs.map((e) => Breakfast.fromJson(e)).toList();
      return bfs2;
    }
  }

  Future<double> getwGoal() async {
   

    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
        Uri.http('10.0.2.2:8080', '/api/v1/weeklycaloriegoal/$username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        });
    if (response.statusCode != 200) {
      throw Exception('Unable to get goal');
    }
    return jsonDecode(response.body)['goal'];

  }
}
