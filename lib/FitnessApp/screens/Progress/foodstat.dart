import 'package:firsstapp/FitnessApp/bloc/workout/Permanent_state.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/permanent_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/permanent_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bar_chart_widget2.dart';
import 'bar_data.dart';
import 'data.dart';

class FoodStat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FoodStatState();
  }
}

class FoodStatState extends State<FoodStat> {
  List<Data> bardatas = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bardatas = BarData.barData;
    for (int i = 0; i < bardatas.length; i++) {
      bardatas[i].y = 0;
    }
    //BlocProvider.of<PermanentBloc>(context).add(FoodStatEvent());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'Current Week vs Calorie by Food (including the recommended range)',
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
              if (state is FoodStatLoad) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is FoodStatFail) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is FoodStatSuccess) {
                List<Data> bardatas = BarData.barData;
                final reccal = state.reccal;
                final fcals = state.fcals;

                return BarChartWidget2(
                    barData: bardatas, recommended_calorie: reccal);
              }
              return Container();
            },
          ),
        ),
        BlocListener<PermanentBloc, PermanentState>(
            child: Container(),
            listener: (_, state) {
              if (state is FoodStatSuccess) {
                final wcals = state.fcals;
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
