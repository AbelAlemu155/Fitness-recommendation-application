import 'package:firsstapp/FitnessApp/data_provider/search_provider.dart';
import 'package:firsstapp/FitnessApp/models/SearchFood.dart';
import 'package:firsstapp/FitnessApp/models/Searchfoodr.dart';
import 'package:firsstapp/FitnessApp/models/searchworkoutfrom.dart';
import 'package:firsstapp/FitnessApp/models/serachworkoutto.dart';

class SearchRepository {
  final SearchProvider dataProvider;

  SearchRepository({required this.dataProvider}) : assert(dataProvider != null);
  Future<SearchFoodr> searchFood(SearchFModel sfood, bool isempty) async {
    return await dataProvider.searchFood(sfood, isempty);
  }

  Future<SearchWorkoutFrom> searchWorkout(
      SearchWorkoutTo swto, bool isempty) async {
    return await dataProvider.searchWorkout(swto, isempty);
  }
}
