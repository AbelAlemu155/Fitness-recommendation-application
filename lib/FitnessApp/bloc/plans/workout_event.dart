import 'package:equatable/equatable.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();
}

class WorkoutLoadEvent extends WorkoutEvent {
  int page;
  WorkoutLoadEvent({required this.page});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class getWexerciseEvent extends WorkoutEvent {
  String wurl;
  getWexerciseEvent({required this.wurl});
  @override
  // TODO: implement props
  List<Object?> get props => [wurl];
}

class ImageEvent extends WorkoutEvent {
  int index;
  ImageEvent({required this.index});
  @override
  // TODO: implement props
  List<Object?> get props => [index];
}

class getAssignedFplan extends WorkoutEvent {
  int trid;
  getAssignedFplan({required this.trid});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class getWFromList extends WorkoutEvent {
  List<int> ids;
  getWFromList({required this.ids});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

