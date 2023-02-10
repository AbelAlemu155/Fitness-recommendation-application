import 'package:equatable/equatable.dart';
import 'package:expandable/expandable.dart';

class ExpanderState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ExpandState extends ExpanderState {
  ExpandableController excontroller;
  ExpandState({required this.excontroller});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ExpandInit extends ExpanderState {}
