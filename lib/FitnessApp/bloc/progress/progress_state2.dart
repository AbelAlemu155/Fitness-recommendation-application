import 'package:equatable/equatable.dart';

class ProgressState2 extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class progressInitialState2 extends ProgressState2 {
  List<Object?> get props => [];
}

class setProgressState2 extends ProgressState2 {
  double calorie;
  setProgressState2({required this.calorie});
  List<Object?> get props => [calorie];
}

