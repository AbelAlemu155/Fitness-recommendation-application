import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/DailyLog.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();
}

class FoodLoadEvent extends FoodEvent {
  int page;
  FoodLoadEvent({required this.page});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DailyLog extends FoodEvent {
  DailyLogModel dlog;
  DailyLog({required this.dlog});
  @override
  // TODO: implement props
  List<Object?> get props => [dlog];
}

class FoodinitEvent extends FoodEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class getAssignedFood extends FoodEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

  int trid;
  getAssignedFood({required this.trid});
}
