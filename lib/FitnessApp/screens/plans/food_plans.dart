import 'package:cached_network_image/cached_network_image.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_state.dart';
import 'package:firsstapp/FitnessApp/models/MealPlan.dart';
import 'package:firsstapp/FitnessApp/models/factor.dart';
import 'package:firsstapp/FitnessApp/screens/login_screen.dart';
import 'package:firsstapp/FitnessApp/screens/plans/food_details.dart';
import 'package:firsstapp/FitnessApp/screens/plans/workout_plans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class FoodPlansScreen extends StatefulWidget {
  static const routeName = '/foodplansscreen';
  @override
  State<StatefulWidget> createState() {
    return FoodPlansState();
  }
}

class FoodPlansState extends State<FoodPlansScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  var firstmap = LoginScreen.box.read('firstday');
  var lastmap = LoginScreen.box.read('lastday');
  double elevation = 10;
  double elevation2 = 10;
  double elevation3 = 10;
  double elevation4 = 10;

  String catToString(int cat) {
    if (cat == 1) {
      return 'Traditional';
    } else if (cat == 2) {
      return 'Vegeterian';
    }
    return 'unknown';
  }

  void initState() {
    super.initState();
    double elevation = 10;
    double elevation2 = 10;
    double elevation3 = 10;
    double elevation4 = 10;
  }

  @override
  Widget build(BuildContext context) {
    int month = firstmap['month'] as int;

    int day = firstmap['day'] as int;
    //  int day = 8;
    int year = firstmap['year'] as int;
    // int year = 2021;
    DateTime firstday = DateTime.utc(year, month, day);

    DateTime lastday = firstday.add(Duration(days: 14));

    //int month2 = lastmap['month'] as int;
    //int day2 = lastmap['day'] as int;
    // int year2 = lastmap['year'] as int;
    // DateTime lastday = DateTime.utc(year2, month2, day2);

    //to be changed!!!!!!

    return Scaffold(
      appBar: AppBar(
        title: Text('Plans'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              calendarFormat: _calendarFormat,
              firstDay: firstday,
              lastDay: lastday,
              focusedDay: _focusedDay,
              calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  todayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 1,
                          ),
                          color: Color.fromRGBO(242, 241, 239, 1),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.black),
                      ))),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(8.0)),
                selectedDecoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8.0)),
                todayTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    color: Colors.white),
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    elevation = 10;
                    elevation2 = 10;
                    elevation3 = 10;
                    elevation4 = 10;
                  });
                }

                int diff = _selectedDay.difference(firstday).inDays;
                print(diff);

                BlocProvider.of<PlanBloc>(context)
                    .add(UserFoodLoadEvent(index: diff));
              },
            ),
            SizedBox(
              height: 40,
            ),
            BlocBuilder<PlanBloc, PlanState>(builder: (_, state) {
              if (state is UserFoodLoadProgress) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                );
              }
              if (state is UserFoodLoadFailure) {
                return Text(state.message);
              }
              if (state is UserFoodLoadSuccess) {
                final dailymeal = state.mealPlans;
                if (dailymeal.length != 0) {
                  return Column(
                    children: [
                      Container(
                        height: 200,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              elevation = 0;
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                setState(() {
                                  elevation = 10;
                                  elevation2 = 10;
                                  elevation3 = 10;
                                  elevation4 = 10;
                                });
                                Map<int, dynamic> bmap = {1: dailymeal[0]};
                                Navigator.pushNamed(
                                    context, FoodDetailScreen.routeName,
                                    arguments: bmap);
                              });
                            });
                          },
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 0, 10, 0),
                                                height: 100,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      dailymeal[0].image_url,
                                                ),
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Breakfast',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontFamily: "Mon",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      dailymeal[0].name,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontFamily: "Mon"),
                                                    ),
                                                    Text(
                                                        'Calories: ${dailymeal[0].calories}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontFamily: "Mon")),
                                                    Text(
                                                        'Categories: ${catToString(dailymeal[0].category)}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontFamily: "Mon"))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                            elevation: elevation,
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              elevation2 = 0;
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                setState(() {
                                  elevation = 10;
                                  elevation2 = 10;
                                  elevation3 = 10;
                                  elevation4 = 10;
                                });
                                Map<int, dynamic> lmap = {2: dailymeal[1]};
                                Navigator.pushNamed(
                                    context, FoodDetailScreen.routeName,
                                    arguments: lmap);
                              });
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 0, 10, 0),
                                                height: 100,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      dailymeal[1].image_url,
                                                ),
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Lunch',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontFamily: "Mon",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      dailymeal[1].name,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontFamily: "Mon"),
                                                    ),
                                                    Text(
                                                        'Calories: ${dailymeal[1].calories}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontFamily: "Mon")),
                                                    Text(
                                                        'Categories: ${catToString(dailymeal[1].category)}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontFamily: "Mon"))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                            elevation: elevation2,
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              elevation3 = 0;
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                setState(() {
                                  elevation = 10;
                                  elevation2 = 10;
                                  elevation3 = 10;
                                  elevation4 = 10;
                                });
                                Map<int, dynamic> lmap = {3: dailymeal[2]};
                                Navigator.pushNamed(
                                    context, FoodDetailScreen.routeName,
                                    arguments: lmap);
                              });
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 0, 10, 0),
                                                height: 100,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      dailymeal[2].image_url,
                                                ),
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Dinner',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontFamily: "Mon",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      dailymeal[2].name,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontFamily: "Mon"),
                                                    ),
                                                    Text(
                                                        'Calories: ${dailymeal[2].calories}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontFamily: "Mon")),
                                                    Text(
                                                        'Categories: ${catToString(dailymeal[2].category)}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontFamily: "Mon"))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                            elevation: elevation3,
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              elevation4 = 0;
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                setState(() {
                                  elevation = 10;
                                  elevation2 = 10;
                                  elevation3 = 10;
                                  elevation4 = 10;
                                });
                                Map<int, dynamic> smap = {4: dailymeal[3]};
                                Navigator.pushNamed(
                                    context, FoodDetailScreen.routeName,
                                    arguments: smap);
                              });
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 0, 10, 0),
                                                height: 100,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      dailymeal[3].image_url,
                                                ),
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Snack',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontFamily: "Mon",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      dailymeal[3].name,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontFamily: "Mon"),
                                                    ),
                                                    Text(
                                                        'Calories: ${dailymeal[3].calories}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontFamily: "Mon")),
                                                    Text(
                                                        'Categories: ${catToString(dailymeal[3].category)}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                            fontFamily: "Mon"))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                            elevation: elevation4,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
              return Text('');
            })
          ],
        ),
      ),
    );
  }
}
