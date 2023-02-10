import 'package:cached_network_image/cached_network_image.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_state.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_event.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_event.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';
import 'package:firsstapp/FitnessApp/screens/search/search_workout.dart';
import 'package:firsstapp/FitnessApp/screens/workout/workout_detail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllWorkoutScreen extends StatefulWidget {
  static const routeName = '/allWscreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AllWorkoutState();
  }
}

class AllWorkoutState extends State<AllWorkoutScreen> {
  bool isLoadingImage = false;

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

  void _showmodal(BuildContext context) {
    BlocProvider.of<SearchBloc>(context).add(SearchInitEvent());
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white.withOpacity(0),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState2) {
            return Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.4),
                border: Border.all(color: Colors.cyan),
                borderRadius: BorderRadius.circular(20.0),
              ),
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(children: [
                  SearchWorkout(),
                ]),
              ),
            );
          });
        });
  }

  int page = 1;
  List<Workout> wkts = [];
  ScrollController _controller = ScrollController();
  String next = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<WorkoutBloc>(context).add(WorkoutLoadEvent(page: 1));
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (next.isNotEmpty) {
          page++;
          BlocProvider.of<WorkoutBloc>(context)
              .add(WorkoutLoadEvent(page: page));
        }
      }
    });
  }

  /* Future _loadImages(List<String> urlImages) async {
    setState(() {
      isLoadingImage = true;
    });
    await Future.wait(
        urlImages.map((url) => _cacheImage(context, url)).toList());
    setState(() {
      isLoadingImage = false;
    });
  } */

  /* Future _cacheImage(BuildContext context, String imageurl) =>
      precacheImage(CachedNetworkImageProvider(imageurl), context);*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  _showmodal(context);
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.cyan,
                  size: 33,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView(controller: _controller, children:
              //function call
              [
            for (int i = 0; i < wkts.length; i++)
              ListTile(
                onTap: () {
                  String url = wkts[i].url;

                  String url5 = url.substring(
                    url.lastIndexOf('/'),
                  );
                  String url6 = url5.replaceAll('/', '');

                  int id = int.parse(url6);

                  BlocProvider.of<WorkoutBloc>(context)
                      .add(getWexerciseEvent(wurl: wkts[i].exercises));
                  BlocProvider.of<CalorieBloc>(context)
                      .add(WCalorieEvent(w_id: id));
                  Navigator.pushNamed(context, WorkoutDetailScreen.routeName,
                      arguments: wkts[i]);
                },
                title: Text(wkts[i].name),
                subtitle: Text(intToMessage(wkts[i].type, true)),
                leading: Hero(
                  tag: wkts[i].url,
                  child: CachedNetworkImage(
                    imageUrl: wkts[i].image_url,
                    placeholder: (context, url) => CircularProgressIndicator(),
                  ),
                ),
                trailing: Text(intToMessage(wkts[i].intensity, false)),
              )
          ]),
        ),
        BlocBuilder<WorkoutBloc, WorkoutState>(builder: (_, state) {
          if (state is WorkoutLoadProgress) {
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                )
              ],
            );
          }
          if (state is WorkoutLoadFailure) {
            return Text(state.message);
          }

          return Container();
        }),
        BlocListener<WorkoutBloc, WorkoutState>(
            listener: (_, state) {
              if (state is WorkoutLoadSuccess) {
                wkts.addAll(state.wresponse.wkts);

                next = state.wresponse.next_url;

                setState(() {});
              }
            },
            child: Container())
      ],
    ));
  }
}
