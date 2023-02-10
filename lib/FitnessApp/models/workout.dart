import 'package:equatable/equatable.dart';

class Workout extends Equatable {
  String url;
  String name;
  String description;
  String muscle_target;
  int type;
  int intensity;
  double met_value;
  String exercises;
  String image_url;
  int duration;

  Workout(
      {required this.url,
      required this.name,
      required this.description,
      required this.type,
      required this.intensity,
      required this.met_value,
      required this.exercises,
      required this.image_url,
      required this.muscle_target,
      required this.duration});

  factory Workout.fromJson(Map<String, dynamic> json) {
    int duration = json['duration'] != null ? json['duration'] : 0;
    String muscle_target =
        json['muscle_target'] != null ? json['muscle_target'] : '';
    String image_url = json['image_url'] != null ? json['image_url'] : '';
    double met_value = json['met_value'] != null ? json['met_value'] : 10;

    return Workout(
        url: json['url'],
        name: json['name'],
        description: json['description'],
        type: json['type'],
        intensity: json['intensity'],
        met_value: met_value,
        exercises: json['exercises'],
        image_url: image_url,
        duration: duration,
        muscle_target: muscle_target);
  }
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Exercise extends Equatable {
  String url;
  String name;
  String description;
  String equipment;
  int duration;

  String image_url;
  Exercise(
      {required this.url,
      required this.description,
      required this.duration,
      required this.equipment,
      required this.image_url,
      required this.name});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    String image_url = json['image_url'] != null ? json['image_url'] : '';

    return Exercise(
        url: json['url'],
        description: json['description'],
        duration: json['duration'],
        equipment: json['equipment'],
        image_url: image_url,
        name: json['name']);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [url, name, description, equipment, duration, image_url];
}

class WorkoutResponse extends Equatable {
  List<Workout> wkts;
  String next_url;
  String prev_url;
  int count;
  WorkoutResponse({required this.count,required this.next_url,required this.prev_url,required this.wkts});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
