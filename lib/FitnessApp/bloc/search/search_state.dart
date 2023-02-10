import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/Searchfoodr.dart';
import 'package:firsstapp/FitnessApp/models/searchworkoutfrom.dart';

class SearchState extends Equatable {
  const SearchState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchInit extends SearchState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchFoodLoad extends SearchState {}

class SearchFoodFail extends SearchState {
  final String message;
  SearchFoodFail({required this.message});
}

class SearchFoodSuccess extends SearchState {
  SearchFoodr sfoods;
  SearchFoodSuccess({required this.sfoods});
}

class SearchWorkoutLoad extends SearchState {}

class SearchWorkoutFail extends SearchState {
  final String message;
  SearchWorkoutFail({required this.message});
}

class SearchWorkoutSuccess extends SearchState {
  SearchWorkoutFrom swmodel;
  SearchWorkoutSuccess({required this.swmodel});
}
