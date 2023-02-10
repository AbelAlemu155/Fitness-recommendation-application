import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@immutable
class Factor extends Equatable {
  Factor({
    this.email = '',
    this.weight = 0,
    this.height = 0,
    this.gender = 'M',
    this.age = 0,
    this.activity = 0,
    this.goal = 0,
    this.diet = 0,
    this.goalWeight = 0,
    this.numDaysWorkout = 0,
    this.numWeeksGoals = 0,
    this.fitnessLevel = 0,
  });

  factory Factor.fromJson(Map<String, dynamic> json) {
    return Factor(
        weight: json['weight'],
        height: json['height'],
        goalWeight: json['goal_weight'],
        goal: json['goal'],
        activity: json['le_activity'],
        fitnessLevel: json['fitness_level']);
  }

  String email;
  double weight;
  double goalWeight;
  double height;
  String gender;
  int age;
  int activity;
  int goal;
  int diet;
  int numDaysWorkout;
  int numWeeksGoals;
  int fitnessLevel;

  @override
  List<Object> get props => [
        email,
        weight,
        height,
        gender,
        age,
        activity,
        goal,
        diet,
        numDaysWorkout,
        numWeeksGoals,
        fitnessLevel
      ];

  @override
  String toString() =>
      'Factor {useremail: $email, weight: $weight,height:$height,age: $age,activity: $activity, goal: $goal,diet: $diet,numDayswork: $numDaysWorkout,fitnesslevel:$fitnessLevel}';
}
