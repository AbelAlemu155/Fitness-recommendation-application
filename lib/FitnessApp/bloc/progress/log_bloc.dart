import 'package:firsstapp/FitnessApp/bloc/progress/log_event.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/log_state.dart';
import 'package:firsstapp/FitnessApp/repository/plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodLogBloc extends Bloc<LogEvent, LogState> {
  final PlanRepository planRepository;

  FoodLogBloc({required this.planRepository})
      : assert(planRepository != null),
        super(FoodLoadProgress2());

  @override
  Stream<LogState> mapEventToState(LogEvent event) async* {
    if (event is FoodLogLoad) {
      yield FoodLoadProgress2();
      try {
        final fs = await planRepository.getFoodLogs();
        yield FoodLoadSuccess2(dlogs: fs);
      } catch (e) {
        yield FoodLoadFailure2(message: '$e');
      }
    }
    
  }
}
