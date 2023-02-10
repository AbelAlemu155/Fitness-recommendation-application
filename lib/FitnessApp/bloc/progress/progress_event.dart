import 'package:equatable/equatable.dart';

class ProgressEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class setProgress extends ProgressEvent {
  bool? initial;
  double calorie;
  setProgress({required this.calorie, this.initial});
}


