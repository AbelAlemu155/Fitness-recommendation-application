import 'dart:convert';

import 'package:firsstapp/FitnessApp/models/MealPlan.dart';
import 'package:firsstapp/FitnessApp/models/SearchFood.dart';
import 'package:firsstapp/FitnessApp/models/Searchfoodr.dart';
import 'package:firsstapp/FitnessApp/models/searchworkoutfrom.dart';
import 'package:firsstapp/FitnessApp/models/serachworkoutto.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';
import 'package:firsstapp/FitnessApp/screens/login_screen.dart';
import 'package:http/http.dart' as http;

class SearchProvider {
  final http.Client httpClient;

  SearchProvider({required this.httpClient}) : assert(httpClient != null);

  Future<SearchFoodr> searchFood(SearchFModel sfood, bool isempty) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    if (isempty) {
      return SearchFoodr(
          count_b: 0,
          count_d: 0,
          count_l: 0,
          count_s: 0,
          foods: [],
          next_url: '',
          prev_url: '');
    }
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.post(
        Uri.http('10.0.2.2:8080', '/api/v1/searchfood'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
            'page': sfood.page,
            'keyword': sfood.keyword,
            'type': sfood.type,
            'count': sfood.count,
            'category': sfood.category,
            'calorie': sfood.sort,
          },
        ));
    if (response.statusCode != 200) {
      throw Exception('Unable to search food');
    }

    List<dynamic> l = json.decode(response.body)['meal'];
    String prev_url = json.decode(response.body)['prev_url'] == null
        ? ''
        : json.decode(response.body)['prev_url'];
    String next_url = json.decode(response.body)['next_url'] == null
        ? ''
        : json.decode(response.body)['next_url'];
    int count_b = jsonDecode(response.body)['count_b'];
    int count_l = jsonDecode(response.body)['count_b'];
    int count_d = jsonDecode(response.body)['count_b'];
    int count_s = jsonDecode(response.body)['count_b'];

    List foods = l.map((e) => Breakfast.fromJson(e)).toList();

    return SearchFoodr(
        count_b: count_b,
        count_d: count_d,
        count_l: count_l,
        count_s: count_s,
        foods: foods,
        next_url: next_url,
        prev_url: prev_url);
  }

  Future<SearchWorkoutFrom> searchWorkout(
      SearchWorkoutTo swto, bool isempty) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    if (isempty) {
      return SearchWorkoutFrom(
          count: 0, next_url: '', prev_url: '', workouts: []);
    } else {
      final response = await httpClient.post(
          Uri.http('10.0.2.2:8080', '/api/v1/searchworkout'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': basicAuth
          },
          body: jsonEncode(
            <String, dynamic>{
              'page': swto.page,
              'keyword': swto.keyword,
              'type': swto.type,
              'cduration': swto.cduration,
              'intensity': swto.intensity,
              'duration': swto.duration,
              'ctype': swto.ctype,
              'cintensity': swto.cintensity,
              'sort': swto.sort
            },
          ));
      if (response.statusCode != 200) {
        throw Exception('Unable to search Workout');
      }
      List<dynamic> l = json.decode(response.body)['workouts'];
      List<Workout> wkts = l.map((e) => Workout.fromJson(e)).toList();
      String prev_url = json.decode(response.body)['prev_url'] == null
          ? ''
          : json.decode(response.body)['prev_url'];
      String next_url = json.decode(response.body)['next_url'] == null
          ? ''
          : json.decode(response.body)['next_url'];
      int count = json.decode(response.body)['count'];
      return SearchWorkoutFrom(
          count: count, next_url: next_url, prev_url: prev_url, workouts: wkts);
    }
  }
}
