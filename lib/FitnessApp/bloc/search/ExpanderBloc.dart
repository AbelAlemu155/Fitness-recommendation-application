import 'package:firsstapp/FitnessApp/bloc/search/expander_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'expander_event.dart';

class ExpanderBloc extends Bloc<ExpanderEvent, ExpanderState> {
  ExpanderBloc(ExpanderState initialState) : super(initialState);

  @override
  Stream<ExpanderState> mapEventToState(ExpanderEvent event) async* {
    // TODO: implement mapEventToState

    if (event is ExpandEvent) {
      yield ExpandInit();
      yield ExpandState(excontroller:event.excontroller);
    }
  }
}
