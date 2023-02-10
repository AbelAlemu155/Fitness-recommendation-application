import 'package:equatable/equatable.dart';

class DailyLogModel extends Equatable {
  String name;
  double calories;
  int category;
  DailyLogModel(
      {required this.name, required this.calories, required this.category});
  @override
  // TODO: implement props
  List<Object?> get props => [name, calories, category];

  factory DailyLogModel.fromJson(Map<String, dynamic> json) {
    return DailyLogModel(
        name: json['name'],
        calories: json['calories'],
        category: json['category']);
  }
}
