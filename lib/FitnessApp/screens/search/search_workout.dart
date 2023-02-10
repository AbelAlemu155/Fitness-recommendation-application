import 'package:firsstapp/FitnessApp/bloc/plans/workout_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_event.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_bloc2.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_event.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_event2.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_state.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_state2.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_event.dart';
import 'package:firsstapp/FitnessApp/models/serachworkoutto.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';
import 'package:firsstapp/FitnessApp/screens/workout/workout_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWorkout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchWorkoutState();
  }
}

class _SearchWorkoutState extends State<SearchWorkout> {
  bool _tapped = false;
  bool _isvisible = false;

  bool rtap = false;
  bool etap = false;
  bool mtap = false;
  int ctype = 0;
  int cintensity = 0;
  int cduration = 0;
  int intensity = 0;
  int duration = 0;
  int type = 0;

  bool lotap = false;
  bool motap = false;
  bool hitap = false;

  bool tap20 = false;
  bool tap40 = false;
  bool tap60 = false;
  bool sort = false;

  String keyword = '';

  double tx = 300;
  double ty = 0;
  int buttonTapped = 1;

  String intToMessage(int num, bool type) {
    if (type) {
      if (num == 1) {
        return 'Resistance';
      } else if (num == 2) {
        return 'Endurance';
      } else if (num == 3) {
        return 'Mobility';
      }
    } else {
      if (num == 1) {
        return 'Intensity : low';
      } else if (num == 2) {
        return 'Intensity : moderate';
      } else {
        return 'Intensity : high';
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                      hintText: "Search by name or muscle target",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: InputBorder.none),
                  onChanged: (String keyword2) {
                    setState(() {
                      _isvisible = false;
                    });
                    buttonTapped = 1;
                    keyword = keyword2;
                    cduration = 0;
                    ctype = 0;
                    cintensity = 0;
                    duration = 0;
                    type = 0;
                    intensity = 0;

                    if (keyword2.isEmpty) {
                      SearchWorkoutTo sto = SearchWorkoutTo(
                          cduration: cduration,
                          cintensity: cintensity,
                          ctype: ctype,
                          duration: 0,
                          intensity: 0,
                          keyword: keyword,
                          page: 1,
                          sort: sort,
                          type: 0);

                      BlocProvider.of<SearchBloc>(context)
                          .add(SearchWorkoutEvent(isempty: true, swmodel: sto));
                    } else {
                      if (rtap) {
                        type += 1;
                        ctype++;
                      }
                      if (etap) {
                        type += 2;
                        ctype++;
                      }
                      if (mtap) {
                        type += 4;
                        ctype++;
                      }
                      if (lotap) {
                        intensity += 1;
                        cintensity++;
                      }
                      if (motap) {
                        intensity += 2;
                        cintensity++;
                      }
                      if (hitap) {
                        intensity += 4;
                        cintensity++;
                      }
                      if (tap20) {
                        duration += 1;
                        cduration++;
                      }
                      if (tap40) {
                        duration += 2;
                        cduration++;
                      }
                      if (tap60) {
                        duration += 4;
                        cduration++;
                      }

                      SearchWorkoutTo sto = SearchWorkoutTo(
                          cduration: cduration,
                          cintensity: cintensity,
                          ctype: ctype,
                          duration: duration,
                          intensity: intensity,
                          keyword: keyword,
                          page: 1,
                          sort: sort,
                          type: type);

                      BlocProvider.of<SearchBloc>(context).add(
                          SearchWorkoutEvent(isempty: false, swmodel: sto));
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (rtap) {
                      rtap = false;
                    } else {
                      rtap = true;
                    }
                  });
                  setState(() {
                    _isvisible = false;
                  });
                  buttonTapped = 1;
                  if (keyword.isNotEmpty) {
                    cduration = 0;
                    ctype = 0;
                    cintensity = 0;
                    duration = 0;
                    type = 0;
                    intensity = 0;

                    if (rtap) {
                      type += 1;
                      ctype++;
                    }
                    if (etap) {
                      type += 2;
                      ctype++;
                    }
                    if (mtap) {
                      type += 4;
                      ctype++;
                    }
                    if (lotap) {
                      intensity += 1;
                      cintensity++;
                    }
                    if (motap) {
                      intensity += 2;
                      cintensity++;
                    }
                    if (hitap) {
                      intensity += 4;
                      cintensity++;
                    }
                    if (tap20) {
                      duration += 1;
                      cduration++;
                    }
                    if (tap40) {
                      duration += 2;
                      cduration++;
                    }
                    if (tap60) {
                      duration += 4;
                      cduration++;
                    }
                    SearchWorkoutTo sto = SearchWorkoutTo(
                        cduration: cduration,
                        cintensity: cintensity,
                        ctype: ctype,
                        duration: duration,
                        intensity: intensity,
                        keyword: keyword,
                        page: 1,
                        sort: sort,
                        type: type);

                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchWorkoutEvent(isempty: false, swmodel: sto));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: rtap ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  child: Text(
                    'Resistance Type ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (etap) {
                      etap = false;
                    } else {
                      etap = true;
                    }
                  });
                  setState(() {
                    _isvisible = false;
                  });
                  buttonTapped = 1;
                  if (keyword.isNotEmpty) {
                    cduration = 0;
                    ctype = 0;
                    cintensity = 0;
                    duration = 0;
                    type = 0;
                    intensity = 0;

                    if (rtap) {
                      type += 1;
                      ctype++;
                    }
                    if (etap) {
                      type += 2;
                      ctype++;
                    }
                    if (mtap) {
                      type += 4;
                      ctype++;
                    }
                    if (lotap) {
                      intensity += 1;
                      cintensity++;
                    }
                    if (motap) {
                      intensity += 2;
                      cintensity++;
                    }
                    if (hitap) {
                      intensity += 4;
                      cintensity++;
                    }
                    if (tap20) {
                      duration += 1;
                      cduration++;
                    }
                    if (tap40) {
                      duration += 2;
                      cduration++;
                    }
                    if (tap60) {
                      duration += 4;
                      cduration++;
                    }
                    SearchWorkoutTo sto = SearchWorkoutTo(
                        cduration: cduration,
                        cintensity: cintensity,
                        ctype: ctype,
                        duration: duration,
                        intensity: intensity,
                        keyword: keyword,
                        page: 1,
                        sort: sort,
                        type: type);

                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchWorkoutEvent(isempty: false, swmodel: sto));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: etap ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  child: Text(
                    'Endurance Type ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (mtap) {
                      mtap = false;
                    } else {
                      mtap = true;
                    }
                  });
                  setState(() {
                    _isvisible = false;
                  });
                  buttonTapped = 1;
                  if (keyword.isNotEmpty) {
                    cduration = 0;
                    ctype = 0;
                    cintensity = 0;
                    duration = 0;
                    type = 0;
                    intensity = 0;

                    if (rtap) {
                      type += 1;
                      ctype++;
                    }
                    if (etap) {
                      type += 2;
                      ctype++;
                    }
                    if (mtap) {
                      type += 4;
                      ctype++;
                    }
                    if (lotap) {
                      intensity += 1;
                      cintensity++;
                    }
                    if (motap) {
                      intensity += 2;
                      cintensity++;
                    }
                    if (hitap) {
                      intensity += 4;
                      cintensity++;
                    }
                    if (tap20) {
                      duration += 1;
                      cduration++;
                    }
                    if (tap40) {
                      duration += 2;
                      cduration++;
                    }
                    if (tap60) {
                      duration += 4;
                      cduration++;
                    }
                    SearchWorkoutTo sto = SearchWorkoutTo(
                        cduration: cduration,
                        cintensity: cintensity,
                        ctype: ctype,
                        duration: duration,
                        intensity: intensity,
                        keyword: keyword,
                        page: 1,
                        sort: sort,
                        type: type);

                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchWorkoutEvent(isempty: false, swmodel: sto));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: mtap ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  child: Text(
                    'Mobility Type ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
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
                    if (lotap) {
                      lotap = false;
                    } else {
                      lotap = true;
                    }
                  });
                  setState(() {
                    _isvisible = false;
                  });
                  buttonTapped = 1;
                  if (keyword.isNotEmpty) {
                    cduration = 0;
                    ctype = 0;
                    cintensity = 0;
                    duration = 0;
                    type = 0;
                    intensity = 0;

                    if (rtap) {
                      type += 1;
                      ctype++;
                    }
                    if (etap) {
                      type += 2;
                      ctype++;
                    }
                    if (mtap) {
                      type += 4;
                      ctype++;
                    }
                    if (lotap) {
                      intensity += 1;
                      cintensity++;
                    }
                    if (motap) {
                      intensity += 2;
                      cintensity++;
                    }
                    if (hitap) {
                      intensity += 4;
                      cintensity++;
                    }
                    if (tap20) {
                      duration += 1;
                      cduration++;
                    }
                    if (tap40) {
                      duration += 2;
                      cduration++;
                    }
                    if (tap60) {
                      duration += 4;
                      cduration++;
                    }
                    SearchWorkoutTo sto = SearchWorkoutTo(
                        cduration: cduration,
                        cintensity: cintensity,
                        ctype: ctype,
                        duration: duration,
                        intensity: intensity,
                        keyword: keyword,
                        page: 1,
                        sort: sort,
                        type: type);

                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchWorkoutEvent(isempty: false, swmodel: sto));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: lotap ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  child: Text(
                    'Low Intensity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (motap) {
                      motap = false;
                    } else {
                      motap = true;
                    }
                  });
                  setState(() {
                    _isvisible = false;
                  });
                  buttonTapped = 1;
                  if (keyword.isNotEmpty) {
                    cduration = 0;
                    ctype = 0;
                    cintensity = 0;
                    duration = 0;
                    type = 0;
                    intensity = 0;

                    if (rtap) {
                      type += 1;
                      ctype++;
                    }
                    if (etap) {
                      type += 2;
                      ctype++;
                    }
                    if (mtap) {
                      type += 4;
                      ctype++;
                    }
                    if (lotap) {
                      intensity += 1;
                      cintensity++;
                    }
                    if (motap) {
                      intensity += 2;
                      cintensity++;
                    }
                    if (hitap) {
                      intensity += 4;
                      cintensity++;
                    }
                    if (tap20) {
                      duration += 1;
                      cduration++;
                    }
                    if (tap40) {
                      duration += 2;
                      cduration++;
                    }
                    if (tap60) {
                      duration += 4;
                      cduration++;
                    }
                    SearchWorkoutTo sto = SearchWorkoutTo(
                        cduration: cduration,
                        cintensity: cintensity,
                        ctype: ctype,
                        duration: duration,
                        intensity: intensity,
                        keyword: keyword,
                        page: 1,
                        sort: sort,
                        type: type);

                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchWorkoutEvent(isempty: false, swmodel: sto));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: motap ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  child: Text(
                    'Moderate Intensity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (hitap) {
                      hitap = false;
                    } else {
                      hitap = true;
                    }
                  });
                  setState(() {
                    _isvisible = false;
                  });
                  buttonTapped = 1;
                  if (keyword.isNotEmpty) {
                    cduration = 0;
                    ctype = 0;
                    cintensity = 0;
                    duration = 0;
                    type = 0;
                    intensity = 0;

                    if (rtap) {
                      type += 1;
                      ctype++;
                    }
                    if (etap) {
                      type += 2;
                      ctype++;
                    }
                    if (mtap) {
                      type += 4;
                      ctype++;
                    }
                    if (lotap) {
                      intensity += 1;
                      cintensity++;
                    }
                    if (motap) {
                      intensity += 2;
                      cintensity++;
                    }
                    if (hitap) {
                      intensity += 4;
                      cintensity++;
                    }
                    if (tap20) {
                      duration += 1;
                      cduration++;
                    }
                    if (tap40) {
                      duration += 2;
                      cduration++;
                    }
                    if (tap60) {
                      duration += 4;
                      cduration++;
                    }
                    SearchWorkoutTo sto = SearchWorkoutTo(
                        cduration: cduration,
                        cintensity: cintensity,
                        ctype: ctype,
                        duration: duration,
                        intensity: intensity,
                        keyword: keyword,
                        page: 1,
                        sort: sort,
                        type: type);

                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchWorkoutEvent(isempty: false, swmodel: sto));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: hitap ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  child: Text(
                    'High Intensity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
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
                    if (tap20) {
                      tap20 = false;
                    } else {
                      tap20 = true;
                    }
                  });
                  setState(() {
                    _isvisible = false;
                  });
                  buttonTapped = 1;
                  if (keyword.isNotEmpty) {
                    cduration = 0;
                    ctype = 0;
                    cintensity = 0;
                    duration = 0;
                    type = 0;
                    intensity = 0;

                    if (rtap) {
                      type += 1;
                      ctype++;
                    }
                    if (etap) {
                      type += 2;
                      ctype++;
                    }
                    if (mtap) {
                      type += 4;
                      ctype++;
                    }
                    if (lotap) {
                      intensity += 1;
                      cintensity++;
                    }
                    if (motap) {
                      intensity += 2;
                      cintensity++;
                    }
                    if (hitap) {
                      intensity += 4;
                      cintensity++;
                    }
                    if (tap20) {
                      duration += 1;
                      cduration++;
                    }
                    if (tap40) {
                      duration += 2;
                      cduration++;
                    }
                    if (tap60) {
                      duration += 4;
                      cduration++;
                    }
                    SearchWorkoutTo sto = SearchWorkoutTo(
                        cduration: cduration,
                        cintensity: cintensity,
                        ctype: ctype,
                        duration: duration,
                        intensity: intensity,
                        keyword: keyword,
                        page: 1,
                        sort: sort,
                        type: type);

                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchWorkoutEvent(isempty: false, swmodel: sto));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: tap20 ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  child: Text(
                    '20 Minutes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (tap40) {
                      tap40 = false;
                    } else {
                      tap40 = true;
                    }
                  });
                  setState(() {
                    _isvisible = false;
                  });
                  buttonTapped = 1;
                  if (keyword.isNotEmpty) {
                    cduration = 0;
                    ctype = 0;
                    cintensity = 0;
                    duration = 0;
                    type = 0;
                    intensity = 0;

                    if (rtap) {
                      type += 1;
                      ctype++;
                    }
                    if (etap) {
                      type += 2;
                      ctype++;
                    }
                    if (mtap) {
                      type += 4;
                      ctype++;
                    }
                    if (lotap) {
                      intensity += 1;
                      cintensity++;
                    }
                    if (motap) {
                      intensity += 2;
                      cintensity++;
                    }
                    if (hitap) {
                      intensity += 4;
                      cintensity++;
                    }
                    if (tap20) {
                      duration += 1;
                      cduration++;
                    }
                    if (tap40) {
                      duration += 2;
                      cduration++;
                    }
                    if (tap60) {
                      duration += 4;
                      cduration++;
                    }
                    SearchWorkoutTo sto = SearchWorkoutTo(
                        cduration: cduration,
                        cintensity: cintensity,
                        ctype: ctype,
                        duration: duration,
                        intensity: intensity,
                        keyword: keyword,
                        page: 1,
                        sort: sort,
                        type: type);

                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchWorkoutEvent(isempty: false, swmodel: sto));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: tap40 ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  child: Text(
                    '40 Minutes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (tap60) {
                      tap60 = false;
                    } else {
                      tap60 = true;
                    }
                  });
                  setState(() {
                    _isvisible = false;
                  });
                  buttonTapped = 1;
                  if (keyword.isNotEmpty) {
                    cduration = 0;
                    ctype = 0;
                    cintensity = 0;
                    duration = 0;
                    type = 0;
                    intensity = 0;

                    if (rtap) {
                      type += 1;
                      ctype++;
                    }
                    if (etap) {
                      type += 2;
                      ctype++;
                    }
                    if (mtap) {
                      type += 4;
                      ctype++;
                    }
                    if (lotap) {
                      intensity += 1;
                      cintensity++;
                    }
                    if (motap) {
                      intensity += 2;
                      cintensity++;
                    }
                    if (hitap) {
                      intensity += 4;
                      cintensity++;
                    }
                    if (tap20) {
                      duration += 1;
                      cduration++;
                    }
                    if (tap40) {
                      duration += 2;
                      cduration++;
                    }
                    if (tap60) {
                      duration += 4;
                      cduration++;
                    }
                    SearchWorkoutTo sto = SearchWorkoutTo(
                        cduration: cduration,
                        cintensity: cintensity,
                        ctype: ctype,
                        duration: duration,
                        intensity: intensity,
                        keyword: keyword,
                        page: 1,
                        sort: sort,
                        type: type);

                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchWorkoutEvent(isempty: false, swmodel: sto));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: tap60 ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  child: Text(
                    '60 Minutes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
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
                  setState(() {
                    _isvisible = false;
                  });
                  buttonTapped = 1;
                  if (keyword.isNotEmpty) {
                    cduration = 0;
                    ctype = 0;
                    cintensity = 0;
                    duration = 0;
                    type = 0;
                    intensity = 0;

                    if (rtap) {
                      type += 1;
                      ctype++;
                    }
                    if (etap) {
                      type += 2;
                      ctype++;
                    }
                    if (mtap) {
                      type += 4;
                      ctype++;
                    }
                    if (lotap) {
                      intensity += 1;
                      cintensity++;
                    }
                    if (motap) {
                      intensity += 2;
                      cintensity++;
                    }
                    if (hitap) {
                      intensity += 4;
                      cintensity++;
                    }
                    if (tap20) {
                      duration += 1;
                      cduration++;
                    }
                    if (tap40) {
                      duration += 2;
                      cduration++;
                    }
                    if (tap60) {
                      duration += 4;
                      cduration++;
                    }
                    SearchWorkoutTo sto = SearchWorkoutTo(
                        cduration: cduration,
                        cintensity: cintensity,
                        ctype: ctype,
                        duration: duration,
                        intensity: intensity,
                        keyword: keyword,
                        page: 1,
                        sort: sort,
                        type: type);

                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchWorkoutEvent(isempty: false, swmodel: sto));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: sort ? Colors.grey : Colors.white,
                      border: Border.all(width: 3, color: Colors.black),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(40, 60))),
                  child: Row(children: [
                    Icon(
                      Icons.sort,
                      color: Colors.cyan,
                    ),
                    Text(
                      'Sort by met',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          BlocBuilder<SearchBloc, SearchState>(builder: (_, state) {
            if (state is SearchWorkoutLoad) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SearchWorkoutFail) {
              return Center(child: Text(state.message));
            }
            if (state is SearchWorkoutSuccess) {
              List<Workout> wkts = state.swmodel.workouts;
              return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: wkts.length,
                  itemBuilder: (_, idx) {
                    String type = intToMessage(wkts[idx].type, true);
                    String intensity = intToMessage(wkts[idx].intensity, false);
                    return GestureDetector(
                      onTap: () {
                        String url = wkts[idx].url;

                        String url5 = url.substring(
                          url.lastIndexOf('/'),
                        );
                        String url6 = url5.replaceAll('/', '');

                        int id = int.parse(url6);

                        BlocProvider.of<WorkoutBloc>(context)
                            .add(getWexerciseEvent(wurl: wkts[idx].exercises));
                        BlocProvider.of<CalorieBloc>(context)
                            .add(WCalorieEvent(w_id: id));
                        Navigator.pushNamed(
                            context, WorkoutDetailScreen.routeName,
                            arguments: wkts[idx]);
                      },
                      child: Transform.translate(
                          offset: Offset(tx, ty),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 0, color: Colors.white),
                                borderRadius: BorderRadius.circular(15.0)),
                            child: ListTile(
                              title: Text(
                                wkts[idx].name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                              subtitle: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text('$type type'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(children: [
                                    Text(intensity),
                                  ]),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.timelapse),
                                      Text('${wkts[idx].duration} minutes')
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )),
                    );
                  });
            }
            return Container();
          }),
          BlocListener<SearchBloc, SearchState>(
              child: Container(),
              listener: (_, state) {
                if (state is SearchWorkoutSuccess) {
                  BlocProvider.of<SearchBloc2>(context).add(SearchInitEvent2());
                  final next = state.swmodel.next_url;
                  setState(() {
                    if (next.isEmpty) {
                      _isvisible = false;
                    } else {
                      _isvisible = true;
                    }
                  });
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    BlocProvider.of<SearchBloc2>(context)
                        .add(SearchWTranslateEvent());
                  });
                }
              }),
          BlocListener<SearchBloc2, Search2>(
              child: Container(),
              listener: (_, state) {
                if (state is SearchWTranslate) {
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
            visible: _isvisible,
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
                  SearchWorkoutTo sto = SearchWorkoutTo(
                      cduration: cduration,
                      cintensity: cintensity,
                      ctype: ctype,
                      duration: duration,
                      intensity: intensity,
                      keyword: keyword,
                      page: buttonTapped,
                      sort: sort,
                      type: type);

                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchWorkoutEvent(isempty: false, swmodel: sto));
                  setState(() {
                    _isvisible = false;
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
