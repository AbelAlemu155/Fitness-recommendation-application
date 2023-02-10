import 'package:firsstapp/FitnessApp/bloc/plans/plan_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_state.dart';
import 'package:firsstapp/FitnessApp/models/factor.dart';
import 'package:firsstapp/FitnessApp/screens/login_screen.dart';
import 'package:firsstapp/FitnessApp/screens/plans/allscreens.dart';
import 'package:firsstapp/FitnessApp/screens/plans/num_workout_screen.dart';
import 'package:firsstapp/FitnessApp/screens/plans/plans_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const Activc = Colors.cyan;
const Inactivc = Colors.white;

const kLabelText = TextStyle(fontSize: 18.0, color: Colors.black);

class FitnessLevel extends StatefulWidget {
  static const routeName = '/fitnesslevelscreen';
  Factor factor;
  FitnessLevel({required this.factor});
  @override
  _Fitstate createState() => _Fitstate();
}

class _Fitstate extends State<FitnessLevel> {
  bool _isVisible = false;
  bool _disabled = true;
  bool _tapped = false;
  int numweeks = 0;
  int fitnesslevel = 1;
  ScrollController _scrollController = ScrollController();
  final controller1 = TextEditingController();

  String textTodisplay() {
    if (fitnesslevel == 1) {
      return 'NEVEREXERCISED';
    } else if (fitnesslevel == 2) {
      return 'BEGINNER';
    } else if (fitnesslevel == 3) {
      return 'INTERMEDIATE';
    } else if (fitnesslevel == 4) {
      return 'FIT';
    } else {
      return 'VERYFIT';
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.factor);
    return Scaffold(
        appBar: AppBar(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.cyan),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      width: 10.0,
                    ),
                    Text("How do you rate", style: TextStyle(fontSize: 35)),
                    Text("your fitness level", style: TextStyle(fontSize: 35)),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  children: <Widget>[
                    ReusableContainer(
                      contColor: selectDiet == Diets.vegan ? Activc : Inactivc,
                      otp: () {
                        setState(() {
                          selectDiet = Diets.vegan;
                        });
                      },
                      customChild: Container(
                        child: Column(
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 16.0),
                                  thumbColor: Inactivc,
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 32.0),
                                  activeTrackColor: Colors.black,
                                  inactiveTrackColor: Colors.greenAccent),
                              child: Slider(
                                value: fitnesslevel.toDouble(),
                                min: 1,
                                max: 5,
                                onChanged: (double changeHeight) {
                                  setState(() {
                                    fitnesslevel = changeHeight.round();
                                  });
                                },
                              ),
                            ),
                            Text(textTodisplay()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
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
                      onTap: () {
                        setState(() {
                          _tapped = true;
                        });

                        Future.delayed(const Duration(milliseconds: 100), () {
                          setState(() {
                            _tapped = false;
                          });
                        });

                        widget.factor.fitnessLevel = fitnesslevel;

                        print('///////////////////////$fitnesslevel');

                        print('///////////////////${widget.factor}');
                        BlocProvider.of<PlanBloc>(context)
                            .add(PlanCreateEvent(factor: widget.factor));
                        /* Navigator.of(context).pushNamed(NumDays.routeName,
                                  arguments: widget.factor);*/
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
                BlocBuilder<PlanBloc, PlanState>(
                  builder: (_, state) {
                    if (state is planCreationProgress) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease);
                        setState(() {
                          _isVisible = true;
                        });
                      });

                      return Column(children: [
                        SizedBox(height: 40),
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 40,
                        )
                      ]);
                    }
                    if (state is PlanCreationFailure) {
                      return Text(state.message);
                    }
                    if (state is PlanCreationSuccess) {
                      // LoginScreen.box.write('planCreated', true);
                      DateTime now = DateTime.now();

                      int numweeks2 = widget.factor.numWeeksGoals;
                      int numdays = numweeks2 * 7;
                      DateTime last = now.add(Duration(days: numdays));
                      Map<String, int> firstMap = {
                        'day': now.day,
                        'month': now.month,
                        'year': now.year
                      };
                      Map<String, int> lastMap = {
                        'day': last.day,
                        'month': last.month,
                        'year': last.year
                      };
                      LoginScreen.box.write('planCreated', true);

                      LoginScreen.box.write('firstday', firstMap);
                      LoginScreen.box.write('lastday', lastMap);

                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AllScreen.routeName, (route) => false,
                            arguments: widget.factor);
                      });
                    }
                    return Text('');
                  },
                ),
                Visibility(
                    visible: _isVisible,
                    child: SizedBox(
                      height: 200,
                    )),
              ],
            ),
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
