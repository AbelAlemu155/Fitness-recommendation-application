import 'package:equatable/equatable.dart';

class Trainer extends Equatable {
  int id;
  double costPerHour;
  String gender;
  String username;
  int yearOfExperience;

  Trainer(
      {required this.costPerHour,
      required this.gender,
      required this.id,
      required this.username,required this.yearOfExperience});

  @override
  // TODO: implement props
  List<Object?> get props => [id, costPerHour, gender, username,yearOfExperience];

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      costPerHour: json['cost_per_hour'],
      gender: json['gender'],
      id: json['id'],
      username: json['username'],
      yearOfExperience: json['exp']
    );
  }
}
