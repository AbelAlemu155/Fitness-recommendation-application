import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/factor.dart';

abstract class Plan2Event extends Equatable {
  const Plan2Event();
}

class AnimatorEvent extends Plan2Event {
  int index;
  AnimatorEvent({required this.index});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DragabbleEvent extends Plan2Event {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserWorkoutsLoadEvent extends Plan2Event {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ImageSlideEvent extends Plan2Event {
  List<Object?> get props => [];
}

class ImageSlideInitEvent extends Plan2Event {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}


