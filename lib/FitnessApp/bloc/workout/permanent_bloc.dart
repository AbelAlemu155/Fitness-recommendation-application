import 'package:firsstapp/FitnessApp/bloc/workout/Permanent_state.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/permanent_event.dart';
import 'package:firsstapp/FitnessApp/repository/plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermanentBloc extends Bloc<PermanentEvent, PermanentState> {
  final PlanRepository planRepository;

  PermanentBloc({required this.planRepository})
      : assert(planRepository != null),
        super(PermanentInit());

  @override
  Stream<PermanentState> mapEventToState(PermanentEvent event) async* {
    if (event is PermanentWorkout) {
      yield PermanentProgress();
      try {
        await planRepository.PerformWorkout(
            event.effort, event.wid, event.duration);
        yield PermanentSuccess();
      } catch (e) {
        yield PermanentFail(message: '$e');
      }
    }
    if (event is WaterStatEvent) {
      yield WaterStatLoad();
      try {
        final intakes = await planRepository.getWaterProgress();

        yield WaterStatSuccess(intakes: intakes[0], recintake: intakes[1]);
        print('xxxxxxxxxxxxx');
      } catch (e) {
        yield WaterStatFail(message: '$e');
      }
    }
    if (event is WorkoutStatEvent) {
      yield WorkoutStatLoad();
      try {
        final wcals = await planRepository.getWorkoutProgress();
        yield WorkoutStatSuccess(wcals: wcals[0], reccal: wcals[1]);
      } catch (e) {
        yield WorkoutStatFail(message: '$e');
      }
    }
    if (event is FoodStatEvent) {
      yield FoodStatLoad();
      try {
        final cals = await planRepository.getFoodProgress();
        yield FoodStatSuccess(fcals: cals[0], reccal: cals[1]);
      } catch (e) {
        yield FoodStatFail(message: '$e');
      }
    }
  }
}
