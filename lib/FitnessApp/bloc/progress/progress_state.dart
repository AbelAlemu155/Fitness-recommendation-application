import 'package:equatable/equatable.dart';

class ProgressState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class progressInitialState extends ProgressState {
  List<Object?> get props => [];
}

class setProgressState extends ProgressState {
  double calorie;
  setProgressState({required this.calorie});
  List<Object?> get props => [calorie];
}

