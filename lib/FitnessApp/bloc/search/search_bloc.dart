import 'package:firsstapp/FitnessApp/bloc/search/search_event.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_state.dart';
import 'package:firsstapp/FitnessApp/repository/search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc({required this.searchRepository})
      : assert(searchRepository != null),
        super(SearchInit());
  @override
  Stream<SearchState> mapEventToState(event) async* {
    if (event is SearchFoodEvent) {
      yield SearchFoodLoad();
      try {
        final sfr =
            await searchRepository.searchFood(event.sfood, event.isempty);
        yield SearchFoodSuccess(sfoods: sfr);
      } catch (e) {
        yield SearchFoodFail(message: '$e');
      }
    }
    if (event is SearchInitEvent) {
      yield SearchInit();
    }
    if (event is SearchWorkoutEvent) {
      yield SearchWorkoutLoad();
      try {
        final swfrom =
            await searchRepository.searchWorkout(event.swmodel, event.isempty);
        yield SearchWorkoutSuccess(swmodel: swfrom);
      } catch (e) {
        yield SearchWorkoutFail(message: '$e');
      }
    }
  }
}
