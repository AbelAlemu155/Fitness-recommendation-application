import 'package:cached_network_image/cached_network_image.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_state.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_event.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_state.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';
import 'package:firsstapp/FitnessApp/screens/plans/weight_height_ui.dart';
import 'package:firsstapp/FitnessApp/screens/workout/exercise_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      return 'Low';
    } else if (num == 2) {
      return 'Moderate';
    } else {
      return 'High';
    }
  }
  return '';
}

class WorkoutDetailScreen extends StatefulWidget {
  Workout wkt;
  static const routeName = '/workoutdetailscreen';
  List<Exercise> exs = [];
  WorkoutDetailScreen({required this.wkt});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WorkoutDetailState();
  }
}

class _WorkoutDetailState extends State<WorkoutDetailScreen> {
  bool _tapped = false;
  List<Exercise> excer = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(widget.wkt.image_url),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<WorkoutBloc>(context)
                              .add(WorkoutLoadEvent(page: 1));
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back))
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(widget.wkt.name,
                    style: TextStyle(color: Colors.white, fontSize: 40))
              ]),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 50,
              ),
              BlocBuilder<WorkoutBloc, WorkoutState>(builder: (_, state) {
                if (state is getWExerciseLoad) {
                  // print('yess!!');
                  return CircularProgressIndicator();
                }
                if (state is getWExerciseFailure) {
                  return Text(state.message);
                }
                if (state is getWExerciseSuccess) {
                  // print('yess!!');
                  final exs = state.exs;
                  excer = exs;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(exs.length.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 40)),
                      Text(
                        ' Exercises Included',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ],
                  );
                }
                return Container();
              }),
              SizedBox(
                height: 90,
              ),
              Container(
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text('Calories',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            SizedBox(
                              height: 7,
                            ),
                            BlocBuilder<CalorieBloc, CalorieState>(
                                builder: (_, state) {
                              if (state is WCalorieLoad) {
                                return CircularProgressIndicator();
                              }
                              if (state is WCalorieFail) {
                                return Text(state.message,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17));
                              }
                              if (state is WCaloriesSuccess) {
                                return Text(state.calorie.toInt().toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17));
                              }
                              return Text('');
                            }),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.white,
                        thickness: 1,
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text('Duration',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            SizedBox(
                              height: 7,
                            ),
                            Text('${widget.wkt.duration.toString()}  min',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17))
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.white,
                        thickness: 1,
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text('Intensity',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            SizedBox(
                              height: 7,
                            ),
                            Text(intToMessage(widget.wkt.intensity, false),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17))
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.white,
                        thickness: 1,
                        width: 10,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text('Type',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            SizedBox(
                              height: 7,
                            ),
                            Text(intToMessage(widget.wkt.type, true),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 150,
              ),
              GestureDetector(
                child: Container(
                  width: 300,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: _tapped ? Colors.grey : Colors.cyan,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 20,
                        child: Container(
                          width: 50,
                        ),
                      ),
                      Text('Start Workout',
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                      Container(
                        width: 70,
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    _tapped = true;
                  });
                  Future.delayed(const Duration(milliseconds: 200), () {
                    setState(() {
                      _tapped = false;
                    });
                  });
                  if (excer.length != 0) {
                    Image img1 = Image(image: NetworkImage(excer[0].image_url));
                    precacheImage(img1.image, context);
                    BlocProvider.of<CalorieBloc>(context)
                        .add(TimerEvent(index: 0));
                    BlocProvider.of<Plan2Bloc>(context).add(ImageSlideEvent());
                    Navigator.pushNamed(context, ExerciseScreen.routeName,
                        arguments: [excer, img1, widget.wkt]);
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
