import 'package:cached_network_image/cached_network_image.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_state.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_state.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_event.dart';
import 'package:firsstapp/FitnessApp/bloc/user_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/user_event.dart';
import 'package:firsstapp/FitnessApp/bloc/user_state.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_event.dart';
import 'package:firsstapp/FitnessApp/models/factor.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';
import 'package:firsstapp/FitnessApp/models/workout_plans.dart';
import 'package:firsstapp/FitnessApp/screens/workout/workout_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutPlanScreen extends StatelessWidget {
  static const routeName = '/Wplansscreen';
  int week = 1;
  int count = 0;

  String weekMessage(int num) {
    int num2 = num++;
    return num2.toString();
  }

  String intToMessage(int num, bool type) {
    if (type) {
      if (num == 1) {
        return 'Resistance';
      } else if (num == 2) {
        return 'Endurance';
      } else if (num == 3) {
        return 'Mobility';
      }
    } else {
      if (num == 1) {
        return 'Intensity : low';
      } else if (num == 2) {
        return 'Intensity : moderate';
      } else {
        return 'Intensity : high';
      }
    }
    return '';
  }

  List<Widget> listWidgets(
      int key, Map map, List<WorkoutPlan> wtplans, BuildContext context) {
    List<Widget> list = [];
    List<Workout> wkts = map[key];
    int wk = key + 1;
    list.add(Text(
      'Week ${wk.toString()}',
      style: TextStyle(fontWeight: FontWeight.bold),
    ));
    list.add(
      ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: wkts.length,
          itemBuilder: (_, idx) => ListTile(
                onTap: () {
                  String url = wkts[idx].url;

                  String url5 = url.substring(
                    url.lastIndexOf('/'),
                  );
                  String url6 = url5.replaceAll('/', '');

                  int id = int.parse(url6);

                  BlocProvider.of<WorkoutBloc>(context)
                      .add(getWexerciseEvent(wurl: wkts[idx].exercises));
                  BlocProvider.of<CalorieBloc>(context)
                      .add(WCalorieEvent(w_id: id));
                  Navigator.pushNamed(context, WorkoutDetailScreen.routeName,
                      arguments: wkts[idx]);
                },
                title: Text(wkts[idx].name),
                subtitle: Text(intToMessage(wkts[idx].type, true)),
                leading: Container(
                    width: 100,
                    child: CachedNetworkImage(imageUrl: wkts[idx].image_url)),
                trailing: Text(intToMessage(wkts[idx].intensity, false)),
              )),
    );
    list.add(
      const Divider(
        height: 20,
        thickness: 5,
        indent: 20,
        endIndent: 20,
      ),
    );
    return list;
  }

  List<Widget> finalListWidgets(
      Map map, List<WorkoutPlan> wtplans, BuildContext context) {
    List<Widget> finalList = [];
    for (int i = 0; i < wtplans.length; i++) {
      finalList.addAll(listWidgets(i, map, wtplans, context));
    }
    return finalList;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(getWgoal());
    return Scaffold(
      appBar: AppBar(
        title: Text('Plans'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Weekly Calorie Goal  ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  BlocBuilder<UserBloc, UserState>(builder: (_, state) {
                    if (state is WgoalFail) {
                      return Text(state.message);
                    }
                    if (state is WgoalLoad) {
                      return CircularProgressIndicator();
                    }
                    if (state is WgoalSuccess) {
                      return Text(state.goal.toString() + ' Kcal');
                    }
                    return Container();
                  })
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            BlocBuilder<Plan2Bloc, Plan2State>(builder: (_, state) {
              if (state is workoutsLoadProgress) {
                return CircularProgressIndicator();
              }
              if (state is workoutLoadFailiure) {
                return Text(state.message);
              }
              if (state is workoutLoadSuccess) {
                var map = state.workouts[1];
                List<WorkoutPlan> wplans = state.workouts[0];
                return Column(children: finalListWidgets(map, wplans, context));
              }
              return CircularProgressIndicator();
            }),
          ],
        ),
      ),
    );
  }
}
