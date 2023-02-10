import 'package:firsstapp/FitnessApp/data_provider/user_provider.dart';
import 'package:firsstapp/FitnessApp/models/MealPlan.dart';
import 'package:firsstapp/FitnessApp/models/Trainer.dart';
import 'package:firsstapp/FitnessApp/models/factor.dart';
import 'package:firsstapp/FitnessApp/models/user.dart';

class UserRepository {
  final UserProvider dataProvider;
  UserRepository({required this.dataProvider}) : assert(dataProvider != null);

  Future<User> getUser(String url) async {
    return await dataProvider.getUser(url);
  }

  Future<User> getUserByemail(String email) async {
    return await dataProvider.getUserByemail(email);
  }

  Future<Factor> getUserData(String email) async {
    return await dataProvider.getUserData(email);
  }

  Future<List<Trainer>> getApprovedTrainers() async {
    return await dataProvider.getApprovedTrainers();
  }

  Future<List<Breakfast>> foodFromList(List<int> ids, int id) async {
    return await dataProvider.foodFromList(ids, id);
  }

  Future<double> getwGoal() async {
    return await dataProvider.getwGoal();
  }
}
