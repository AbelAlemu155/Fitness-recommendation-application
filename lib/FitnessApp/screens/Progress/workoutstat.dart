import 'package:firsstapp/FitnessApp/bloc/workout/Permanent_state.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_state.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/permanent_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/permanent_event.dart';
import 'package:firsstapp/FitnessApp/screens/Progress/bar_chart_widget.dart';
import 'package:firsstapp/FitnessApp/screens/Progress/bar_data.dart';
import 'package:firsstapp/FitnessApp/screens/Progress/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutStat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WorkoutStatState();
  }
}

class WorkoutStatState extends State<WorkoutStat> {
  List<Data> bardatas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bardatas = BarData.barData;
    for (int i = 0; i < bardatas.length; i++) {
      bardatas[i].y = 0;
    }
    BlocProvider.of<PermanentBloc>(context).add(WorkoutStatEvent());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build4

    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'Current Week vs Calorie by Exercise (line includes recommended range)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          color: Colors.grey.withOpacity(0.4),
          height: 400,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          child: BlocBuilder<PermanentBloc, PermanentState>(
            builder: (_, state) {
              if (state is WorkoutStatLoad) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is WorkoutStatFail) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is WorkoutStatSuccess) {
                // List<Data> bardatas = BarData.barData;
                final reccal = state.reccal / 7;
                final wcals = state.wcals;

                return BarChartWidget(
                    barData: bardatas, recommended_calorie: reccal);
              }
              return Container();
            },
          ),
        ),
        BlocListener<PermanentBloc, PermanentState>(
            child: Container(),
            listener: (_, state) {
              if (state is WorkoutStatSuccess) {
                final wcals = state.wcals;
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  setState(() {
                    for (int i = 0; i < wcals.length; i++) {
                      bardatas[i].y = wcals[i] / 1000;
                    }
                  });
                });
              }
            })
      ],
    );
  }
}
