import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/foodandwater.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';

class PlanState extends Equatable {
  const PlanState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PlanCreateInit extends PlanState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class planCreationProgress extends PlanState {}

class PlanCreationSuccess extends PlanState {}

class PlanCreationFailure extends PlanState {
  final String message;
  PlanCreationFailure({required this.message});
}

class UserFoodLoadProgress extends PlanState {}

class UserFoodLoadSuccess extends PlanState {
  List mealPlans;
  UserFoodLoadSuccess({required this.mealPlans});
}

class UserFoodLoadFailure extends PlanState {
  final String message;
  UserFoodLoadFailure({required this.message});
}

class FoodAndWaterInProgress extends PlanState {}

class FoodAndWaterFailure extends PlanState {
  final String message;
  FoodAndWaterFailure({required this.message});
}

class FoodAndWaterSuccess extends PlanState {
  final Fandwater fwater;
  FoodAndWaterSuccess({required this.fwater});
}

class DrinkWaterProgress extends PlanState {
  List<Object?> get props => [];
}

class DrinkWaterFailure extends PlanState {
  final String message;

  DrinkWaterFailure({required this.message});
  List<Object?> get props => [message];
}

class DrinkWaterSuccess extends PlanState {
  double liter;
  DrinkWaterSuccess({required this.liter});

  List<Object?> get props => [liter];
}

class NullState extends PlanState {}

class NullInit extends PlanState {}
