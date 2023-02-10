import 'package:firsstapp/FitnessApp/bloc/plans/food_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/food_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/food_state.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_state.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_state.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/log_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/log_event.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/log_state.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/progress_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/progress_bloc2.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/progress_event.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/progress_state.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/progress_state2.dart';
import 'package:firsstapp/FitnessApp/models/DailyLog.dart';
import 'package:firsstapp/FitnessApp/screens/plans/weight_height_ui.dart';
import 'package:firsstapp/FitnessApp/screens/search/search_food.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'circular_progress.dart';

class LogFoodScreen extends StatefulWidget {
  static const routeName = '/logFoodScreen22';
  Map pvalue;
  LogFoodScreen({required this.pvalue});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LogFoodState();
  }
}

class LogFoodState extends State<LogFoodScreen> {
  late GlobalKey<LogFoodState> key2;
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final _formKey2 = GlobalKey<FormState>();
  bool _visible = false;
  bool _tapped = false;
  bool _logbutton = false;
  Map<String, dynamic> userdata = {};
  int val = -1;
  Widget _animatedWidget = Text('');
  int index = 1;
  ScrollController _scrollController = ScrollController();
  int food = 0;
  int rfood = 0;

  double cpercent = 0;
  CircleProgressBar? cpbar;
  final key = GlobalKey<CircleProgressBarState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    key2 = GlobalKey<LogFoodState>();
    food = widget.pvalue[1].food.round();
    rfood = widget.pvalue[1].rfood.round();
    val = 1;

    cpercent = food / rfood;
    cpbar = CircleProgressBar(
        key: key, foregroundColor: Colors.cyan, value: cpercent, begin: 0);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buttonWidget;
    Widget _secondWidget = Container(
        color: _tapped ? Colors.grey : Colors.cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _tapped = true;
                });
                Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    _tapped = false;
                  });
                  _showmodal(context);
                });
              },
              icon: Icon(Icons.add_box),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    _tapped = true;
                  });
                  Future.delayed(const Duration(milliseconds: 400), () {
                    setState(() {
                      _tapped = false;
                    });
                  });

                  _showmodal2(context);
                },
                icon: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  setState(() {
                    _tapped = true;
                  });
                  Future.delayed(const Duration(milliseconds: 400), () {
                    setState(() {
                      _tapped = false;
                    });
                  });
                  BlocProvider.of<Plan2Bloc>(context)
                      .add(AnimatorEvent(index: 2));
                },
                icon: Icon(Icons.close))
          ],
        ));

    _buttonWidget = ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity,
              30), // double.infinity is the width and 30 is the height
        ),
        onPressed: () {
          BlocProvider.of<Plan2Bloc>(context).add(AnimatorEvent(index: 1));
        },
        child: Text('Add Food'));

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      key: key2,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                      height: 200,
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.only(top: 150),
                      child: cpbar),
                  Positioned(
                    right: 140.0,
                    top: 140.0,
                    child: Text('$food/$rfood Kcal',
                        style: TextStyle(fontSize: 17)),
                  )
                ],
              ),
            ),
            AnimatedSwitcher(
                child: _animatedWidget, duration: Duration(seconds: 1)),
            BlocBuilder<Plan2Bloc, Plan2State>(builder: (_, state) {
              // print(state.runtimeType);
              if (state is AnimatorClose) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  setState(() {
                    _animatedWidget = _buttonWidget;
                  });
                });
              }
              if (state is AnimatorChange) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  setState(() {
                    _animatedWidget = _secondWidget;
                  });
                });
              }
              if (state is DraggableState) {
                return Text('');
              }
              return Text('');
            }),
            BlocBuilder<FoodLogBloc, LogState>(builder: (_, state) {
              if (state is FoodLoadProgress2) {
                return Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    CircularProgressIndicator()
                  ],
                );
              }
              if (state is FoodLoadFailure2) {
                return Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(state.message)
                  ],
                );
              }
              if (state is FoodLoadSuccess2) {
                final List<DailyLogModel> lfs = state.dlogs;
                List<DailyLogModel> lfs1 = [];
                List<DailyLogModel> lfs2 = [];
                List<DailyLogModel> lfs3 = [];
                List<DailyLogModel> lfs4 = [];

                lfs.forEach((element) {
                  if (element.category == 1) {
                    lfs1.add(element);
                  } else if (element.category == 2) {
                    lfs2.add(element);
                  } else if (element.category == 3) {
                    lfs3.add(element);
                  } else if (element.category == 4) {
                    lfs4.add(element);
                  }
                });

                return Column(children: [
                  if (lfs1.length != 0)
                    Text(
                      'Breakfast',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  for (int i = 0; i < lfs1.length; i++)
                    SizedBox(
                      child: ListTile(
                        title: Text(lfs1[i].name),
                        trailing:
                            Text('${lfs1[i].calories.toString()} calories'),
                      ),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  if (lfs2.length != 0)
                    Text(
                      'Lunch',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  for (int i = 0; i < lfs2.length; i++)
                    SizedBox(
                      child: ListTile(
                        title: Text(lfs2[i].name),
                        trailing:
                            Text('${lfs2[i].calories.toString()} calories'),
                      ),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  if (lfs3.length != 0)
                    Text(
                      'Dinner',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  for (int i = 0; i < lfs3.length; i++)
                    SizedBox(
                      child: ListTile(
                        title: Text(lfs3[i].name),
                        trailing:
                            Text('${lfs3[i].calories.toString()} calories'),
                      ),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  if (lfs4.length != 0)
                    Text(
                      'Snack',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  for (int i = 0; i < lfs4.length; i++)
                    SizedBox(
                      child: ListTile(
                        title: Text(lfs4[i].name),
                        trailing:
                            Text('${lfs4[i].calories.toString()} calories'),
                      ),
                    ),

                  /*  Expanded(
                          child: ListView.builder(
                              itemCount: lfs1.length,
                              itemBuilder: (_, idx) {
                                return Expanded(
                                  child: ListTile(
                                    title: Text(lfs1[idx].name),
                                    subtitle: Text(lfs1[idx].calories.toString()),
                                  ),
                                );
                              }),
                        ),*/
                ]);
              }
              return Text('');
            })
          ],
        ),
      ),
    );
  }

  void _showmodal2(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white.withOpacity(0),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState2) {
            return Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.4),
                border: Border.all(color: Colors.cyan),
                borderRadius: BorderRadius.circular(20.0),
              ),
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(children: [
                  BlocListener<ProgressBloc2, ProgressState2>(
                    listener: (_, state) {
                      print(state.runtimeType);
                      if (state is setProgressState2) {
                        print('yesssssssssssssss');
                        BlocProvider.of<FoodLogBloc>(context).add(FoodLogLoad());
              
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          double begin = state.calorie / rfood;
              
                          setState(() {
                            food += state.calorie.round();
                            cpercent = food / rfood;
                          });
              
                          double beginValue = key.currentState!.valueTween!
                              .evaluate(key.currentState!.controller);
              
                          // Update the value tween.
                          key.currentState!.valueTween = Tween<double>(
                            begin: beginValue,
                            end: this.cpercent,
                          );
              
                          key.currentState!.controller
                            ..value = 0
                            ..forward();
                        });
                        BlocProvider.of<PlanBloc>(context)
                            .add(FoodAndWaterEvent());
                      }
                    },
                    child: Container(),
                  ),
                  SearchFood(
                    key3: key,
                    key2: key2,
                  ),
                ]),
              ),
            );
          });
        });
  }

  void _showmodal(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 10,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.cyan),
                borderRadius: BorderRadius.circular(20.0),
              ),
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Icon(Icons.drag_handle_sharp, size: 50),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            'Add Food',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Mon"),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            color: Colors.cyan,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.cancel_sharp))
                      ],
                    ),
                    Form(
                        key: _formKey2,
                        child: Column(children: [
                          Row(children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 24, 0),
                              padding: EdgeInsets.only(top: 20),
                              child: Text('Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Mon',
                                      color: Colors.cyan,
                                      fontSize: 17.0)),
                            ),
                            Expanded(
                              child: Container(
                                child: TextFormField(
                                  style: TextStyle(fontSize: 25, height: 1.5),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter name of the food';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      this.userdata["name"] = value;
                                    });
                                  },
                                  cursorColor: Colors.cyan,
                                  onChanged: (text) {},
                                  controller: controller1,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(fontSize: 20),
                                    contentPadding: EdgeInsets.all(0),
                                    hintText: 'Name of the food',
                                    labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Mon',
                                        color: Colors.cyan,
                                        fontSize: 15.0),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 24, 0),
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text('Calories',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Mon',
                                          color: Colors.cyan,
                                          fontSize: 17.0)),
                                ),
                                Expanded(
                                  child: Container(
                                    child: TextFormField(
                                      style:
                                          TextStyle(fontSize: 25, height: 1.5),
                                      cursorColor: Colors.cyan,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter calories';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          this.userdata["calories"] =
                                              double.parse(value as String);
                                        });
                                      },
                                      onChanged: (text) {},
                                      controller: controller2,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(fontSize: 20),
                                        hintText: 'Enter number in KCal',
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Mon',
                                            color: Colors.cyan,
                                            fontSize: 15.0),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                          RadioListTile(
                            value: 1,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value as int;
                              });
                            },
                            title: Text("Breakfast"),
                          ),
                          RadioListTile(
                            value: 2,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value as int;
                              });
                            },
                            title: Text("Lunch"),
                          ),
                          RadioListTile(
                            value: 3,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value as int;
                              });
                            },
                            title: Text("Dinner"),
                          ),
                          RadioListTile(
                            value: 4,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value as int;
                              });
                            },
                            title: Text("Snack"),
                          ),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints.tightFor(width: 300, height: 40),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.cyan)))),
                                onPressed: () {
                                  if (_formKey2.currentState!.validate()) {
                                    _formKey2.currentState!.save();

                                    DailyLogModel dlog = DailyLogModel(
                                        name: userdata['name'],
                                        calories: userdata['calories'],
                                        category: val);

                                    BlocProvider.of<FoodBloc>(context)
                                        .add(DailyLog(dlog: dlog));

                                    setState(() {
                                      _visible = true;
                                    });
                                    WidgetsBinding.instance!
                                        .addPostFrameCallback((_) {
                                      _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease);
                                    });
                                  }
                                },
                                child: Text(
                                  'Log Food',
                                  style: TextStyle(fontSize: 20),
                                )),
                          )
                        ])),
                    if (_visible)
                      SizedBox(
                        height: 40,
                      ),
                    BlocBuilder<FoodBloc, FoodState>(builder: (_, state) {
                      if (state is DailyPostProgress) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        );
                      }
                      if (state is DailyPostFailure) {
                        return Column(children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            state.message,
                            style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ]);
                      }

                      return Text('');
                    }),
                    BlocListener<FoodBloc, FoodState>(
                      listener: (context, state) {
                        if (state is DailyPostSuccess) {
                          DailyLogModel dlog = state.dlog;

                          /* WidgetsBinding.instance!.addPostFrameCallback((_) {
                          Navigator.of(context).pop();
                        });*/

                          // Navigator.of(context).pop();

                          BlocProvider.of<ProgressBloc>(context)
                              .add(setProgress(calorie: dlog.calories));

                          //Navigator.of(context).pop();
                        }
                      },
                      child: Container(),
                    ),
                    BlocListener<ProgressBloc, ProgressState>(
                      listener: (context, state) {
                        print('*****************${state.runtimeType}');
                        if (state is setProgressState) {
                          print('yesssssssssssssss');
                          BlocProvider.of<FoodLogBloc>(context)
                              .add(FoodLogLoad());

                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            double begin = state.calorie / rfood;

                            setState(() {
                              food += state.calorie.round();
                              cpercent = food / rfood;
                            });

                            double beginValue = key.currentState!.valueTween!
                                .evaluate(key.currentState!.controller);

                            // Update the value tween.
                            key.currentState!.valueTween = Tween<double>(
                              begin: beginValue,
                              end: this.cpercent,
                            );

                            key.currentState!.controller
                              ..value = 0
                              ..forward();
                          });
                          BlocProvider.of<PlanBloc>(context)
                              .add(FoodAndWaterEvent());
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}
