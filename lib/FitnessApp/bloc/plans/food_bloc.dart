import 'package:firsstapp/FitnessApp/bloc/plans/food_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/food_state.dart';
import 'package:firsstapp/FitnessApp/models/multiplefoods.dart';
import 'package:firsstapp/FitnessApp/repository/plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/cloudsearch/v1.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final PlanRepository planRepository;

  FoodBloc({required this.planRepository})
      : assert(planRepository != null),
        super(FoodLoadProgress());

  @override
  Stream<FoodState> mapEventToState(FoodEvent event) async* {
    if (event is FoodLoadEvent) {
      yield FoodLoadProgress();
      try {
        MultipleFoods fs = await planRepository.getAllFoods(event.page);
        yield FoodLoadSuccess(foods: fs);
      } catch (e) {
        yield FoodLoadFailure(message: '$e');
      }
    }
    if (event is DailyLog) {
      yield DailyPostProgress();
      try {
        final dlog = await planRepository.postDailyLog(event.dlog);
        yield DailyPostSuccess(dlog: dlog);
      } catch (e) {
        yield DailyPostFailure(message: '$e');
      }
    }
    if (event is FoodinitEvent) {
      yield Foodinit();
    }

    if (event is getAssignedFood) {
      yield AssignedFoodLoad();
      try {
        final ap = await planRepository.getAssignedMPlan(event.trid);
        yield AssignedFoodSuccess(dplan: ap);
      } catch (e) {
        print(e);
        yield AssignedFoodFail(message: '$e');
      }
    }
  }
}
