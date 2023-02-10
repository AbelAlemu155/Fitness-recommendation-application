import 'package:firsstapp/FitnessApp/data_provider/plan_provider.dart';
import 'package:firsstapp/FitnessApp/models/AssignFitnessPlan.dart';
import 'package:firsstapp/FitnessApp/models/DailyLog.dart';
import 'package:firsstapp/FitnessApp/models/factor.dart';
import 'package:firsstapp/FitnessApp/models/foodandwater.dart';
import 'package:firsstapp/FitnessApp/models/multiplefoods.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';

class PlanRepository {
  final PlanProvider dataProvider;

  PlanRepository({required this.dataProvider}) : assert(dataProvider != null);

  Future<void> createPlan(Factor factor) async {
    await dataProvider.createPlan(factor);
  }

  Future<List> getUserPlan() async {
    return await dataProvider.getUserPlan();
  }

  Future<List> LoadUserFood(int index) async {
    return await dataProvider.LoadUserFood(index);
  }

  Future<Fandwater> getWaterAndFood() async {
    return await dataProvider.getWaterAndFood();
  }

  Future<MultipleFoods> getAllFoods(int page) async {
    return await dataProvider.getAllFoods(page);
  }

  Future<WorkoutResponse> getAllWorkouts(int page) async {
    return await dataProvider.getAllWorkouts(page);
  }

  Future<DailyLogModel> postDailyLog(DailyLogModel dlog2) async {
    return await dataProvider.postDailyLog(dlog2);
  }

  Future<List<DailyLogModel>> getFoodLogs() async {
    return await dataProvider.getFoodLogs();
  }

  Future<double> drinkWater(double liter) async {
    return await dataProvider.drinkWater(liter);
  }

  Future<List<Exercise>> getWexercise(String url) async {
    return await dataProvider.getWexercise(url);
  }

  Future<double> getWCalorie(int id) async {
    return await dataProvider.getWCalorie(id);
  }

  Future<double> CalorieDuration(int duration, int wid) async {
    return await dataProvider.CalorieDuration(duration, wid);
  }

  Future<void> PerformWorkout(double effort, int wid, int duration) async {
    await dataProvider.PerformWorkout(effort, wid, duration);
  }

  Future<List> getWorkoutProgress() async {
    return await dataProvider.getWorkoutProgress();
  }

  Future<List> getFoodProgress() async {
    return await dataProvider.getFoodProgress();
  }

  Future<List> getWaterProgress() async {
    return await dataProvider.getWaterProgress();
  }

  Future<List<Workout>> WfromList(List<int> ids) async {
    return await dataProvider.WfromList(ids);
  }

  Future<AssignDietPlan> getAssignedMPlan(int trid) async {
    return await dataProvider.getAssignedMPlan(trid);
  }

  Future<AssignFitnessPlan> getAssignedFplan(int trid) async {
    return await dataProvider.getAssignedFplan(trid);
  }
}
