import 'package:equatable/equatable.dart';

class PermanentEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PermanentWorkout extends PermanentEvent {
  int wid;
  double effort;
  int duration;
  PermanentWorkout(
      {required this.duration, required this.effort, required this.wid});
}

class WorkoutStatEvent extends PermanentEvent {

}

class FoodStatEvent  extends PermanentEvent {}

class WaterStatEvent extends PermanentEvent {}
