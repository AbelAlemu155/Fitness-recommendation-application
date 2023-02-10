import 'package:firsstapp/FitnessApp/bloc/plans/workout_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_state.dart';
import 'package:firsstapp/FitnessApp/models/AssignFitnessPlan.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainerWorkoutScreen extends StatefulWidget {
  static const routeName = '/trainerWorkoutScreen';
  AssignFitnessPlan fplan;
  TrainerWorkoutScreen({required this.fplan});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TrainerWorkoutState();
  }
}

class TrainerWorkoutState extends State<TrainerWorkoutScreen> {
  List<int> ids = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final ws = widget.fplan.workouts;
    for (int i = 0; i < ws.length; i++) {
      ids.add(ws[i].workout_id);
    }
    BlocProvider.of<WorkoutBloc>(context).add(getWFromList(ids: ids));
  }

  List<Workout> wkts2 = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainer Workout Plans'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocListener<WorkoutBloc, WorkoutState>(
              child: Container(),
              listener: (_, state) {
                if (state is getWlistSuccess) {
                  wkts2.addAll(state.wkts);
                  setState(() {});
                }
              },
            ),
            for (int i = 0; i < wkts2.length; i++)
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Text(wkts2[i].name),
                    Text(wkts2[i].description),
                    Text(wkts2[i].muscle_target),
                    Text(wkts2[i].duration.toString())
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
