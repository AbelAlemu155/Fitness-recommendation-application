import 'package:firsstapp/FitnessApp/bloc/workout/calorie_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_event.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/permanent_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/permanent_event.dart';
import 'package:firsstapp/FitnessApp/screens/Progress/bar_data.dart';
import 'package:firsstapp/FitnessApp/screens/Progress/foodstat.dart';
import 'package:firsstapp/FitnessApp/screens/Progress/waterstat.dart';
import 'package:firsstapp/FitnessApp/screens/Progress/workoutstat.dart';
import 'package:firsstapp/font/custom__icon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatScreen extends StatefulWidget {
  static const routeName = '/StatScreen';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StatScreenState();
  }
}

class StatScreenState extends State<StatScreen> with TickerProviderStateMixin {
  List<double> intervals = [1, 5, 1];
  int _index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void event_adder(int index, BuildContext context) {
    if (index == 0) {
      BlocProvider.of<PermanentBloc>(context).add(WorkoutStatEvent());
    } else if (index == 1) {
      BlocProvider.of<PermanentBloc>(context).add(FoodStatEvent());
    } else if (index == 2) {
      BlocProvider.of<PermanentBloc>(context).add(WaterStatEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Progress'),
          bottom: TabBar(
            onTap: (int index) {
              if (index != _index) {
                BlocProvider.of<CalorieBloc>(context)
                    .add(FirstTimeAnimatorEvent());
              }
              BarData.interval = intervals[index];

              event_adder(index, context);
            },
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            tabs: [
              Container(
                  padding: EdgeInsets.all(15),
                  child: Icon(Custom_Icon.fitness_center)),
              Container(
                  padding: EdgeInsets.all(10), child: Icon(Custom_Icon.food)),
              Container(padding: EdgeInsets.all(10), child: Icon(Icons.water))
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [WorkoutStat(), FoodStat(), WaterStat()],
        ),
      ),
    );
  }
}
