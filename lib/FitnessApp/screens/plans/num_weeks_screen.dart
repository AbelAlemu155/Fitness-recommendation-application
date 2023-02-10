import 'package:firsstapp/FitnessApp/models/factor.dart';
import 'package:firsstapp/FitnessApp/screens/plans/num_workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Activc = Colors.cyan;
const Inactivc = Colors.white;

const kLabelText = TextStyle(fontSize: 18.0, color: Colors.black);





class NumWeeks extends StatefulWidget {
  static const routeName = '/numweeksscreen';
  Factor factor;
  NumWeeks({required this.factor});
  @override
  _NumWstate createState() => _NumWstate();
}

class _NumWstate extends State<NumWeeks> {
  bool _disabled = true;
  bool _tapped = false;
  int numweeks = 0;
  final controller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.factor.goalWeight);
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
                  Text("For how many weeks", style: TextStyle(fontSize: 35)),
                  Text("do you want a plan", style: TextStyle(fontSize: 35)),
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
                          width: 200,
                          child: TextField(
                              style: TextStyle(fontSize: 50, height: 1.5),
                              textAlign: TextAlign.center,
                              cursorHeight: 70,
                              cursorColor: Colors.cyan,
                              onChanged: (text) {
                                if (text != null) {
                                  int val = int.parse(text);
                                  if (val > 1 && val < 5) {
                                    setState(() {
                                      _disabled = false;
                                      numweeks = val;
                                    });
                                  } else {
                                    setState(() {
                                      _disabled = true;
                                    });
                                  }
                                }
                              },
                              controller: controller1,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              maxLength: 5,
                              decoration: InputDecoration(
                                counterText: "",
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.only(left: 30.0, right: 20),
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.cyanAccent,
                  color: _tapped ? Colors.cyan.withOpacity(0.6) : Colors.cyan,
                  elevation: 4.0,
                  child: GestureDetector(
                    onTap: _disabled
                        ? null
                        : () {
                            setState(() {
                              _tapped = true;
                            });

                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              setState(() {
                                _tapped = false;
                              });
                            });
                            widget.factor.numWeeksGoals = numweeks;
                            Navigator.of(context).pushNamed(NumDays.routeName,
                                arguments: widget.factor);
                          },
                    child: Center(
                      child: Text(
                        "NEXT",
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
