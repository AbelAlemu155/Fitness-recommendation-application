import 'package:firsstapp/FitnessApp/bloc/plans/workout_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_state.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';
import 'package:firsstapp/FitnessApp/repository/plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final PlanRepository planRepository;

  WorkoutBloc({required this.planRepository})
      : assert(planRepository != null),
        super(WorkoutLoadProgress());

  @override
  Stream<WorkoutState> mapEventToState(WorkoutEvent event) async* {
    if (event is WorkoutLoadEvent) {
      yield WorkoutLoadProgress();
      try {
        WorkoutResponse wts = await planRepository.getAllWorkouts(event.page);
        yield WorkoutLoadSuccess(wresponse: wts);
      } catch (e) {
        yield WorkoutLoadFailure(message: '$e');
      }
    }
    if (event is getWexerciseEvent) {
      yield getWExerciseLoad();
      try {
        final exs = await planRepository.getWexercise(event.wurl);
        yield getWExerciseSuccess(exs: exs);
      } catch (e) {
        yield getWExerciseFailure(message: '$e');
      }
    }
    if (event is ImageEvent) {
      yield ImageInit();
      yield ImageState(index: event.index);
    }
    if (event is getAssignedFplan) {
      yield AssignedWpLoad();
      try {
        final AFP = await planRepository.getAssignedFplan(event.trid);
        yield AssignedWpSuccess(fitplan: AFP);
      } catch (e) {
        yield AssignedWpFail(message: '$e');
      }
    }
    if (event is getWFromList) {
      yield getWlistload();
      try {
        final wkts = await planRepository.WfromList(event.ids);
        yield getWlistSuccess(wkts: wkts);
      } catch (e) {
        yield getWlistFail(message: '$e');
      }
    }
  }
}
