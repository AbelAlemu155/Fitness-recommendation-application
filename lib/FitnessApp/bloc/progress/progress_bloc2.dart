



import 'package:firsstapp/FitnessApp/bloc/progress/progress_event.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/progress_event2.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/progress_state.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/progress_state2.dart';
import 'package:firsstapp/FitnessApp/repository/plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressBloc2 extends Bloc<ProgressEvent2, ProgressState2> {
  final PlanRepository planRepository;

  ProgressBloc2({required this.planRepository})
      : assert(planRepository != null),
        super(progressInitialState2());

  @override
  Stream<ProgressState2> mapEventToState(ProgressEvent2 event) async* {
    yield progressInitialState2();
    if (event is setProgress2) {
      if (event.initial == null) {
        yield setProgressState2(calorie: event.calorie);
      }
    }
    
  }
}
