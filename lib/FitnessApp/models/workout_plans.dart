import 'package:equatable/equatable.dart';

class WorkoutPlan extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  String url;
  String workouts;
  int week;
  WorkoutPlan({required this.url, required this.workouts, required this.week});

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    return WorkoutPlan(
        url: json['url'], workouts: json['workouts'], week: json['week']);
  }
}



