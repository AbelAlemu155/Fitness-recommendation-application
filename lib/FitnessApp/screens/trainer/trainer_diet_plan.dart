import 'package:firsstapp/FitnessApp/bloc/userdata/ud_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/userdata/ud_event.dart';
import 'package:firsstapp/FitnessApp/bloc/userdata/ud_state.dart';
import 'package:firsstapp/FitnessApp/models/AssignFitnessPlan.dart';
import 'package:firsstapp/FitnessApp/models/MealPlan.dart';
import 'package:firsstapp/FitnessApp/screens/plans/food_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainerDietPlan extends StatefulWidget {
  static const routeName = '/trainerdietPlan';
  AssignDietPlan dplan;
  TrainerDietPlan({required this.dplan});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TrainerDietState();
  }
}

class TrainerDietState extends State<TrainerDietPlan> {
  String cattoString(int cat) {
    if (cat == 1) {
      return 'All';
    } else {
      return 'Vegeterian';
    }
  }

  List<int> bids = [];
  List<int> lids = [];
  List<int> dids = [];
  List<Breakfast> foods = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final meals = widget.dplan.meals;
    for (int i = 0; i < meals.length; i++) {
      bids.add(meals[i].breakfast_id);
      lids.add(meals[i].lunch_id);
      dids.add(meals[i].dinner_id);
    }
    BlocProvider.of<UdBloc>(context).add(FoodFromList(ids: bids, index: 1));
    BlocProvider.of<UdBloc>(context).add(FoodFromList(ids: lids, index: 2));
    BlocProvider.of<UdBloc>(context).add(FoodFromList(ids: dids, index: 3));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainer Diet Plan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocListener<UdBloc, UdState>(
                child: Container(),
                listener: (_, state) {
                  if (state is FListSuccess) {
                    foods.addAll(state.bfs);
                    setState(() {});
                  }
                }),
            for (int i = 0; i < foods.length; i++)
              GestureDetector(
                onTap: () {
                  Map<int, dynamic> bmap = {1: foods[i]};
                  Navigator.pushNamed(context, FoodDetailScreen.routeName,
                      arguments: bmap);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(foods[i].name),
                        Text('${foods[i].calories} kcal'),
                        Text(cattoString(foods[i].category)),
                        Divider(
                          height: 20,
                          color: Colors.cyan,
                          thickness: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
