import 'package:equatable/equatable.dart';

class CalorieState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WCalorieLoad extends CalorieState {}

class WCaloriesSuccess extends CalorieState {
  double calorie;
  WCaloriesSuccess({required this.calorie});
}

class WCalorieFail extends CalorieState {
  final String message;
  WCalorieFail({required this.message});
}

class WCalorieInit extends CalorieState {}

class TimerState extends CalorieState {
  int index;
  TimerState({required this.index});
}

class TimerInit extends CalorieState {}

class CalorieByDurationLoad extends CalorieState {}

class CalorieByDurationFail extends CalorieState {
  final String message;
  CalorieByDurationFail({required this.message});
}

class CalorieByDurationSuccess extends CalorieState {
  double calories;
  CalorieByDurationSuccess({required this.calories});
}

class FirstTimeAnimatorState extends CalorieState {}
