import 'package:firsstapp/FitnessApp/bloc/workout/calorie_event.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_state.dart';
import 'package:firsstapp/FitnessApp/repository/plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalorieBloc extends Bloc<CalorieEvent, CalorieState> {
  final PlanRepository planRepository;

  CalorieBloc({required this.planRepository})
      : assert(planRepository != null),
        super(WCalorieInit());

  @override
  Stream<CalorieState> mapEventToState(CalorieEvent event) async* {
    if (event is WCalorieEvent) {
      yield WCalorieLoad();
      try {
        final cal = await planRepository.getWCalorie(event.w_id);
        yield WCaloriesSuccess(calorie: cal);
      } catch (e) {
        yield WCalorieFail(message: '$e');
      }
    }
    if (event is TimerEvent) {
      yield TimerState(index: event.index);
    }
    if (event is TimerInitEvent) {
      yield TimerInit();
    }
    if (event is CalorieByDurationEvent) {
      yield CalorieByDurationLoad();
      try {
        final cal =
            await planRepository.CalorieDuration(event.duration, event.wid);
        yield CalorieByDurationSuccess(calories: cal);
      } catch (e) {
        yield CalorieByDurationFail(message: '$e');
      }
    }
    if (event is FirstTimeAnimatorEvent) {
      yield FirstTimeAnimatorState();
    }
  }
}
