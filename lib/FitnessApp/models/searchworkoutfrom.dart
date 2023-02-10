import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';

class SearchWorkoutFrom extends Equatable {
  List<Workout> workouts;
  String prev_url;
  String next_url;
  int count;
  SearchWorkoutFrom({required this.count,required this.next_url,required this.prev_url,required this.workouts});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
