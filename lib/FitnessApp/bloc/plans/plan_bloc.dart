import 'dart:io';

import 'package:firsstapp/FitnessApp/bloc/plans/plan_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan_state.dart';
import 'package:firsstapp/FitnessApp/repository/plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final PlanRepository planRepository;

  PlanBloc({required this.planRepository})
      : assert(planRepository != null),
        super(PlanCreateInit());

  @override
  Stream<PlanState> mapEventToState(PlanEvent event) async* {
    yield PlanCreateInit();
    if (event is PlanCreateEvent) {
      yield planCreationProgress();
      try {
        await planRepository.createPlan(event.factor);
        yield PlanCreationSuccess();
      } catch (e) {
        String str = '$e';
        if (e is SocketException) {
          yield PlanCreationFailure(message: 'Check your connection!');
        } else {
          String message = str.replaceAll('Exception ', '');
          yield PlanCreationFailure(message: message);
        }
      }
    }

    if (event is UserFoodLoadEvent) {
      yield UserFoodLoadProgress();

      try {
        final mplans = await planRepository.LoadUserFood(event.index);
        yield UserFoodLoadSuccess(mealPlans: mplans);
      } catch (e) {
        if (e is SocketException) {
          yield UserFoodLoadFailure(message: 'Check your connection!!');
        } else {
          String msg = '$e'.replaceAll('Exception: ', '');
          yield (UserFoodLoadFailure(message: msg));
        }
      }
    }
    if (event is FoodAndWaterEvent) {
      yield FoodAndWaterInProgress();

      try {
        final result = await planRepository.getWaterAndFood();
        yield FoodAndWaterSuccess(fwater: result);
      } catch (e) {
        if (e is SocketException) {
          yield FoodAndWaterFailure(message: 'Check your connection!!');
        } else {
          String msg = '$e'.replaceAll('Exception: ', '');
          yield (FoodAndWaterFailure(message: msg));
        }
      }
    }
    if (event is DrinkWaterEvent) {
      yield DrinkWaterProgress();
      try {
        print('first*************');
        final result = await planRepository.drinkWater(event.liter);
        print('second*************');
        yield DrinkWaterSuccess(liter: result);
      } catch (e) {
        yield DrinkWaterFailure(message: '$e');
      }
    }
    if (event is NullEvent) {
      yield NullInit();
      yield NullState();
    }
  }
}
