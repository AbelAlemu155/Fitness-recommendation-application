import 'dart:convert';

import 'package:firsstapp/FitnessApp/bloc/plans/food_event.dart';
import 'package:firsstapp/FitnessApp/models/AssignFitnessPlan.dart';
import 'package:firsstapp/FitnessApp/models/DailyLog.dart';
import 'package:firsstapp/FitnessApp/models/MealPlan.dart';
import 'package:firsstapp/FitnessApp/models/factor.dart';
import 'package:firsstapp/FitnessApp/models/foodandwater.dart';
import 'package:firsstapp/FitnessApp/models/multiplefoods.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';
import 'package:firsstapp/FitnessApp/models/workout_plans.dart';
import 'package:firsstapp/FitnessApp/screens/login_screen.dart';
import 'package:http/http.dart' as http;

class PlanProvider {
  final http.Client httpClient;

  PlanProvider({required this.httpClient}) : assert(httpClient != null);

  Future<List> getUserPlan() async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
        Uri.http('10.0.2.2:8080', '/api/v1/userworkouts/$username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        });
    if (response.statusCode != 200) {
      throw Exception('Unable to get workouts');
    }

    List<Workout> workouts = [];

    List<dynamic> l = json.decode(response.body);

    List<WorkoutPlan> wtplans = l.map((e) => WorkoutPlan.fromJson(e)).toList();
    var ptowmap = Map();
    for (int i = 0; i < wtplans.length; i++) {
      final response2 = await httpClient.get(
          Uri.http('10.0.2.2:8080', wtplans[i].workouts),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': basicAuth
          });
      if (response2.statusCode == 200) {
        List<dynamic> l2 = json.decode(response2.body);

        List<Workout> wts = l2.map((e) => Workout.fromJson(e)).toList();
        ptowmap[i] = wts;
      }
    }

    final response3 = await httpClient.get(
        Uri.http('10.0.2.2:8080', '/api/v1/getnumweeks/$username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        });
    int numweeks2 = json.decode(response3.body)['num'];
    List<WorkoutPlan> wtps2 = [];

    for (int i = 0; i < numweeks2; i++) {
      if (wtplans.isNotEmpty) {
        int i2 = i % wtplans.length;
        wtps2.add(wtplans[i2]);
        final wts2 = ptowmap[i2];
        ptowmap[i] = wts2;
      }
    }

    return [wtps2, ptowmap];
  }

  Future<void> createPlan(Factor factor) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.post(
        Uri.http('10.0.2.2:8080', '/api/v1/userplan'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
            'email': username,
            'age': factor.age,
            'gender': factor.gender,
            'height': factor.height,
            'weight': factor.weight,
            'goal': factor.goal,
            'goal_weight': factor.goalWeight,
            'le_activity': factor.activity,
            'fitness_level': factor.fitnessLevel,
            'meal_category': factor.diet,
            'num_of_days_workout': factor.numDaysWorkout,
            'num_of_weeks_goal': factor.numWeeksGoals
          },
        ));
    if (response.statusCode != 200) {
      throw Exception('Unable to create plan for the user');
    }
  }

  Future<List> LoadUserFood(int index) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.post(
        Uri.http('10.0.2.2:8080', '/api/v1/getusermealplan/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth,
        },
        body: jsonEncode(<String, dynamic>{'email': username, 'page': index}));
    if (response.statusCode != 200) {
      throw Exception('Unable to get meal plans');
    }
    List<dynamic> l = json.decode(response.body);

    int index2 = 0;
    if (l.length != 0) {
      index2 = index % l.length;
    }

    List finall = [];
    if (l.length != 0) {
      List intList = [];
      intList.add(Breakfast.fromJson(l[0]));
      intList.add(Lunch.fromJson(l[1]));
      intList.add(Dinner.fromJson(l[2]));
      intList.add(Snack.fromJson(l[3]));
      finall.add(intList);

      return intList;
    }

    return [];
  }

  Future<Fandwater> getWaterAndFood() async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
        Uri.http('10.0.2.2:8080', '/api/v1/foodandwater/$username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        });
    if (response.statusCode != 200) {
      throw Exception('Unable to load user food and water info');
    }
    return Fandwater.fromJson(json.decode(response.body));
  }

  Future<MultipleFoods> getAllFoods(int page) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.post(
        Uri.http('10.0.2.2:8080', '/api/v1/getfoods/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
            'page': page,
          },
        ));
    if (response.statusCode != 200) {
      throw Exception('Unable to load foods');
    }
    List<dynamic> bfs = jsonDecode(response.body)['breakfast'];
    List<dynamic> ls = jsonDecode(response.body)['lunch'];
    List<dynamic> ds = jsonDecode(response.body)['dinner'];
    List<dynamic> ss = jsonDecode(response.body)['snack'];
    final prevb = jsonDecode(response.body)['prevb'] == null
        ? ''
        : jsonDecode(response.body)['prevb'];
    final prevl = jsonDecode(response.body)['prevl'] == null
        ? ''
        : jsonDecode(response.body)['prevl'];
    final prevd = jsonDecode(response.body)['prevd'] == null
        ? ''
        : jsonDecode(response.body)['prevd'];
    final prevs = jsonDecode(response.body)['prevs'] == null
        ? ''
        : jsonDecode(response.body)['prevs'];
    final nextb = jsonDecode(response.body)['nextb'] == null
        ? ''
        : jsonDecode(response.body)['nextb'];
    final nextl = jsonDecode(response.body)['nextl'] == null
        ? ''
        : jsonDecode(response.body)['nextl'];
    final nextd = jsonDecode(response.body)['nextd'] == null
        ? ''
        : jsonDecode(response.body)['nextd'];
    final nexts = jsonDecode(response.body)['nexts'] == null
        ? ''
        : jsonDecode(response.body)['nexts'];

    List<Breakfast> bfs2 = bfs.map((e) => Breakfast.fromJson(e)).toList();
    List<Lunch> ls2 = ls.map((e) => Lunch.fromJson(e)).toList();
    List<Dinner> ds2 = ds.map((e) => Dinner.fromJson(e)).toList();
    List<Snack> ss2 = ss.map((e) => Snack.fromJson(e)).toList();

    MultipleFoods mfs = MultipleFoods(
        bs: bfs2,
        ds: ds2,
        ls: ls2,
        nextb: nextb,
        nextd: nextd,
        nextl: nextl,
        nexts: nexts,
        prevb: prevb,
        prevd: prevd,
        prevl: prevl,
        prevs: prevs,
        ss: ss2);
    return mfs;
  }

  Future<WorkoutResponse> getAllWorkouts(int page) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.post(
        Uri.http('10.0.2.2:8080', '/api/v1/workouts/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
        body: jsonEncode(<String, int>{'page': page}));
    if (response.statusCode != 200) {
      throw Exception('Unable to load workouts');
    }
    String next_url = jsonDecode(response.body)['next_url'] == null
        ? ''
        : jsonDecode(response.body)['next_url'];
    String prev_url = jsonDecode(response.body)['prev_url'] == null
        ? ''
        : jsonDecode(response.body)['prev_url'];

    int count = jsonDecode(response.body)['count'];

    List<dynamic> wts = jsonDecode(response.body)['wkts'];

    List<Workout> wts2 = wts.map((e) => Workout.fromJson(e)).toList();
    //print(wts2);

    WorkoutResponse wresponse = WorkoutResponse(
        count: count, next_url: next_url, prev_url: prev_url, wkts: wts2);

    // print(wresponse);
    return wresponse;
  }

  Future<List<Exercise>> getWexercise(String url) async {
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
      throw Exception('Cannot load exercises');
    }

    List<dynamic> exs = jsonDecode(response.body);
    List<Exercise> exs2 = exs.map((e) => Exercise.fromJson(e)).toList();
    return exs2;
  }

  Future<double> getWCalorie(int id) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
        Uri.http('10.0.2.2:8080', 'api/v1/getcalorieworkout/$username/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        });
    if (response.statusCode != 200) {
      throw Exception('Cannot load calorie');
    }
    double cal = jsonDecode(response.body)['wcal'];
    return cal;
  }

  Future<DailyLogModel> postDailyLog(DailyLogModel dlog2) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.post(
        Uri.http('10.0.2.2:8080', '/api/v1/updatefoodintake'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
            'email': username,
            'name': dlog2.name,
            'calories': dlog2.calories,
            'category': dlog2.category,
          },
        ));
    if (response.statusCode != 200) {
      throw Exception('Unable to log daily food');
    }
    return dlog2;
  }

  Future<List<DailyLogModel>> getFoodLogs() async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
      Uri.http('10.0.2.2:8080', '/api/v1/getLoggedFoods/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Unable to log daily food');
    }

    List<dynamic> fs = jsonDecode(response.body);
    List<DailyLogModel> fs2 = fs.map((e) => DailyLogModel.fromJson(e)).toList();
    return fs2;
  }

  Future<double> drinkWater(double liter) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.post(
        Uri.http('10.0.2.2:8080', '/api/v1/drinkwater'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
            'email': username,
            'water': liter,
          },
        ));
    if (response.statusCode != 200) {
      throw Exception('Unable to update daily water intake');
    }

    return liter;
  }

  Future<double> CalorieDuration(int duration, int wid) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.post(
        Uri.http('10.0.2.2:8080', '/api/v1/calorieduration'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
            'email': username,
            'duration': duration,
            'wid': wid
          },
        ));
    if (response.statusCode != 200) {
      throw Exception('Unable to estimate calories');
    }
    return jsonDecode(response.body)['dcal'];
  }

  Future<void> PerformWorkout(double effort, int wid, int duration) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.post(
        Uri.http('10.0.2.2:8080', '/api/v1/performworkout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
            'email': username,
            'duration': duration,
            'wid': wid,
            'effort': effort
          },
        ));
    if (response.statusCode != 200) {
      throw Exception('Unable to Log Workouts');
    }
  }

  Future<List> getWorkoutProgress() async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
      Uri.http('10.0.2.2:8080', '/api/v1/getWorkoutProgress/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Unable to get Workout Progress');
    }
    List<dynamic> wcals2 = jsonDecode(response.body)['wcals'];
    List<double> wcals =
        List.generate(wcals2.length, (index) => wcals2[index].toDouble());

    //  List<double> wcals = wcals2.map((e) => e.toDouble()).toList();
    double reccal = jsonDecode(response.body)['reccal'].toDouble();
    return [wcals, reccal];
  }

  Future<List> getFoodProgress() async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
      Uri.http('10.0.2.2:8080', '/api/v1/getFoodProgress/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Unable to get Food Progress');
    }
    List<dynamic> cals2 = jsonDecode(response.body)['cals'];

    List<double> cals =
        List.generate(cals2.length, (index) => cals2[index].toDouble());
    print('this is cals2$cals');

    double reccal = jsonDecode(response.body)['reccal'].toDouble();
    return [cals, reccal];
  }

  Future<List> getWaterProgress() async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response = await httpClient.get(
      Uri.http('10.0.2.2:8080', '/api/v1/getWaterProgress/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Unable to get Water Progress');
    }

    List<dynamic> intakes2 = jsonDecode(response.body)['intakes'];

    List<double> intakes =
        List.generate(intakes2.length, (index) => intakes2[index].toDouble());
    double recintake = jsonDecode(response.body)['recintake'].toDouble();
    print(recintake);
    return [intakes, recintake];
  }

  Future<AssignDietPlan> getAssignedMPlan(int trid) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response = await httpClient.get(
      Uri.http('10.0.2.2:8080', '/api/v1/trainer/diet/$trid/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Unable to get Assigned Plan');
    }
    List<dynamic> fs = jsonDecode(response.body)['meals'];
    final client_id = jsonDecode(response.body)['client_id'];
    final dplan_id = jsonDecode(response.body)['dplan_id'];
    final name = jsonDecode(response.body)['name'];
    final trainer_id = jsonDecode(response.body)['trainer_id'];
    final weeks = jsonDecode(response.body)['weeks'];
    // print('ccccccccccc');
    List<AssignFood> fs2 = fs.map((e) => AssignFood.fromJson(e)).toList();
    print('cccc');
    AssignDietPlan adp = AssignDietPlan(
        client_id: client_id,
        dplan_id: dplan_id,
        meals: fs2,
        name: name,
        trainer_id: trainer_id,
        weeks: weeks);
    return adp;
  }

  Future<AssignFitnessPlan> getAssignedFplan(int trid) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response = await httpClient.get(
      Uri.http('10.0.2.2:8080', '/api/v1/trainer/workout/$trid/$username'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Unable to get Assigned Plan');
    }
    List<dynamic> wkts = jsonDecode(response.body)['workouts'];
    List<AssignWorkouts> wkts2 =
        wkts.map((e) => AssignWorkouts.fromJson(e)).toList();
    final client_id = jsonDecode(response.body)['client_id'];
    final fplan_id = jsonDecode(response.body)['fplan_id'];
    final name = jsonDecode(response.body)['name'];
    final trainer_id = jsonDecode(response.body)['trainer_id'];
    final weeks = jsonDecode(response.body)['weeks'];

    AssignFitnessPlan afp = AssignFitnessPlan(
        client_id: client_id,
        fplan_id: fplan_id,
        name: name,
        trainer_id: trainer_id,
        weeks: weeks,
        workouts: wkts2);

    return afp;
  }

  Future<List<Workout>> WfromList(List<int> ids) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final response = await httpClient.post(
        Uri.http('10.0.2.2:8080', '/api/v1/getworkoutlist/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
        body: jsonEncode(<String, dynamic>{'ids': ids}));
    if (response.statusCode != 200) {
      throw Exception('Unable to get workouts');
    }
    List<dynamic> wkts = jsonDecode(response.body);
    List<Workout> wkts2 = wkts.map((e) => Workout.fromJson(e)).toList();
    return wkts2;
  }
}
