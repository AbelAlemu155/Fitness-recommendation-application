import 'package:firsstapp/FitnessApp/bloc/progress/progress_event.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/progress_state.dart';
import 'package:firsstapp/FitnessApp/repository/plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final PlanRepository planRepository;

  ProgressBloc({required this.planRepository})
      : assert(planRepository != null),
        super(progressInitialState());

  @override
  Stream<ProgressState> mapEventToState(ProgressEvent event) async* {
    yield progressInitialState();
    if (event is setProgress) {
      if (event.initial == null) {
        yield setProgressState(calorie: event.calorie);
      }
    }
    
  }
}
