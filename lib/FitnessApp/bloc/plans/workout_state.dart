import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/AssignFitnessPlan.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';

class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WorkoutLoadProgress extends WorkoutState {}

class WorkoutLoadFailure extends WorkoutState {
  final String message;
  WorkoutLoadFailure({required this.message});
}

class WorkoutLoadSuccess extends WorkoutState {
  WorkoutResponse wresponse;
  WorkoutLoadSuccess({required this.wresponse});
}

class getWExerciseLoad extends WorkoutState {}

class getWExerciseFailure extends WorkoutState {
  final String message;
  getWExerciseFailure({required this.message});
}

class getWExerciseSuccess extends WorkoutState {
  List<Exercise> exs;
  getWExerciseSuccess({required this.exs});
}

class ImageInit extends WorkoutState {}

class ImageState extends WorkoutState {
  int index;
  ImageState({required this.index});
}

class AssignedWpSuccess extends WorkoutState {
  AssignFitnessPlan fitplan;
  AssignedWpSuccess({required this.fitplan});
}

class getWlistload extends WorkoutState {}

class getWlistFail extends WorkoutState {
  final String message;
  getWlistFail({required this.message});
}

class getWlistSuccess extends WorkoutState {
  List<Workout> wkts;
  getWlistSuccess({required this.wkts});
}

class AssignedWpFail extends WorkoutState {
  final String message;
  AssignedWpFail({required this.message});
}

class AssignedWpLoad extends WorkoutState {}
