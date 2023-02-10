import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/Searchfoodr.dart';

class Search2Event extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchFTranslate extends Search2Event {
  final SearchFoodr sfood;
  SearchFTranslate({required this.sfood});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchInitEvent2 extends Search2Event {}

class SearchWTranslateEvent extends Search2Event {}
