import 'package:equatable/equatable.dart';

class AssignFitnessPlan extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];

  int fplan_id;
  String name;
  int client_id;
  int trainer_id;
  int weeks;
  List<AssignWorkouts> workouts;
  AssignFitnessPlan(
      {required this.client_id,
      required this.fplan_id,
      required this.name,
      required this.trainer_id,
      required this.weeks,
      required this.workouts});
  factory AssignFitnessPlan.fromJson(Map<String, dynamic> json) {
    return AssignFitnessPlan(
        client_id: json['client_id'],
        fplan_id: json['fplan_id'],
        name: json['name'],
        trainer_id: json['trainer_id'],
        weeks: json['weeks'],
        workouts: json['workouts']);
  }
}

class AssignWorkouts extends Equatable {
  int fplan_id;
  int workout_id;
  int dayOfWeek;

  AssignWorkouts(
      {required this.dayOfWeek,
      required this.fplan_id,
      required this.workout_id});

  @override
  // TODO: implement props
  List<Object?> get props => [];

  factory AssignWorkouts.fromJson(Map<String, dynamic> json) {
    return AssignWorkouts(
        dayOfWeek: json['dayOfWeek'],
        fplan_id: json['fplan_id'],
        workout_id: json['workout_id']);
  }
}

class AssignDietPlan extends Equatable {
  int dplan_id;
  String name;
  int client_id;
  int trainer_id;
  int weeks;
  List<AssignFood> meals;

  AssignDietPlan(
      {required this.client_id,
      required this.dplan_id,
      required this.meals,
      required this.name,
      required this.trainer_id,
      required this.weeks});

  @override
  // TODO: implement props
  List<Object?> get props => [];

  factory AssignDietPlan.fromJson(Map<String, dynamic> json) {
    return AssignDietPlan(
        client_id: json['client_id'],
        dplan_id: json['dplan_id'],
        meals: json['meals'],
        name: json['name'],
        trainer_id: json['trainer_id'],
        weeks: json['weeks']);
  }
}

class AssignFood extends Equatable {
  int dplan_id;
  int breakfast_id;
  int lunch_id;
  int dinner_id;
  int dayofWeek;

  AssignFood(
      {required this.breakfast_id,
      required this.dayofWeek,
      required this.dinner_id,
      required this.dplan_id,
      required this.lunch_id});

  @override
  // TODO: implement props
  List<Object?> get props => [];

  factory AssignFood.fromJson(Map<String, dynamic> json) {
    return AssignFood(
        breakfast_id: json['breakfast_id'],
        dayofWeek: json['dayOfWeek'],
        dinner_id: json['dinner_id'],
        dplan_id: json['dplan_id'],
        lunch_id: json['lunch_id']);
  }
}
