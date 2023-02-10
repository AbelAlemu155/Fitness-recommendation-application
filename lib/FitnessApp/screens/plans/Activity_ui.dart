import 'package:firsstapp/FitnessApp/models/factor.dart';
import 'package:firsstapp/FitnessApp/screens/plans/weight_height_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'goal_ui.dart';

const Activc = Colors.cyan;
const Inactivc = Colors.white;

const kLabelText = TextStyle(fontSize: 18.0, color: Colors.black);

class Act {
  static const low = 1;
  static const medium = 2;
  static const high = 3;
  static const veryHigh = 4;
}

int selectAct = Act.medium;

class Activity extends StatefulWidget {
  static const routeName = '/activityquestion';
  Factor factor;
  @override
  _Activity createState() => _Activity();
  Activity({required this.factor});
}

class _Activity extends State<Activity> {
  bool _tapped = false;
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
                  Text("How Active ", style: TextStyle(fontSize: 35)),
                  Text("are you?", style: TextStyle(fontSize: 35)),
                ],
              )),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ReusableContainer(
                        contColor: selectAct == Act.low ? Activc : Inactivc,
                        otp: () {
                          setState(() {
                            selectAct = Act.low;
                          });
                        },
                        customChild: Container(
                          child: Center(
                              child: Text(
                            "At office all day",
                            style: TextStyle(fontSize: 25),
                          )),
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableContainer(
                        contColor: selectAct == Act.medium ? Activc : Inactivc,
                        otp: () {
                          setState(() {
                            selectAct = Act.medium;
                          });
                        },
                        customChild: Container(
                          child: Center(
                              child: Text(
                            "Just walking",
                            style: TextStyle(fontSize: 25),
                          )),
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableContainer(
                        contColor: selectAct == Act.high ? Activc : Inactivc,
                        otp: () {
                          setState(() {
                            selectAct = Act.high;
                          });
                        },
                        customChild: Container(
                          child: Center(
                              child: Text(
                            "Moderate gym goer",
                            style: TextStyle(fontSize: 25),
                          )),
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableContainer(
                        contColor:
                            selectAct == Act.veryHigh ? Activc : Inactivc,
                        otp: () {
                          setState(() {
                            selectAct = Act.veryHigh;
                          });
                        },
                        customChild: Container(
                          child: Center(
                              child: Text(
                            "Everyday gymgoer",
                            style: TextStyle(fontSize: 25),
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
                  widget.factor.activity = selectAct;
                  Navigator.pushNamed(context, GWH.routeName,
                      arguments: widget.factor);
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
              // GestureDetector(
              //   onTap: (){
              //
              //   },
              //   child: Container(
              //       child: Center(child: Text("Next", style:TextStyle(fontSize: 25),)),
              //       height: 75.0,
              //       width: double.infinity,
              //       color: Colors.cyan,
              //       // margin: EdgeInsets.only(top: 18.0),
              //       margin: EdgeInsets.all(18)
              //   ),
              // ),
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
