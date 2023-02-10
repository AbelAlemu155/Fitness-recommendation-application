import 'package:firsstapp/FitnessApp/bloc/user_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/user_event.dart';
import 'package:firsstapp/FitnessApp/bloc/user_state.dart';
import 'package:firsstapp/FitnessApp/bloc/userdata/ud_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/userdata/ud_event.dart';
import 'package:firsstapp/FitnessApp/bloc/userdata/ud_state.dart';
import 'package:firsstapp/FitnessApp/screens/login_screen.dart';
import 'package:firsstapp/FitnessApp/screens/plans/goal_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/UserProfileScreen';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  final email = LoginScreen.box.read('username');
  bool _tapped = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<UserBloc>(context).add(UserByEmail(email: email));
    BlocProvider.of<UdBloc>(context).add(UdLoadEvent(email: email));
  }

  String goalToMessage(int g) {
    if (g == 1) {
      return 'WeightLoss';
    } else if (g == 2) {
      return 'Maintaining Weight';
    } else {
      return 'Mucle Gain';
    }
  }

  String flevelTOmessage(int fl) {
    if (fl == 1) {
      return 'Never Exercised';
    } else if (fl == 2) {
      return 'Beginner';
    } else if (fl == 3) {
      return 'Intermediate';
    } else if (fl == 4) {
      return 'Fit';
    } else {
      return 'Very Fit';
    }
  }

  String aclToMessage(int acl) {
    if (acl == 1) {
      return 'Sedentary';
    } else if (acl == 2) {
      return 'Just Walking';
    } else if (acl == 3) {
      return 'Moderate Exercises';
    } else {
      return 'Intense Exercise';
    }
  }

  String RoleMessage(String res) {
    if (res.startsWith('A')) {
      return 'an' + res;
    } else {
      return 'a' + res;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (_, state) {
              if (state is UserByEmailLoad) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is UserByEmailFail) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is UserByEmailSuccess) {
                print(state.user.member_since);
                final pos = state.user.member_since.lastIndexOf(' ');
                String res1 = (pos != -1)
                    ? state.user.member_since.substring(0, pos)
                    : state.user.member_since;

                final pos3 = res1.lastIndexOf(':');
                String res3 = (pos3 != -1) ? res1.substring(0, pos3) : res1;

                return Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage(state.user.image_url)),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(email,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('You are ' + RoleMessage(state.user.role),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Since $res3 ',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
          SizedBox(
            height: 40,
          ),
          BlocBuilder<UdBloc, UdState>(
            builder: (_, state) {
              if (state is UdLoadProgress) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UdLoadFail) {
                return Center(child: Text(state.message));
              }
              if (state is UdLoadSuccess) {
                String goalm = goalToMessage(state.factor.goal);
                String acm = aclToMessage(state.factor.activity);
                String flm = flevelTOmessage(state.factor.fitnessLevel);
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Height  ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Text(
                              '${state.factor.height.toString()} cm',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          height: 20,
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Text('Weight  ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Text(
                              '${state.factor.weight.toString()} kg',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          height: 20,
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Text('Goal  ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Text(
                              goalm,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          height: 20,
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Text('Goal Weight  ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Text('${state.factor.goalWeight.toString()} kg',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          height: 20,
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Text('Level of Activity  ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Text(acm, style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          height: 20,
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Text('Fitness Level  ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Text(flm, style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          height: 20,
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
          SizedBox(
            height: 40,
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
                  Text('Recreate My Plan',
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

              Navigator.pushNamed(context, Goal.routeName);
            },
          ),
          SizedBox(
            height: 40,
          )
        ],
      )),
    );
  }
}
