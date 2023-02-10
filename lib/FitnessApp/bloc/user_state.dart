import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/Trainer.dart';
import 'package:firsstapp/FitnessApp/models/user.dart';

class UserState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserLoadProgress extends UserState {}

class UserLoadFail extends UserState {
  final String message;
  int ind;
  UserLoadFail({required this.message, required this.ind});
}

class UserLoadSuccess extends UserState {
  User user;
  int ind;
  UserLoadSuccess({required this.user, required this.ind});
}

class UserByEmailLoad extends UserState {}

class UserByEmailSuccess extends UserState {
  User user;
  UserByEmailSuccess({required this.user});
}

class UserByEmailFail extends UserState {
  final String message;
  UserByEmailFail({required this.message});
}

class UserInit extends UserState {}

class TrainerLoadProgress extends UserState {}

class TrainerLoadSuccess extends UserState {
  List<Trainer> trainers;
  TrainerLoadSuccess({required this.trainers});
}

class TrainerLoadFail extends UserState {
  final String message;
  TrainerLoadFail({required this.message});
}

class WgoalLoad extends UserState {}

class WgoalFail extends UserState {
  final String message;
  WgoalFail({required this.message});
}

class WgoalSuccess extends UserState {
  double goal;
  WgoalSuccess({required this.goal});
}
