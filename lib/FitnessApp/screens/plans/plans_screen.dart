import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firsstapp/FitnessApp/Upload/googleDrive.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_state.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/log_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/log_event.dart';
import 'package:firsstapp/FitnessApp/bloc/upload/upload_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/upload/upload_event.dart';
import 'package:firsstapp/FitnessApp/models/factor.dart';
import 'package:firsstapp/FitnessApp/models/foodandwater.dart';
import 'package:firsstapp/FitnessApp/screens/plans/food_plans.dart';
import 'package:firsstapp/FitnessApp/screens/plans/foodandwater/LogFood.dart';
import 'package:firsstapp/FitnessApp/screens/plans/foodandwater/LogWater.dart';
import 'package:firsstapp/FitnessApp/screens/plans/workout_plans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlansScreen extends StatefulWidget {
  static const routeName = '/plansscreen';
  @override
  State<StatefulWidget> createState() {
    return PlansScreenState();
  }
}

class PlansScreenState extends State<PlansScreen> {
  double elevation = 10;
  double elevation2 = 10;
  double elevation3 = 10;
  double elevation4 = 10;
  double percent = 0;
  Fandwater _fwater = Fandwater(rwater: 0, food: 0, rfood: 0, water: 0);
  final drive = GoogleDrive();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PlanBloc>(context).add(FoodAndWaterEvent());

    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          /*Image(
              image: NetworkImage(
                  'https://drive.google.com/uc?export=view&id=14qZtcx_VE2bXlXEYvaDEeO28dGS3Aq1x')),*/

          GestureDetector(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  height: 120,
                                  child: Image(
                                      image: AssetImage('Images/workout.jpg')),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Workout Plan',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: "Mon",
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Personalized Workout Plans',
                                        style: TextStyle(
                                            fontSize: 15, fontFamily: "Mon"),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  size: 40,
                                  color: Colors.cyan,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
              elevation: elevation,
            ),
            onTap: () {
              setState(() {
                elevation = 0;
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    elevation = 10;
                  });

                  BlocProvider.of<Plan2Bloc>(context)
                      .add(UserWorkoutsLoadEvent());
                  Navigator.pushNamed(context, WorkoutPlanScreen.routeName);
                });
              });
            },
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  height: 120,
                                  child: Image(
                                      image: AssetImage('Images/foods.jpg')),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Meal Plan',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: "Mon",
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Personalized Meal Plans',
                                        style: TextStyle(
                                            fontSize: 15, fontFamily: "Mon"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_right,
                            size: 40,
                            color: Colors.cyan,
                          )
                        ],
                      ),
                    ),
                  ]),
              elevation: elevation2,
            ),
            onTap: () {
              setState(() {
                elevation2 = 0;
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    elevation2 = 10;
                  });

                  Navigator.pushNamed(
                    context,
                    FoodPlansScreen.routeName,
                  );
                });
              });
            },
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  height: 120,
                                  child: Image(
                                      image: AssetImage('Images/FoodLog.jpg')),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Log Food',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: "Mon",
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Enter Food you ate',
                                        style: TextStyle(
                                            fontSize: 15, fontFamily: "Mon"),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      BlocBuilder<PlanBloc, PlanState>(
                                          builder: (_, state) {
                                        if (state is FoodAndWaterFailure) {
                                          return Text(state.message);
                                        }
                                        if (state is FoodAndWaterInProgress) {
                                          return CircularProgressIndicator();
                                        }
                                        if (state is FoodAndWaterSuccess) {
                                          final fwater = state.fwater;
                                          _fwater = fwater;
                                          double cpercent;
                                          if (fwater.food > fwater.rfood) {
                                            cpercent = 1;
                                          } else {
                                            cpercent =
                                                fwater.food / fwater.rfood;
                                          }
                                          final dfood = fwater.food.round();
                                          final drfood = fwater.rfood.round();
                                          return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('${dfood}/${drfood} kcal',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: "Mon")),
                                                LinearProgressIndicator(
                                                  backgroundColor: Colors.grey,
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          Colors.cyan),
                                                  minHeight: 5,
                                                  value: cpercent,
                                                ),
                                              ]);
                                        }
                                        return Text('');
                                      })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_right,
                            size: 40,
                            color: Colors.cyan,
                          )
                        ],
                      ),
                    ),
                  ]),
              elevation: elevation3,
            ),
            onTap: () {
              setState(() {
                elevation3 = 0;
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    elevation3 = 10;
                  });
                });
              });
              BlocProvider.of<Plan2Bloc>(context).add(AnimatorEvent(index: 2));
              BlocProvider.of<FoodLogBloc>(context).add(FoodLogLoad());
              Map<double, Fandwater> map = {1: _fwater};

              Navigator.pushNamed(context, LogFoodScreen.routeName,
                  arguments: map);
            },
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  height: 120,
                                  child: Image(
                                      image:
                                          AssetImage('Images/trackwater.jpg')),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Track Water',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: "Mon",
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Track your intake',
                                        style: TextStyle(
                                            fontSize: 15, fontFamily: "Mon"),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      BlocBuilder<PlanBloc, PlanState>(
                                          builder: (_, state) {
                                        if (state is FoodAndWaterFailure) {
                                          return Text(state.message);
                                        }
                                        if (state is FoodAndWaterInProgress) {
                                          return CircularProgressIndicator();
                                        }
                                        if (state is FoodAndWaterSuccess) {
                                          final fwater = state.fwater;
                                          double cpercent;
                                          if (fwater.water > fwater.rwater) {
                                            cpercent = 1;
                                          } else {
                                            cpercent =
                                                fwater.water / fwater.rwater;
                                          }

                                          percent = cpercent;

                                          final dwater = double.parse(
                                              (fwater.water)
                                                  .toStringAsFixed(2));
                                          final drwater = double.parse(
                                              (fwater.rwater)
                                                  .toStringAsFixed(2));
                                          return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    '${dwater * 1000}/${drwater * 1000} mL',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: "Mon")),
                                                LinearProgressIndicator(
                                                  backgroundColor: Colors.grey,
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          Colors.cyan),
                                                  minHeight: 5,
                                                  value: cpercent,
                                                ),
                                              ]);
                                        }
                                        return Text('');
                                      })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_right,
                            size: 40,
                            color: Colors.cyan,
                          )
                        ],
                      ),
                    ),
                  ]),
              elevation: elevation4,
            ),
            onTap: () {
              setState(() {
                elevation4 = 0;
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    elevation4 = 10;
                  });
                });
              });
              Map<double, Fandwater> map2 = {0: _fwater};
              Navigator.pushNamed(context, LogWaterScreen.routeName,
                  arguments: map2);
            },
          ),
        ],
      ),
    );
  }
}
