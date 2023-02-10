import 'package:firsstapp/FitnessApp/bloc/plans/food_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/food_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/food_state.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_event.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/log_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/log_event.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/progress_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/progress_bloc2.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/progress_event.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/progress_event2.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/progress_state.dart';
import 'package:firsstapp/FitnessApp/bloc/search/ExpanderBloc.dart';
import 'package:firsstapp/FitnessApp/bloc/search/expander_event.dart';
import 'package:firsstapp/FitnessApp/bloc/search/expander_state.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_bloc2.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_event.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_event2.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_state.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_state2.dart';
import 'package:firsstapp/FitnessApp/models/DailyLog.dart';
import 'package:firsstapp/FitnessApp/models/SearchFood.dart';
import 'package:firsstapp/FitnessApp/screens/plans/food_details.dart';
import 'package:firsstapp/FitnessApp/screens/plans/foodandwater/LogFood.dart';
import 'package:firsstapp/FitnessApp/screens/plans/foodandwater/circular_progress.dart';
import 'package:firsstapp/font/custom__icon_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_icons/animate_icons.dart';
import 'package:expandable/expandable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchFood extends StatefulWidget {
  GlobalKey<CircleProgressBarState> key3;
  GlobalKey<LogFoodState> key2;
  SearchFood({required this.key3, required this.key2});
  @override
  State<StatefulWidget> createState() {
    return _SearchFoodState();
  }
}

class _SearchFoodState extends State<SearchFood> {
  bool btap = false;
  bool ltap = false;
  bool stap = false;
  bool dtap = false;
  bool all = false;
  bool veg = false;
  bool sort = false;
  bool sbutton = false;
  double tx = 300;
  double ty = 0;

  int page = 0;
  String keyword = '';
  int type = 0;
  int count = 0;

  List<bool> visibles = [];
  late AnimateIconController controller;

  FaIcon emoji = FaIcon(FontAwesomeIcons.smileBeam);
  int serving = 1;

  int category = 1;

  List<AnimateIconController> iccontrollers = [];

  int buttonTapped = 1;
  bool _isVisible = false;
  bool _tapped = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimateIconController();
    BlocProvider.of<SearchBloc>(context).add(SearchInitEvent());
  }

  FaIcon de_emoji() {
    if (serving == 1 || serving == 2) {
      return FaIcon(
        FontAwesomeIcons.smileBeam,
        size: 35,
        color: Colors.cyan,
      );
    } else if (serving == 3 || serving == 4) {
      return FaIcon(
        FontAwesomeIcons.grinBeam,
        size: 35,
        color: Colors.cyan,
      );
    } else if (serving == 5 || serving == 6) {
      return FaIcon(
        FontAwesomeIcons.mehRollingEyes,
        size: 35,
        color: Colors.cyan,
      );
    } else if (serving == 7 || serving == 8) {
      return FaIcon(
        FontAwesomeIcons.frown,
        size: 35,
        color: Colors.cyan,
      );
    } else {
      return FaIcon(
        FontAwesomeIcons.angry,
        size: 35,
        color: Colors.cyan,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 90,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.search,
                color: Colors.cyan,
              ),
              Container(
                width: 5,
              ),
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 20, height: 1.5),
                  decoration: InputDecoration(
                      hintText: "Search by name or ingredient",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: InputBorder.none),
                  onChanged: (String keyword2) {
                    keyword = keyword2;
                    buttonTapped = 1;
                    setState(() {
                      _isVisible = false;
                    });
                    buttonTapped = 1;
                    if (keyword.isEmpty) {
                      SearchFModel sfm = SearchFModel(
                          page: 1,
                          keyword: keyword,
                          type: 0,
                          count: 0,
                          category: 0,
                          sort: sort);
                      BlocProvider.of<SearchBloc>(context)
                          .add(SearchFoodEvent(sfood: sfm, isempty: true));
                    } else {
                      count = 0;
                      type = 0;
                      if (btap) {
                        type += 1;
                        count++;
                      }
                      if (ltap) {
                        type += 2;
                        count++;
                      }
                      if (dtap) {
                        type += 4;
                        count++;
                      }
                      if (stap) {
                        type += 8;
                        count++;
                      }
                      if (veg) {
                        category = 2;
                      } else {
                        category = 1;
                      }
                      if (count == 4) {
                        type = 0;
                      }

                      SearchFModel sfm = SearchFModel(
                          page: 1,
                          keyword: keyword,
                          type: type,
                          count: count,
                          category: category,
                          sort: sort);
                      BlocProvider.of<SearchBloc>(context)
                          .add(SearchFoodEvent(sfood: sfm, isempty: false));
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.cyan,
                ),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (btap) {
                      btap = false;
                    } else {
                      btap = true;
                    }
                  });
                  count = 0;
                  type = 0;
                  if (btap) {
                    type += 1;
                    count++;
                  }
                  if (ltap) {
                    type += 2;
                    count++;
                  }
                  if (dtap) {
                    type += 4;
                    count++;
                  }
                  if (stap) {
                    type += 8;
                    count++;
                  }
                  if (veg) {
                    category = 2;
                  } else {
                    category = 1;
                  }
                  if (count == 4) {
                    type = 0;
                  }
                  setState(() {
                    _isVisible = false;
                  });
                  buttonTapped = 1;

                  SearchFModel sfm = SearchFModel(
                      page: 1,
                      keyword: keyword,
                      type: type,
                      count: count,
                      category: category,
                      sort: sort);
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchFoodEvent(sfood: sfm, isempty: false));
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: btap ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  child: Row(children: [
                    Icon(Custom_Icon.egg, color: Colors.cyan),
                    Text(
                      'Breakfast',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ]),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (ltap) {
                      ltap = false;
                    } else {
                      ltap = true;
                    }
                  });
                  count = 0;
                  type = 0;
                  if (btap) {
                    type += 1;
                    count++;
                  }
                  if (ltap) {
                    type += 2;
                    count++;
                  }
                  if (dtap) {
                    type += 4;
                    count++;
                  }
                  if (stap) {
                    type += 8;
                    count++;
                  }
                  if (veg) {
                    category = 2;
                  } else {
                    category = 1;
                  }
                  if (count == 4) {
                    type = 0;
                  }
                  setState(() {
                    _isVisible = false;
                  });
                  buttonTapped = 1;

                  SearchFModel sfm = SearchFModel(
                      page: 1,
                      keyword: keyword,
                      type: type,
                      count: count,
                      category: category,
                      sort: sort);
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchFoodEvent(sfood: sfm, isempty: false));
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: ltap ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  child: Row(children: [
                    Icon(Custom_Icon.cloud_meatball, color: Colors.cyan),
                    Text(
                      'Lunch',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ]),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (dtap) {
                      dtap = false;
                    } else {
                      dtap = true;
                    }
                  });
                  count = 0;
                  type = 0;
                  if (btap) {
                    type += 1;
                    count++;
                  }
                  if (ltap) {
                    type += 2;
                    count++;
                  }
                  if (dtap) {
                    type += 4;
                    count++;
                  }
                  if (stap) {
                    type += 8;
                    count++;
                  }
                  if (veg) {
                    category = 2;
                  } else {
                    category = 1;
                  }
                  if (count == 4) {
                    type = 0;
                  }
                  setState(() {
                    _isVisible = false;
                  });
                  buttonTapped = 1;

                  SearchFModel sfm = SearchFModel(
                      page: 1,
                      keyword: keyword,
                      type: type,
                      count: count,
                      category: category,
                      sort: sort);
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchFoodEvent(sfood: sfm, isempty: false));
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: dtap ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  child: Row(children: [
                    Icon(Custom_Icon.moon, color: Colors.cyan),
                    Text(
                      'Dinner',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ]),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (stap) {
                      stap = false;
                    } else {
                      stap = true;
                    }
                  });
                  setState(() {
                    _isVisible = false;
                  });
                  buttonTapped = 1;
                  count = 0;
                  type = 0;
                  if (btap) {
                    type += 1;
                    count++;
                  }
                  if (ltap) {
                    type += 2;
                    count++;
                  }
                  if (dtap) {
                    type += 4;
                    count++;
                  }
                  if (stap) {
                    type += 8;
                    count++;
                  }
                  if (veg) {
                    category = 2;
                  } else {
                    category = 1;
                  }
                  if (count == 4) {
                    type = 0;
                  }

                  SearchFModel sfm = SearchFModel(
                      page: 1,
                      keyword: keyword,
                      type: type,
                      count: count,
                      category: category,
                      sort: sort);
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchFoodEvent(sfood: sfm, isempty: false));
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: stap ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  width: 90,
                  child: Row(children: [
                    Icon(Custom_Icon.cookie, color: Colors.cyan),
                    Text(
                      'Snack',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (!all) {
                      all = true;
                      veg = false;
                    } else {
                      all = false;
                    }
                  });
                  count = 0;
                  type = 0;
                  if (btap) {
                    type += 1;
                    count++;
                  }
                  if (ltap) {
                    type += 2;
                    count++;
                  }
                  if (dtap) {
                    type += 4;
                    count++;
                  }
                  if (stap) {
                    type += 8;
                    count++;
                  }
                  if (veg) {
                    category = 2;
                  } else {
                    category = 1;
                  }
                  if (count == 4) {
                    type = 0;
                  }
                  setState(() {
                    _isVisible = false;
                  });
                  buttonTapped = 1;

                  SearchFModel sfm = SearchFModel(
                      page: 1,
                      keyword: keyword,
                      type: type,
                      count: count,
                      category: category,
                      sort: sort);
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchFoodEvent(sfood: sfm, isempty: false));
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: all ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  width: 90,
                  child: Row(children: [
                    Icon(Custom_Icon.food, color: Colors.cyan),
                    Text(
                      'All',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ]),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (!veg) {
                      all = false;
                      veg = true;
                    } else {
                      veg = false;
                    }
                  });
                  count = 0;
                  type = 0;
                  if (btap) {
                    type += 1;
                    count++;
                  }
                  if (ltap) {
                    type += 2;
                    count++;
                  }
                  if (dtap) {
                    type += 4;
                    count++;
                  }
                  if (stap) {
                    type += 8;
                    count++;
                  }
                  if (veg) {
                    category = 2;
                  } else {
                    category = 1;
                  }
                  if (count == 4) {
                    type = 0;
                  }
                  setState(() {
                    _isVisible = false;
                  });
                  buttonTapped = 1;

                  SearchFModel sfm = SearchFModel(
                      page: 1,
                      keyword: keyword,
                      type: type,
                      count: count,
                      category: category,
                      sort: sort);
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchFoodEvent(sfood: sfm, isempty: false));
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: veg ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  width: 150,
                  child: Row(children: [
                    Icon(Custom_Icon.seedling, color: Colors.cyan),
                    Text(
                      'Vegeterian',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (sort) {
                      sort = false;
                    } else {
                      sort = true;
                    }
                  });
                  count = 0;
                  type = 0;
                  if (btap) {
                    type += 1;
                    count++;
                  }
                  if (ltap) {
                    type += 2;
                    count++;
                  }
                  if (dtap) {
                    type += 4;
                    count++;
                  }
                  if (stap) {
                    type += 8;
                    count++;
                  }
                  if (veg) {
                    category = 2;
                  } else {
                    category = 1;
                  }
                  if (count == 4) {
                    type = 0;
                  }
                  setState(() {
                    _isVisible = false;
                  });
                  buttonTapped = 1;

                  SearchFModel sfm = SearchFModel(
                      page: 1,
                      keyword: keyword,
                      type: type,
                      count: count,
                      category: category,
                      sort: sort);
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchFoodEvent(sfood: sfm, isempty: false));
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: sort ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  width: 150,
                  child: Row(children: [
                    Icon(
                      Icons.sort,
                      color: Colors.cyan,
                    ),
                    Text(
                      'Sort by calories',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          BlocBuilder<SearchBloc, SearchState>(builder: (_, state) {
            /*if (state is SearchFoodLoad) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        _isvisible = true;
                        setState(() {
                          tx = 0;
                        });
                      });*/
            if (state is SearchFoodLoad) {
              return CircularProgressIndicator();
            }
            if (state is SearchFoodFail) {
              return Text(state.message);
            }
            if (state is SearchFoodSuccess) {
              // tx = 300;
              final sfr = state.sfoods;

              List foods = sfr.foods;
              List<ExpandableController> controllers = [];

              for (int i = 0; i < foods.length; i++) {
                controllers.add(ExpandableController());
              }
              for (int i = 0; i < foods.length; i++) {
                controllers[i].expanded = true;
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: foods.length,
                itemBuilder: (_, idx) {
                  for (int i = 0; i < foods.length; i++) {
                    visibles.add(false);
                    iccontrollers.add(AnimateIconController());
                  }
                  return Transform.translate(
                    offset: Offset(tx, ty),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0, color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Map<int, dynamic> map = {1: foods[idx]};
                              Navigator.pushNamed(
                                  context, FoodDetailScreen.routeName,
                                  arguments: map);
                            },
                            hoverColor: Colors.grey,
                            tileColor: Colors.white.withOpacity(0),
                            title: Text(
                              foods[idx].name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '${foods[idx].calories.round()} Kcal/average serving',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500),
                            ),
                            trailing: AnimateIcons(
                              startIcon: Icons.add,
                              endIcon: Icons.close,
                              controller: iccontrollers[idx],
                              size: 30.0,
                              onStartIconPress: () {
                                /*for (int i = 0; i < controllers.length; i++) {
                                        if (i != idx) {
                                          controllers[i].expanded = false;
                                        }
                                      }*/
                                WidgetsBinding.instance!
                                    .addPostFrameCallback((_) {
                                  setState(() {
                                    for (int i = 0; i < foods.length; i++) {
                                      visibles[i] = false;
                                      if (i != idx) {
                                        iccontrollers[i].animateToStart();
                                      }
                                    }
                                    visibles[idx] = true;
                                  });
                                });

                                return true;
                              },
                              onEndIconPress: () {
                                sbutton = false;
                                serving = 1;

                                WidgetsBinding.instance!
                                    .addPostFrameCallback((_) {
                                  setState(() {
                                    visibles[idx] = false;
                                  });
                                });
                                return true;
                              },
                              duration: Duration(milliseconds: 500),
                              startIconColor: Colors.cyan,
                              endIconColor: Colors.cyan,
                              clockwise: false,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Visibility(
                              visible: visibles[idx],
                              child: Column(children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Serving Size($serving)',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        de_emoji(),
                                        SliderTheme(
                                          data: SliderTheme.of(context)
                                              .copyWith(
                                                  thumbShape:
                                                      RoundSliderThumbShape(
                                                          enabledThumbRadius:
                                                              10.0),
                                                  thumbColor: Colors.cyan,
                                                  overlayShape:
                                                      RoundSliderOverlayShape(
                                                          overlayRadius: 25.0),
                                                  activeTrackColor: Colors.cyan,
                                                  inactiveTrackColor:
                                                      Colors.greenAccent),
                                          child: Slider(
                                            value: serving.toDouble(),
                                            min: 1,
                                            max: 10,
                                            onChanged: (double serv) {
                                              setState(() {
                                                serving = serv.toInt();
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          WidgetsBinding.instance!
                                              .addPostFrameCallback((_) {
                                            setState(() {
                                              sbutton = true;
                                            });
                                          });
                                          DailyLogModel dlog = DailyLogModel(
                                              name: foods[idx].name,
                                              calories:
                                                  foods[idx].calories * serving,
                                              category: foods[idx].category);

                                          BlocProvider.of<FoodBloc>(context)
                                              .add(DailyLog(dlog: dlog));
                                        },
                                        icon: Icon(
                                          Icons.check_circle,
                                          color: sbutton
                                              ? Colors.grey
                                              : Colors.cyan,
                                          size: 30,
                                        ))
                                  ],
                                ),
                                BlocBuilder<FoodBloc, FoodState>(
                                    builder: (_, state) {
                                  if (state is DailyPostProgress) {
                                    return CircularProgressIndicator();
                                  }
                                  if (state is DailyPostFailure) {
                                    return Text(state.message);
                                  }
                                  return Container();
                                }),
                                BlocListener<FoodBloc, FoodState>(
                                  child: Container(),
                                  listener: (_, state) {
                                    if (state is DailyPostSuccess) {
                                      serving = 1;
                                      sbutton = false;
                                      DailyLogModel dlog = state.dlog;

                                      BlocProvider.of<ProgressBloc2>(context)
                                          .add(setProgress2(
                                              calorie: dlog.calories));

                                      BlocProvider.of<FoodLogBloc>(context)
                                          .add(FoodLogLoad());
                                      WidgetsBinding.instance!
                                          .addPostFrameCallback((_) {
                                        setState(() {
                                          visibles[idx] = false;
                                          iccontrollers[idx].animateToStart();
                                        });
                                      });
                                    }
                                  },
                                )
                              ]),
                              // <-- Expands when tapped on the cover photo
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              );
            }
            return Container();
          }),
          BlocListener<SearchBloc, SearchState>(
              child: Container(),
              listener: (_, state) {
                if (state is SearchFoodSuccess) {
                  String next = state.sfoods.next_url;

                  BlocProvider.of<SearchBloc2>(context).add(SearchInitEvent2());

                  BlocProvider.of<SearchBloc2>(context)
                      .add(SearchFTranslate(sfood: state.sfoods));

                  Future.delayed(Duration(milliseconds: 500), () {
                    setState(() {
                      if (next.isEmpty) {
                        _isVisible = false;
                      } else {
                        _isVisible = true;
                      }
                    });
                  });
                }
              }),
          BlocListener<SearchBloc2, Search2>(
              child: Container(),
              listener: (_, state) {
                if (state is SearchFoodSuccess2) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    setState(() {
                      tx = 0;
                    });
                  });
                }
              }),
          SizedBox(
            height: 30,
          ),
          Visibility(
            visible: _isVisible,
            child: GestureDetector(
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
                      elevation: 29,
                      child: Container(
                        width: 50,
                      ),
                    ),
                    Text('Next results',
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
                buttonTapped++;
                if (keyword.isNotEmpty) {
                  setState(() {
                    _isVisible = false;
                  });
                  SearchFModel sfm = SearchFModel(
                      page: buttonTapped,
                      keyword: keyword,
                      type: type,
                      count: count,
                      category: category,
                      sort: sort);
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchFoodEvent(sfood: sfm, isempty: false));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
