import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/foodandwater.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';

class Plan2State extends Equatable {
  const Plan2State();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Plan2CreateInit extends Plan2State {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AnimatorChange extends Plan2State {
  List<Object?> get props => [];
}

class AnimatorClose extends Plan2State {
  final String message;
  AnimatorClose({required this.message});
  List<Object?> get props => [message];
}

class DraggableState extends Plan2State {}

class workoutsLoadProgress extends Plan2State {}

class workoutLoadSuccess extends Plan2State {
  List workouts;
  workoutLoadSuccess({required this.workouts});
}

class workoutLoadFailiure extends Plan2State {
  final String message;
  workoutLoadFailiure({required this.message});
}

class ImageSlideState extends Plan2State {}

class ImageSlideInit extends Plan2State {}
