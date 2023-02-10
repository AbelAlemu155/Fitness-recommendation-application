import 'package:equatable/equatable.dart';

class CalorieEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WCalorieEvent extends CalorieEvent {
  final int w_id;
  WCalorieEvent({required this.w_id});
}

class TimerEvent extends CalorieEvent {
  int index;
  TimerEvent({required this.index});
}

class TimerInitEvent extends CalorieEvent {}

class CalorieByDurationEvent extends CalorieEvent {
  int duration;
  int wid;
  CalorieByDurationEvent({required this.duration, required this.wid});
}

class FirstTimeAnimatorEvent extends CalorieEvent {
  
}
