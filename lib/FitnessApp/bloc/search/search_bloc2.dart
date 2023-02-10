import 'package:firsstapp/FitnessApp/bloc/search/search_event2.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_state2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc2 extends Bloc<Search2Event, Search2> {
  SearchBloc2(Search2 initialState) : super(initialState);

  @override
  Stream<Search2> mapEventToState(Search2Event event) async* {
    // TODO: implement mapEventToState

    if (event is SearchFTranslate) {
      yield SearchFoodSuccess2(sfoods: event.sfood);
    }
    if (event is SearchInitEvent2) {
      yield SearchInit2();
    }
    if (event is SearchWTranslateEvent) {
      yield SearchWTranslate();
    }
  }
}
