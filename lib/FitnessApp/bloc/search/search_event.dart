import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/SearchFood.dart';
import 'package:firsstapp/FitnessApp/models/Searchfoodr.dart';
import 'package:firsstapp/FitnessApp/models/serachworkoutto.dart';

class SearchEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchFoodEvent extends SearchEvent {
  final SearchFModel sfood;
  final bool isempty;
  SearchFoodEvent({required this.sfood, required this.isempty});
}

class SearchInitEvent extends SearchEvent {}

class SearchWorkoutEvent extends SearchEvent {
  final SearchWorkoutTo swmodel;
  final bool isempty;
  SearchWorkoutEvent({required this.isempty,required this.swmodel});
}
