import 'package:firsstapp/FitnessApp/models/factor.dart';
import 'package:firsstapp/FitnessApp/screens/plans/Activity_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'diet_ui.dart';

const Activc = Colors.cyan;
const Inactivc = Colors.white;

const kLabelText = TextStyle(fontSize: 18.0, color: Colors.black);

class Goals {
  static const loseWeight = 1;
  static const bulkUp = 3;
  static const maintainWeight = 2;
  static const forEndurance = 4;
}

int selectGoal = Goals.bulkUp;

class Goal extends StatefulWidget {
  static const routeName = '/goalquestion';
  @override
  _Goal createState() => _Goal();
}

class _Goal extends State<Goal> {
  bool _tapped = false;
  Factor factors = Factor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.cyan),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Text("What is ", style: TextStyle(fontSize: 35)),
                  Text("your goal?", style: TextStyle(fontSize: 35)),
                ],
              )),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ReusableContainer(
                        contColor:
                            selectGoal == Goals.loseWeight ? Activc : Inactivc,
                        otp: () {
                          setState(() {
                            selectGoal = Goals.loseWeight;
                          });
                        },
                        customChild: Container(
                          child: Center(
                              child: Text(
                            "Lose Weight",
                            style: TextStyle(fontSize: 25),
                          )),
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableContainer(
                        contColor:
                            selectGoal == Goals.bulkUp ? Activc : Inactivc,
                        otp: () {
                          setState(() {
                            selectGoal = Goals.bulkUp;
                          });
                        },
                        customChild: Container(
                          child: Center(
                              child: Text(
                            "Bulk Up",
                            style: TextStyle(fontSize: 20),
                          )),
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableContainer(
                        contColor: selectGoal == Goals.maintainWeight
                            ? Activc
                            : Inactivc,
                        otp: () {
                          setState(() {
                            selectGoal = Goals.maintainWeight;
                          });
                        },
                        customChild: Container(
                          child: Center(
                              child: Text(
                            "Maintain Weight",
                            style: TextStyle(fontSize: 20),
                          )),
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableContainer(
                        contColor: selectGoal == Goals.forEndurance
                            ? Activc
                            : Inactivc,
                        otp: () {
                          setState(() {
                            selectGoal = Goals.forEndurance;
                          });
                        },
                        customChild: Container(
                          child: Center(
                              child: Text(
                            "Maximize endurance",
                            style: TextStyle(fontSize: 20),
                          )),
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    factors.goal = selectGoal;
                  });
                  print('********** ${factors.goal}');
                  Navigator.pushNamed(context, Activity.routeName,
                      arguments: factors);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 30.0, right: 20),
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.cyanAccent,
                    color: _tapped ? Colors.cyan.withOpacity(0.6) : Colors.cyan,
                    elevation: 4.0,
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontFamily: "Mon",
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ));
  }
}

class ReusableContainer extends StatelessWidget {
  ReusableContainer({
    required this.contColor,
    this.customChild,
    this.otp,
  });
  final Color contColor;
  final Widget? customChild;
  final Function()? otp;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: otp,
      child: Container(
        child: customChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: contColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
