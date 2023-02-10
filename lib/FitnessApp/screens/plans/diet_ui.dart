import 'package:firsstapp/FitnessApp/models/factor.dart';
import 'package:firsstapp/FitnessApp/screens/plans/goal_weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Activc = Colors.cyan;
const Inactivc = Colors.white;

const kLabelText = TextStyle(fontSize: 18.0, color: Colors.black);

class Diets {
  static const vegan = 1;
  static const vegetarian = 3;
  static const traditional = 2;
}

int selectDiet = Diets.vegetarian;

class Diet extends StatefulWidget {
  static const routeName = '/dietquestion';
  Factor factor;
  Diet({required this.factor});
  @override
  _Diet createState() => _Diet();
}

class _Diet extends State<Diet> {
  bool _tapped = false;
  @override
  Widget build(BuildContext context) {
    print(widget.factor.age);
    print(widget.factor);
    print(widget.factor.gender);
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
                  Text("What is your", style: TextStyle(fontSize: 35)),
                  Text("Diet preference?", style: TextStyle(fontSize: 35)),
                ],
              )),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ReusableContainer(
                        contColor:
                            selectDiet == Diets.vegan ? Activc : Inactivc,
                        otp: () {
                          setState(() {
                            selectDiet = Diets.vegan;
                          });
                        },
                        customChild: Container(
                          child: Center(
                              child: Text(
                            "Vegan",
                            style: TextStyle(fontSize: 25),
                          )),
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableContainer(
                        contColor:
                            selectDiet == Diets.vegetarian ? Activc : Inactivc,
                        otp: () {
                          setState(() {
                            selectDiet = Diets.vegetarian;
                          });
                        },
                        customChild: Container(
                          child: Center(
                              child: Text(
                            "Vegetarian",
                            style: TextStyle(fontSize: 25),
                          )),
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableContainer(
                        contColor:
                            selectDiet == Diets.traditional ? Activc : Inactivc,
                        otp: () {
                          setState(() {
                            selectDiet = Diets.traditional;
                          });
                        },
                        customChild: Container(
                          child: Center(
                              child: Text(
                            "Traditional",
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
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                        setState(() {
                          _tapped = true;
                        });
              
                        Future.delayed(const Duration(milliseconds: 100), () {
                          setState(() {
                            _tapped = false;
                          });
                        });
                        widget.factor.diet = selectDiet;
                        Navigator.of(context).pushNamed(GoalWeight.routeName,
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
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            
              SizedBox(
                height: 40,
              ),
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
