import 'package:cached_network_image/cached_network_image.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/food_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/food_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/food_state.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_event.dart';
import 'package:firsstapp/FitnessApp/models/MealPlan.dart';
import 'package:firsstapp/FitnessApp/models/multiplefoods.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';
import 'package:firsstapp/FitnessApp/screens/search/search_food.dart';
import 'package:firsstapp/FitnessApp/screens/search/search_food2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../food_details.dart';

class AllFoodScreen extends StatefulWidget {
  static const routeName = '/allFscreen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AllFoodScreenState();
  }
}

class AllFoodScreenState extends State<AllFoodScreen> {
  ScrollController _controller = ScrollController();

  String nextb = '';
  String nextl = '';
  String nextd = '';
  String nexts = '';
  int page = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FoodBloc>(context).add(FoodLoadEvent(page: 1));
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (nextb.isNotEmpty ||
            nextd.isNotEmpty ||
            nextl.isNotEmpty ||
            nextd.isNotEmpty) {
          page++;
          BlocProvider.of<FoodBloc>(context).add(FoodLoadEvent(page: page));
        }
      }
    });
  }

  String catToString(int cat) {
    if (cat == 1) {
      return 'Traditional';
    } else if (cat == 2) {
      return 'Vegeterian';
    }
    return 'unknown';
  }

  void _showmodal(BuildContext context) {
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
                child: Column(
                  children: [SearchFood2()],
                ),
              ),
            );
          });
        });
  }

  List allfoods = [];
  List<MultipleFoods> mfs = [];
  @override
  Widget build(BuildContext context) {
    //  BlocProvider.of<FoodBloc>(context).add(FoodLoadEvent());
    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(children: [
          BlocListener<FoodBloc, FoodState>(
            child: Container(),
            listener: (_, state) {
              if (state is FoodLoadSuccess) {
                final mfs = state.foods;
                List<Breakfast> bs = mfs.bs;
                List<Lunch> ls = mfs.ls;
                List<Dinner> ds = mfs.ds;
                List<Snack> ss = mfs.ss;
                setState(() {
                  allfoods.addAll(bs);
                  allfoods.addAll(ls);
                  allfoods.addAll(ds);
                  allfoods.addAll(ss);
                  nextb = mfs.nextb;
                  nextl = mfs.nextl;
                  nextd = mfs.nextd;
                  nexts = mfs.nexts;
                });
              }
            },
          ),
          if (allfoods.isNotEmpty)
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
                for (int idx = 0; idx < allfoods.length; idx++)
                  GestureDetector(
                    onTap: () {
                      int ind = 0;
                      if (allfoods[idx] is Breakfast) {
                        ind = 1;
                      } else if (allfoods[idx] is Lunch) {
                        ind = 2;
                      } else if (allfoods[idx] is Dinner) {
                        ind = 3;
                      } else if (allfoods[idx] is Snack) {
                        ind = 4;
                      }
                      Map<int, dynamic> smap = {ind: allfoods[idx]};
                      Navigator.pushNamed(context, FoodDetailScreen.routeName,
                          arguments: smap);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            width: 100,
                                            height: 100,
                                            child: CachedNetworkImage(
                                              imageUrl: allfoods[idx].image_url,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                            )),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                allfoods[idx].name,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: "Mon"),
                                              ),
                                              Text(
                                                  'Calories: ${allfoods[idx].calories}',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15,
                                                      fontFamily: "Mon")),
                                              Text(
                                                  'Categories: ${catToString(allfoods[idx].category)}',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15,
                                                      fontFamily: "Mon"))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                      elevation: 10,
                    ),
                  )
              ],
            ),
          BlocBuilder<FoodBloc, FoodState>(builder: (_, state) {
            print(state.runtimeType);
            if (state is FoodLoadProgress) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is FoodLoadFailure) {
              return Center(child: Text(state.message));
            }

            return CircularProgressIndicator();
          }),
        ]),
      ),
    );
  }
}
