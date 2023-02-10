import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/food_event.dart';
import 'package:firsstapp/FitnessApp/models/AssignFitnessPlan.dart';
import 'package:firsstapp/FitnessApp/models/DailyLog.dart';
import 'package:firsstapp/FitnessApp/models/multiplefoods.dart';

class FoodState extends Equatable {
  const FoodState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FoodLoadProgress extends FoodState {}

class FoodLoadFailure extends FoodState {
  final String message;
  FoodLoadFailure({required this.message});
}

class FoodLoadSuccess extends FoodState {
  MultipleFoods foods;
  FoodLoadSuccess({required this.foods});
}

class DailyPostProgress extends FoodState {}

class DailyPostFailure extends FoodState {
  final String message;
  DailyPostFailure({required this.message});
}

class DailyPostSuccess extends FoodState {
  DailyLogModel dlog;
  DailyPostSuccess({required this.dlog});
  List<Object?> get props => [dlog];
}

class Foodinit extends FoodState {}

class AssignedFoodLoad extends FoodState {}

class AssignedFoodSuccess extends FoodState {
  AssignDietPlan dplan;
  AssignedFoodSuccess({required this.dplan});
}

class AssignedFoodFail extends FoodState {
  final String message;
  AssignedFoodFail({required this.message});
}


