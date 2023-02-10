import 'package:firsstapp/FitnessApp/bloc/user_event.dart';
import 'package:firsstapp/FitnessApp/bloc/user_state.dart';
import 'package:firsstapp/FitnessApp/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository})
      : assert(userRepository != null),
        super(UserInit());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserLoadEvent) {
      yield UserLoadProgress();
      try {
        final user = await userRepository.getUser(event.url);
        yield UserLoadSuccess(user: user, ind: event.idx);
      } catch (e) {
        yield UserLoadFail(message: '$e', ind: event.idx);
      }
    }
    if (event is UserByEmail) {
      yield UserByEmailLoad();
      try {
        final user = await userRepository.getUserByemail(event.email);
        yield UserByEmailSuccess(user: user);
      } catch (e) {
        yield UserByEmailFail(message: '$e');
      }
    }
    if (event is getWgoal) {
      yield WgoalLoad();
      try {
        final goal = await userRepository.getwGoal();
        yield WgoalSuccess(goal: goal);
      } catch (e) {
        yield WgoalFail(message: '$e');
      }
    }
    if (event is TrainerLoadEvent) {
      yield TrainerLoadProgress();
      try {
        final trs = await userRepository.getApprovedTrainers();
        yield TrainerLoadSuccess(trainers: trs);
      } catch (e) {
        yield TrainerLoadFail(message: '$e');
      }
    }
  }
}
