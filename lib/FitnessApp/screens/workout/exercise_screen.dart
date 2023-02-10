import 'dart:async';

import 'dart:ui';

import 'package:firsstapp/FitnessApp/bloc/plans/plan2_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_state.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_state.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_state.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/Permanent_state.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_event.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_state.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/permanent_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/permanent_event.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';
import 'package:firsstapp/FitnessApp/screens/plans/weight_height_ui.dart';
import 'package:firsstapp/FitnessApp/screens/workout/workout_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ExerciseScreen extends StatefulWidget {
  static const routeName = '/excercisescreen';
  List<Exercise> exs;
  Image img;
  Workout wk;

  ExerciseScreen({required this.exs, required this.img, required this.wk});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExerciseScreenState();
  }
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int _count = 0;
  double _percent = 0;
  List<NetworkImage> images = [];
  int _ready = 3;
  int excount = 0;
  late Timer _timer;
  late Timer _timer2;
  bool _goal = true;
  List<bool> _started = [];
  int currentindex = 0;
  late DateTime endtime;
  late CountdownTimerController tcontroller;
  CurrentRemainingTime? remainingTime = CurrentRemainingTime();
  List<double> percents = [];
  List<ImageSlideshow> slides = [];
  int interval = 0;
  bool startScreen = false;
  bool _tapped = false;
  bool _tapped2 = false;
  List<CurrentRemainingTime?> alltimes = [];
  String timeDisplay(int time) {
    String str = '';

    if (time < 10) {
      str = '0' + time.toString();
      return str;
    }
    return time.toString();
  }

  @override
  void dispose() {
    _timer.cancel();

    tcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    for (Exercise ex in widget.exs) {
      images.add(NetworkImage(ex.image_url));
      _started.add(false);
      percents.add(0);
      alltimes.add(CurrentRemainingTime(min: ex.duration));
    }
    _started[0] = true;
    excount = widget.exs[0].duration;
    endtime = DateTime.now().add(Duration(minutes: excount));
    int endtime2 = endtime.millisecondsSinceEpoch + 16000;
    CountdownTimerController(endTime: endtime2, onEnd: () {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (NetworkImage img in images) {
      precacheImage(img, context);
    }
  }

  void updateCounter(Exercise ex, int index) {
    const oneSec = const Duration(seconds: 1);
    if (index == currentindex) {
      _timer2 = new Timer.periodic(
        oneSec,
        (Timer timer) {
          if (excount == 0) {
            setState(() {
              index++;
              excount = widget.exs[index].duration;
              timer.cancel();
            });
          } else {
            setState(() {
              excount--;
            });
          }
        },
      );
    }
  }

  void _showModal(CurrentRemainingTime? rmt, int cind) {
    int times = rmt!.sec == null ? 0 : rmt.sec as int;
    int timem = rmt.min == null ? 0 : rmt.min as int;
    String times2 = timeDisplay(times);
    String timem2 = timem.toString();
    int cind2 = cind + 1;
    int ss = times + 60 * timem;
    int diff = widget.exs[cind].duration * 60 - ss;
    List<int> flagged = [];
    for (int i = 0; i < widget.exs.length; i++) {
      if (i > cind) {
        flagged.add(i);
      }
    }
    String getth(int ind) {
      if (ind == 1) {
        return 'st';
      } else if (ind == 2) {
        return 'nd';
      } else if (ind == 3) {
        return 'rd';
      } else {
        return 'th';
      }
    }

    int cind3 = cind - 1;
    if (cind == 0) {
      cind3 = 0;
    }
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 10,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState2 /*You can rename this!*/) {
            return Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.cyan),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                DateTime edate =
                                    DateTime.now().add(Duration(seconds: ss));

                                setState(() {
                                  currentindex = cind;
                                  endtime = edate;
                                  for (int i in flagged) {
                                    percents[i] = 0;
                                  }
                                });
                                BlocProvider.of<Plan2Bloc>(context)
                                    .add(ImageSlideInitEvent());

                                BlocProvider.of<WorkoutBloc>(context)
                                    .add(ImageEvent(index: currentindex));
                                BlocProvider.of<Plan2Bloc>(context)
                                    .add(ImageSlideEvent());

                                BlocProvider.of<CalorieBloc>(context)
                                    .add(TimerEvent(index: cind));
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back))
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$timem2:$times2',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.exs[cind].name,
                              style: TextStyle(fontSize: 35)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$cind3 Exercises Completed',
                              style: TextStyle(fontSize: 35)),
                        ],
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                DateTime edate =
                                    DateTime.now().add(Duration(seconds: ss));

                                setState(() {
                                  currentindex = cind;
                                  endtime = edate;
                                  for (int i in flagged) {
                                    percents[i] = 0;
                                  }
                                });
                                BlocProvider.of<Plan2Bloc>(context)
                                    .add(ImageSlideInitEvent());

                                BlocProvider.of<WorkoutBloc>(context)
                                    .add(ImageEvent(index: currentindex));
                                BlocProvider.of<Plan2Bloc>(context)
                                    .add(ImageSlideEvent());

                                BlocProvider.of<CalorieBloc>(context)
                                    .add(TimerEvent(index: cind));
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.play_arrow,
                                color: Colors.cyan,
                                size: 70,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 300,
                      ),
                    ],
                  ),
                ));
          });
        });
  }

  void _endmodal(List<CurrentRemainingTime?> atimes, int currentIndex) {
    int tduration = 0;
    int tmin = 0;
    int tsec = 0;
    int numexer = 0;
    int ctime = 0;
    List<int> flagged2 = [];
    for (int i = 0; i < atimes.length; i++) {
      final time = atimes[i];
      int min = time!.min == null ? 0 : time.min as int;
      int sec = time.sec == null ? 0 : time.sec as int;
      if (i == 0) {
        print('//////min///////***********$min');
        print('//////sec////////$sec');
      }
      int d = (min * 60) + sec;
      int d2 = widget.exs[i].duration * 60;
      tduration = d2 - d + tduration;
      int di = d2 - d;
      tmin = (di / 60).floor() + tmin;
      tsec = (di % 60) + tsec;
      if (min == 0 && sec == 1) {
        numexer++;
      }
      if (currentIndex == i) {
        ctime = min * 60 + sec;
      }
      if (i > currentIndex) {
        flagged2.add(i);
      }
    }
    if (tsec >= 60) {
      tmin = tmin + (tsec / 60).floor();
      tsec = tsec % 60;
    }
    String name = widget.wk.name;
    String tmin2 = tmin.toString();
    String tsec2 = timeDisplay(tsec);
    String wkid = widget.wk.url.replaceFirst('/', '');
    String wkid2 = wkid.replaceFirst('/', '');
    String wkid3 = wkid2.replaceFirst('/', '');
    String url5 = wkid3.substring(
      wkid3.lastIndexOf('/'),
    );
    String url6 = url5.replaceAll('/', '');

    int id = int.parse(url6);
    bool effort1 = true;
    bool effort2 = false;
    bool effort3 = false;

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 10,
        context: context,
        builder: (BuildContext context) {
          BlocProvider.of<CalorieBloc>(context)
              .add(CalorieByDurationEvent(duration: tduration, wid: id));
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState2 /*You can rename this!*/) {
            return Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.cyan),
                borderRadius: BorderRadius.circular(20.0),
              ),
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                DateTime edate = DateTime.now()
                                    .add(Duration(seconds: ctime));

                                setState(() {
                                  currentindex = currentIndex;
                                  endtime = edate;
                                  for (int i in flagged2) {
                                    percents[i] = 0;
                                  }
                                });
                                BlocProvider.of<Plan2Bloc>(context)
                                    .add(ImageSlideInitEvent());

                                BlocProvider.of<WorkoutBloc>(context)
                                    .add(ImageEvent(index: currentindex));
                                BlocProvider.of<Plan2Bloc>(context)
                                    .add(ImageSlideEvent());

                                BlocProvider.of<CalorieBloc>(context)
                                    .add(TimerEvent(index: currentIndex));
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.cyan,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Workout: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                            Text(name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                ))
                          ]),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Exercises Completed: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                            Text('$numexer Exercises',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                ))
                          ]),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Total Duration: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                            Text('$tmin2 minutes and $tsec2 seconds',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                ))
                          ]),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Estimated Calories: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                          BlocBuilder<CalorieBloc, CalorieState>(
                              builder: (_, state) {
                            if (state is CalorieByDurationLoad) {
                              return CircularProgressIndicator();
                            }
                            if (state is CalorieByDurationFail) {
                              return Text(state.message);
                            }
                            if (state is CalorieByDurationSuccess) {
                              final cal = state.calories.toStringAsFixed(2);
                              return Text(
                                '$cal kcal',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                ),
                              );
                            }
                            return Container();
                          })
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Describe Your Effort',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState2(() {
                            effort1 = true;
                            effort2 = false;
                            effort3 = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(0),
                          width: double.infinity,
                          color: effort1 == true ? Colors.grey : Colors.white,
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              'I gave it my all',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState2(() {
                            effort1 = false;
                            effort2 = true;
                            effort3 = false;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          color: effort2 == true ? Colors.grey : Colors.white,
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              'My effort is average',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState2(() {
                            effort3 = true;
                            effort1 = false;
                            effort2 = false;
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          color: effort3 == true ? Colors.grey : Colors.white,
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              'I was lazy today',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 80),
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
                              Text('End Workout',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17)),
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
                          setState2(() {
                            _tapped = true;
                          });
                          Future.delayed(const Duration(milliseconds: 200), () {
                            setState2(() {
                              _tapped = false;
                            });
                          });
                          double effort = 0;
                          if (effort1) {
                            effort = 1;
                          } else if (effort2) {
                            effort = 0.75;
                          } else {
                            effort = 0.5;
                          }
                          BlocProvider.of<PermanentBloc>(context).add(
                              PermanentWorkout(
                                  duration: tduration,
                                  effort: effort,
                                  wid: id));
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      BlocBuilder<PermanentBloc, PermanentState>(
                        builder: (_, state) {
                          if (state is PermanentProgress) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [CircularProgressIndicator()],
                            );
                          }
                          if (state is PermanentFail) {
                            return Text(state.message);
                          }
                          return Container();
                        },
                      ),
                      BlocListener<PermanentBloc, PermanentState>(
                          child: Container(),
                          listener: (_, state) {
                            if (state is PermanentSuccess) {
                              BlocProvider.of<WorkoutBloc>(context).add(
                                  getWexerciseEvent(wurl: widget.wk.exercises));
                              BlocProvider.of<CalorieBloc>(context)
                                  .add(WCalorieEvent(w_id: id));

                              Future.delayed(Duration(seconds: 1), () {
                                /*  Navigator.popUntil(
                                    context,
                                    ModalRoute.withName(
                                        WorkoutDetailScreen.routeName));*/
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            }
                          })
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WorkoutBloc>(context).add(ImageEvent(index: currentindex));

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 5), () {
        setState(() {
          startScreen = true;
        });
      });
    });
    if (startScreen) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                BlocListener<PlanBloc, PlanState>(
                    child: Container(),
                    listener: (_, state) {
                      if (state is NullState) {
                        int ind = currentindex + 1;
                        //print(ind);
                        print('alltimes min*********${alltimes}');
                        if (ind < widget.exs.length) {
                          endtime = DateTime.now()
                              .add(Duration(minutes: widget.exs[ind].duration));

                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            setState(() {
                              currentindex++;
                              interval =
                                  widget.exs[currentindex].duration * 60 * 1000;
                            });
                          });
                          BlocProvider.of<WorkoutBloc>(context)
                              .add(ImageEvent(index: currentindex));
                          BlocProvider.of<Plan2Bloc>(context)
                              .add(ImageSlideEvent());

                          BlocProvider.of<CalorieBloc>(context)
                              .add(TimerEvent(index: ind));
                          print('empty');
                          print('alltimes min*********${alltimes}');
                        }
                      }
                    }),
                BlocBuilder<Plan2Bloc, Plan2State>(builder: (_, state) {
                  if (state is ImageSlideState) {
                    return Image(
                        image: images[currentindex],
                        fit: BoxFit.cover,
                        height: 400,
                        width: MediaQuery.of(context).size.width);
                  }
                  return Container();
                }),
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              _endmodal(alltimes, currentindex);
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.cyan,
                            )),
                        BlocBuilder<CalorieBloc, CalorieState>(
                            builder: (_, state) {
                          if (state is TimerState) {
                            final exs2 = widget.exs;

                            tcontroller = CountdownTimerController(
                                endTime: endtime.millisecondsSinceEpoch,
                                onEnd: () {});

                            return CountdownTimer(
                              widgetBuilder: (BuildContext context,
                                  CurrentRemainingTime? time) {
                                BlocProvider.of<WorkoutBloc>(context)
                                    .add(ImageEvent(index: currentindex));

                                if (time == null) {
                                  BlocProvider.of<Plan2Bloc>(context)
                                      .add(ImageSlideInitEvent());

                                  BlocProvider.of<PlanBloc>(context)
                                      .add(NullEvent());

                                  return Text('');
                                }
                                // print('alltimes min*********${alltimes}');

                                remainingTime = time;

                                WidgetsBinding.instance!
                                    .addPostFrameCallback((_) {
                                  alltimes[currentindex] = time;
                                });

                                print('alltimes min*********${alltimes}');
                                String min = time.min == null
                                    ? '0'
                                    : time.min.toString();

                                String sec = time.sec == null
                                    ? '0'
                                    : timeDisplay(time.sec as int);
                                return Text(
                                  '$min: $sec ',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                              endWidget: Text(''),
                              controller: tcontroller,
                              endTime: endtime.millisecondsSinceEpoch,
                            );
                          }
                          return Container();
                        }),
                        /*BlocListener<CalorieBloc,CalorieState>(child: Container(),listener: (_,state){
                       if(state is )
        
                      }),*/
                      ],
                    ),
                  ],
                ),
              ]),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int ind2 = 0; ind2 < widget.exs.length; ind2++)
                      Expanded(
                        child: Container(
                          child: LinearPercentIndicator(
                            animation: false,
                            lineHeight: 7.0,
                            animationDuration: 0,
                            percent: percents[ind2],
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.cyan,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.exs[currentindex].name}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    Column(
                      children: [
                        Text(
                          'Equipments needed',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        Text(
                          '[${widget.exs[currentindex].equipment}]',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${widget.exs[currentindex].description}',
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 140),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _showModal(remainingTime, currentindex);
                            },
                            icon: Icon(
                              Icons.pause,
                              size: 70,
                              color: Colors.cyan,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                      width: 300,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: _tapped ? Colors.grey : Colors.cyan,
                      ),
                      child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                              ),
                              Text('Next Exercise',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17)),
                              Container(
                                width: 70,
                              ),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                              )
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              _tapped = true;
                            });
                            Future.delayed(const Duration(milliseconds: 200),
                                () {
                              setState(() {
                                _tapped = false;
                                currentindex++;
                                DateTime dt = DateTime.now().add(Duration(
                                    minutes:
                                        widget.exs[currentindex].duration));
                                endtime = dt;
                              });
                            });

                            BlocProvider.of<Plan2Bloc>(context)
                                .add(ImageSlideInitEvent());

                            BlocProvider.of<WorkoutBloc>(context)
                                .add(ImageEvent(index: currentindex));
                            BlocProvider.of<Plan2Bloc>(context)
                                .add(ImageSlideEvent());

                            BlocProvider.of<CalorieBloc>(context)
                                .add(TimerEvent(index: currentindex));
                          })),
                  SizedBox(height: 20),
                ],
              ),
              BlocBuilder<WorkoutBloc, WorkoutState>(
                builder: (_, state) {
                  int tmin = remainingTime!.min == null
                      ? 0
                      : remainingTime!.min! as int;
                  int tsec = remainingTime!.sec == null
                      ? 0
                      : remainingTime!.sec as int;
                  double smin = tsec / 60;

                  double rmin = tmin + smin;
                  print(rmin);

                  if (state is ImageState) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      setState(() {
                        int duration = widget.exs[currentindex].duration;
                        // print(duration);
                        double rmin2 = duration - rmin;
                        // how does the null check works

                        double ratio = rmin2 / duration;
                        // print(ratio);
                        percents[currentindex] = ratio;
                      });
                    });
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 150,
              width: 150,
              child: CircularProgressIndicator(),
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get Ready...',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              )
            ],
          ),
        ],
      ));
    }
  }
}
