import 'package:firsstapp/FitnessApp/bloc/workout/Permanent_state.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/permanent_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/permanent_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bar_chart_widget3.dart';
import 'bar_data.dart';
import 'data.dart';

class WaterStat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WaterStatState();
  }
}

class WaterStatState extends State<WaterStat> {
  List<Data> bardatas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bardatas = BarData.barData;
    for (int i = 0; i < bardatas.length; i++) {
      bardatas[i].y = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //  BlocProvider.of<PermanentBloc>(context).add(WaterStatEvent());
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'Current Week vs Water Intake (including the recommended range)',
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
              if (state is WaterStatLoad) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is WaterStatFail) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is WaterStatSuccess) {
                print('Abcdeden fj');
                final reccal = state.recintake;
                final wcals = state.intakes;

                return BarChartWidget3(
                    barData: bardatas, recommended_calorie: reccal);
              }
              return Container();
            },
          ),
        ),
        BlocListener<PermanentBloc, PermanentState>(
            child: Container(),
            listener: (_, state) {
              if (state is WaterStatSuccess) {
                final wcals = state.intakes;
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  setState(() {
                    for (int i = 0; i < wcals.length; i++) {
                      bardatas[i].y = wcals[i];
                    }
                  });
                });
              }
            })
      ],
    );
  }
}
