import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/factor.dart';

abstract class PlanEvent extends Equatable {
  const PlanEvent();
}

class PlanCreateEvent extends PlanEvent {
  final Factor factor;
  PlanCreateEvent({required this.factor});
  @override
  // TODO: implement props
  List<Object?> get props => [factor];
}

class UserFoodLoadEvent extends PlanEvent {
  int index;
  UserFoodLoadEvent({required this.index});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FoodAndWaterEvent extends PlanEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DrinkWaterEvent extends PlanEvent {
  double liter;
  DrinkWaterEvent({required this.liter});

  @override
  // TODO: implement props
  List<Object?> get props => [liter];
}

class NullEvent extends PlanEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
