import 'package:equatable/equatable.dart';

class PermanentState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PermanentSuccess extends PermanentState {}

class PermanentFail extends PermanentState {
  String message;
  PermanentFail({required this.message});
}

class PermanentProgress extends PermanentState {}

class PermanentInit extends PermanentState {}

class WorkoutStatLoad extends PermanentState {}

class WorkoutStatSuccess extends PermanentState {
  List<double> wcals;
  double reccal;
  WorkoutStatSuccess({required this.wcals, required this.reccal});
}

class WorkoutStatFail extends PermanentState {
  final String message;
  WorkoutStatFail({required this.message});
}

class FoodStatLoad extends PermanentState {}

class FoodStatFail extends PermanentState {
  final String message;
  FoodStatFail({required this.message});
}

class FoodStatSuccess extends PermanentState {
  List<double> fcals;
  double reccal;
  FoodStatSuccess({required this.fcals,required this.reccal});
}

class WaterStatLoad extends PermanentState {}

class WaterStatFail extends PermanentState {
  final String message;
  WaterStatFail({required this.message});
}

class WaterStatSuccess extends PermanentState {
  List<double> intakes;
  double recintake;
  WaterStatSuccess({required this.intakes, required this.recintake});
}
