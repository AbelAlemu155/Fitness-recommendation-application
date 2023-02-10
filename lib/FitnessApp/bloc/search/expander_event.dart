import 'package:equatable/equatable.dart';
import 'package:expandable/expandable.dart';

class ExpanderEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ExpandEvent extends ExpanderEvent {
  final ExpandableController excontroller;
  ExpandEvent({required this.excontroller});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ExpandInitEvent extends ExpanderEvent {}
