import 'package:firsstapp/FitnessApp/bloc/plans/plan_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogWaterScreen extends StatefulWidget {
  static const routeName = '/logWaterScreen';
  Map pvalue;
  LogWaterScreen({required this.pvalue});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LogWaterState();
  }
}

class LogWaterState extends State<LogWaterScreen> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  double water = 0;
  double rwater = 0;

  bool _tapped1 = true;
  bool _tapped2 = false;
  bool _tapped3 = false;
  bool _tapped4 = false;
  int selected = 0;

  double selectNum(int s) {
    if (s == 1) {
      return 250;
    } else if (s == 2) {
      return 500;
    } else if (s == 3) {
      return 750;
    } else {
      return 1000;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    water = widget.pvalue[0].water * 1000;
    rwater = widget.pvalue[0].rwater * 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white.withOpacity(0)),
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 260.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(''),
              background: Image(
                image: AssetImage('Images/water.gif'),
                width: 300,
                height: 300,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text(''),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' ${water.round()} / ${rwater.round()} mL',
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            ),
                          ]),
                      SizedBox(height: 35),
                      Container(
                        height: 40,
                        width: double.infinity,
                        color: _tapped1 ? Colors.grey : Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            selected = 1;
                            setState(() {
                              _tapped1 = true;
                              _tapped2 = false;
                              _tapped3 = false;
                              _tapped4 = false;
                            });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '250ml',
                                  style: TextStyle(
                                      fontSize: _tapped1 ? 35 : 23,
                                      fontStyle: FontStyle.italic),
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        color: _tapped2 ? Colors.grey : Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            selected = 2;
                            setState(() {
                              _tapped1 = false;
                              _tapped2 = true;
                              _tapped3 = false;
                              _tapped4 = false;
                            });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('500ml',
                                    style: TextStyle(
                                        fontSize: _tapped2 ? 35 : 23,
                                        fontStyle: FontStyle.italic))
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        color: _tapped3 ? Colors.grey : Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            selected = 3;
                            setState(() {
                              _tapped1 = false;
                              _tapped2 = false;
                              _tapped3 = true;
                              _tapped4 = false;
                            });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('750ml',
                                    style: TextStyle(
                                        fontSize: _tapped3 ? 35 : 23,
                                        fontStyle: FontStyle.italic))
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        color: _tapped4 ? Colors.grey : Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            selected = 4;
                            setState(() {
                              _tapped1 = false;
                              _tapped2 = false;
                              _tapped3 = false;
                              _tapped4 = true;
                            });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('1000ml',
                                    style: TextStyle(
                                        fontSize: _tapped4 ? 35 : 23,
                                        fontStyle: FontStyle.italic))
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        width: 300,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.cyan,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Row(
                                  children: [
                                    Icon(Icons.water),
                                    Text('Drink water')
                                  ],
                                ),
                                onTap: () {
                                  double data = 0;
                                  if (selected == 1) {
                                    data = 250 + water;
                                  } else if (selected == 2) {
                                    data = 500 + water;
                                  } else if (selected == 3) {
                                    data = 750 + water;
                                  } else if (selected == 4) {
                                    data = 1000 + water;
                                  }
                                  data = data / 1000;
                                  BlocProvider.of<PlanBloc>(context)
                                      .add(DrinkWaterEvent(liter: data));
                                },
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      BlocBuilder<PlanBloc, PlanState>(
                        builder: (_, state) {
                          if (state is DrinkWaterProgress) {
                            return CircularProgressIndicator();
                          }
                          if (state is DrinkWaterFailure) {
                            return Text(state.message);
                          }

                          return Container();
                        },
                      ),
                      BlocListener<PlanBloc, PlanState>(
                        listener: (_, state) {
                          if (state is DrinkWaterSuccess) {
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              setState(() {
                                water += selectNum(selected);
                              });
                            });
                          }
                        },
                        child: Container(),
                      )
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
