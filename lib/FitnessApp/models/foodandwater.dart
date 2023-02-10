import 'package:firsstapp/FitnessApp/bloc/progress/log_state.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Fandwater extends Equatable {
  double rwater;
  double water;
  double rfood;
  double food;
  Fandwater(
      {required this.rwater,
      required this.food,
      required this.rfood,
      required this.water});

  @override
  // TODO: implement props
  List<Object?> get props => [];

  factory Fandwater.fromJson(Map<String, dynamic> json) {
    final rwater1 = json['rwater'];
    final food1 = json['food'];
    final rfood1 = json['rfood'];
    final water1 = json['water'];
    num rwater2 = rwater1;
    num food2 = food1;
    num rfood2 = rfood1;
    num water2 = water1;

    if (rwater1 is int) {
      rwater2 = rwater1.toDouble();
    }
    if (food1 is int) {
      food2 = food1.toDouble();
    }
    if (rfood1 is int) {
      rfood2 = rfood1.toDouble();
    }
    if (water1 is int) {
      water2 = water1.toDouble();
    }

    return Fandwater(
        rwater: rwater2 as double,
        food: food2 as double,
        rfood: rfood2 as double,
        water: water2 as double);
  }
}
