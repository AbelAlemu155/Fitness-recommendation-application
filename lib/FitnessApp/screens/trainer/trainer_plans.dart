import 'package:firsstapp/FitnessApp/bloc/plans/food_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/food_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/food_state.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_state.dart';
import 'package:firsstapp/FitnessApp/models/AssignFitnessPlan.dart';
import 'package:firsstapp/FitnessApp/screens/trainer/trainer_diet_plan.dart';
import 'package:firsstapp/FitnessApp/screens/trainer/trainer_workout_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainerPlanScreen extends StatefulWidget {
  static const routeName = '/trainerplanscreen';
  int trid;
  TrainerPlanScreen({required this.trid});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TrainerPlanState();
  }
}

class TrainerPlanState extends State<TrainerPlanScreen> {
  bool tapping1 = false;
  bool tapping2 = false;
  List wplan = [];
  List dplan = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<WorkoutBloc>(context)
        .add(getAssignedFplan(trid: widget.trid));
    BlocProvider.of<FoodBloc>(context).add(getAssignedFood(trid: widget.trid));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.trid);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainer Plans'),
      ),
      body: Column(
        children: [
          BlocListener<WorkoutBloc, WorkoutState>(
              child: Container(),
              listener: (_, state) {
                print(state);
                if (state is AssignedWpSuccess) {
                  wplan.add(state.fitplan);
                  setState(() {
                    tapping1 = true;
                  });
                }
              }),
          BlocListener<FoodBloc, FoodState>(
              child: Container(),
              listener: (_, state) {
                print(state);
                if (state is AssignedFoodSuccess) {
                  print(state.dplan.meals);
                  dplan.add(state.dplan);
                  setState(() {
                    tapping2 = true;
                  });
                }
              }),
          SizedBox(
            height: 50,
          ),
          ListTile(
              title: Text('Get Trainer Meal Plans'),
              trailing: Icon(
                Icons.navigate_next,
                color: Colors.cyan,
              ),
              onTap: tapping1
                  ? () {
                      Navigator.pushNamed(context, TrainerDietPlan.routeName,
                          arguments: dplan[0]);
                    }
                  : () {}
              // trailing: Icon,
              ),
          Divider(
            color: Colors.cyan,
            thickness: 1,
            height: 20,
          ),
          ListTile(
            title: Text(
              'Get Trainer Workout Plans',
            ),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.cyan,
            ),
            onTap: tapping2
                ? () {
                    Navigator.pushNamed(context, TrainerWorkoutScreen.routeName,
                        arguments: wplan[0]);
                  }
                : () {},
          )
        ],
      ),
    );
  }
}
