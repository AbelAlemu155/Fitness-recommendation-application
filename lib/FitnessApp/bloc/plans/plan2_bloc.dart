import 'package:firsstapp/FitnessApp/bloc/plans/plan2_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_state.dart';
import 'package:firsstapp/FitnessApp/repository/plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Plan2Bloc extends Bloc<Plan2Event, Plan2State> {
  final PlanRepository planRepository;
  Plan2Bloc(Plan2State initialState, {required this.planRepository})
      : super(initialState);

  @override
  Stream<Plan2State> mapEventToState(Plan2Event event) async* {
    yield Plan2CreateInit();

    if (event is AnimatorEvent) {
      print('some111111111111');
      if (event.index == 1) {
        yield AnimatorChange();
      } else {
        print('some2');
        yield AnimatorClose(message: 'yesyes');
      }
    }

    if (event is UserWorkoutsLoadEvent) {
      yield workoutsLoadProgress();
      try {
        final wkts = await planRepository.getUserPlan();
        yield workoutLoadSuccess(workouts: wkts);
      } catch (e) {
        yield workoutLoadFailiure(message: '$e');
      }
    }
    if (event is ImageSlideEvent) {
      yield ImageSlideState();
    }
    if (event is ImageSlideInitEvent) {
      yield ImageSlideInit();
    }

    if (event is DragabbleEvent) {
      yield DraggableState();
    }
  }
}
