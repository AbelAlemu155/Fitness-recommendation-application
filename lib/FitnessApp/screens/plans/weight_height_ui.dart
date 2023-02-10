import 'package:firsstapp/FitnessApp/models/factor.dart';
import 'package:firsstapp/FitnessApp/screens/plans/diet_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Activity_ui.dart';

const Activc = Colors.cyan;
const Inactivc = Colors.white;

class Gender {
  static const String male = 'M';
  static const String female = 'F';
}

String selectedGender = Gender.male;

const kLabelText = TextStyle(fontSize: 18.0, color: Colors.black);
const kNumberText = TextStyle(
  fontSize: 45.0,
  fontWeight: FontWeight.bold,
);

double height = 170;
double weight = 60;
int age = 18;

class GWH extends StatefulWidget {
  static const routeName = '/generalquestion';
  Factor factor;
  GWH({required this.factor});

  @override
  _GWH createState() => _GWH();
}

class _GWH extends State<GWH> {
  bool _tapped = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.cyan),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: ReusableContainer(
                    contColor:
                        selectedGender == Gender.male ? Activc : Inactivc,
                    otp: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    customChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.mars,
                          size: 75,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Male",
                          style: kLabelText,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: ReusableContainer(
                  contColor:
                      selectedGender == Gender.female ? Activc : Inactivc,
                  otp: () {
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                  customChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.venus,
                        size: 75,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Female",
                        style: kLabelText,
                      ),
                    ],
                  ),
                )),
              ],
            ),

            Row(
              children: <Widget>[
                Expanded(
                    child: ReusableContainer(
                  contColor: Colors.white,
                  customChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Select HEIGHT",
                        style: kLabelText,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: TextField(
                                style: TextStyle(fontSize: 50, height: 1.5),
                                textAlign: TextAlign.center,
                                cursorHeight: 70,
                                cursorColor: Colors.cyan,
                                onChanged: (text) {
                                  if (text != null) {
                                    double val = double.parse(text);
                                    if (val > 30) {
                                      setState(() {
                                        height = val;
                                      });
                                    }
                                  }
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLength: 5,
                                decoration: InputDecoration(
                                  counterText: "",
                                )),
                          ),
                          Text(
                            'CM',
                            style: kLabelText,
                          )
                        ],
                      ),
                    ],
                  ),
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: ReusableContainer(
                  contColor: Colors.white,
                  customChild: Column(
                    children: <Widget>[
                      Text(
                        "Weight",
                        style: kLabelText,
                      ),
                      Container(
                        width: 70,
                        child: TextField(
                            style: TextStyle(fontSize: 50, height: 1.5),
                            textAlign: TextAlign.center,
                            cursorHeight: 70,
                            cursorColor: Colors.cyan,
                            onChanged: (text) {
                              if (text != null) {
                                double val = double.parse(text);
                                if (val > 30) {
                                  setState(() {
                                    weight = val;
                                  });
                                }
                              }
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            maxLength: 5,
                            decoration: InputDecoration(
                              counterText: "",
                            )),
                      )
                    ],
                  ),
                )),
                ReusableContainer(
                  contColor: Colors.white,
                  customChild: Column(
                    children: <Widget>[
                      Text(
                        "age",
                        style: kLabelText,
                      ),
                      Container(
                        width: 70,
                        child: TextField(
                            style: TextStyle(fontSize: 50, height: 1.5),
                            textAlign: TextAlign.center,
                            cursorHeight: 70,
                            cursorColor: Colors.cyan,
                            onChanged: (text) {
                              if (text != null) {
                                double val = double.parse(text);
                                if (val > 30) {
                                  setState(() {
                                    age = val.toInt();
                                  });
                                }
                              }
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            maxLength: 5,
                            decoration: InputDecoration(
                              counterText: "",
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                widget.factor.gender = selectedGender;
                widget.factor.age = age;
                widget.factor.height = height;
                widget.factor.weight = weight;
                Navigator.pushNamed(context, Diet.routeName,
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

            // GestureDetector(
            //   onTap: (){
            //     print("next");
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Activity()),
            //     );
            //   },
            //   child: Container(
            //     child: Center(child: Text("Next", style:TextStyle(fontSize: 25),)),
            //     height: 75.0,
            //     width: double.infinity,
            //     color: Colors.cyan,
            //     // margin: EdgeInsets.only(top: 18.0),
            //     margin: EdgeInsets.all(18)
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class buttonPlusMinus extends StatelessWidget {
  buttonPlusMinus({required this.buttonIcon, required this.onpress});
  final IconData buttonIcon;
  final Function() onpress;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(buttonIcon),
      onPressed: onpress,
      fillColor: Activc,
      constraints: BoxConstraints.tightFor(
        width: 44.0,
        height: 44.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
    );
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
