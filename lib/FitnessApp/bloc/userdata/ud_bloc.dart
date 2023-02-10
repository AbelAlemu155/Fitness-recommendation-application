import 'package:firsstapp/FitnessApp/bloc/userdata/ud_event.dart';
import 'package:firsstapp/FitnessApp/bloc/userdata/ud_state.dart';
import 'package:firsstapp/FitnessApp/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UdBloc extends Bloc<UdEvent, UdState> {
  final UserRepository userRepository;

  UdBloc({required this.userRepository})
      : assert(userRepository != null),
        super(UdInit());

  @override
  Stream<UdState> mapEventToState(UdEvent event) async* {
    if (event is UdLoadEvent) {
      yield UdLoadProgress();
      try {
        final factor = await userRepository.getUserData(event.email);
        yield UdLoadSuccess(factor: factor);
      } catch (e) {
        yield UdLoadFail(message: '$e');
      }
    }
    if (event is FoodFromList) {
      yield FListLoad();
      try {
        final meals = await userRepository.foodFromList(event.ids, event.index);
        yield FListSuccess(bfs: meals);
      } catch (e) {
        yield FListFail(message: '$e');
      }
    }
  }
}
