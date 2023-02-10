import 'package:firsstapp/FitnessApp/bloc/auth_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/auth_state.dart';
import 'package:firsstapp/FitnessApp/bloc/blog_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/blog_event.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/plan2_state.dart';
import 'package:firsstapp/FitnessApp/bloc/plans/workout_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/progress/log_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/search/ExpanderBloc.dart';
import 'package:firsstapp/FitnessApp/bloc/search/expander_state.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_bloc2.dart';
import 'package:firsstapp/FitnessApp/bloc/search/search_state2.dart';
import 'package:firsstapp/FitnessApp/bloc/upload/upload_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/calorie_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/workout/permanent_bloc.dart';
import 'package:firsstapp/FitnessApp/repository/auth_repository.dart';
import 'package:firsstapp/FitnessApp/repository/upload_repository.dart';
import 'package:firsstapp/FitnessApp/repository/user_repository.dart';
import 'package:firsstapp/FitnessApp/screens/auth_route.dart';
import 'package:firsstapp/FitnessApp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'FitnessApp/bloc/plans/food_bloc.dart';
import 'FitnessApp/bloc/plans/plan2_bloc.dart';
import 'FitnessApp/bloc/plans/plan_bloc.dart';
import 'FitnessApp/bloc/progress/progress_bloc.dart';
import 'FitnessApp/bloc/progress/progress_bloc2.dart';
import 'FitnessApp/bloc/search/search_bloc.dart';
import 'FitnessApp/bloc/user_bloc.dart';
import 'FitnessApp/bloc/userdata/ud_bloc.dart';
import 'FitnessApp/data_provider/blog_provider.dart';
import 'FitnessApp/data_provider/plan_provider.dart';
import 'FitnessApp/data_provider/search_provider.dart';
import 'FitnessApp/data_provider/upload_provider.dart';
import 'FitnessApp/data_provider/user_provider.dart';
import 'FitnessApp/repository/blog_repository.dart';
import 'FitnessApp/repository/plan_repository.dart';
import 'FitnessApp/repository/search_repository.dart';
import 'bloc_observer.dart';
import 'FitnessApp/data_provider/auth_provider.dart';

Future<void> main() async {
  // Bloc.observer = SimpleBlocObserver();
  await GetStorage.init();
  if (LoginScreen.box.read('planCreated') == null) {
    LoginScreen.box.write('planCreated', false);
  }
  print(LoginScreen.box.read('firstday'));
  print(LoginScreen.box.read('username'));
  print(LoginScreen.box.read('password'));

  final AuthRepository authRepository = AuthRepository(
    dataProvider: AuthDataProvider(
      httpClient: http.Client(),
    ),
  );

  final BlogRepository blogRepository = BlogRepository(
    dataProvider: BlogProvider(
      httpClient: http.Client(),
    ),
  );

  final PlanRepository planRepository = PlanRepository(
    dataProvider: PlanProvider(
      httpClient: http.Client(),
    ),
  );

  final SearchRepository searchRepository = SearchRepository(
    dataProvider: SearchProvider(
      httpClient: http.Client(),
    ),
  );
  final UploadRepository uploadRepository = UploadRepository(
    dataProvider: UploadProvider(
      httpClient: http.Client(),
    ),
  );
  final UserRepository userRepository = UserRepository(
    dataProvider: UserProvider(
      httpClient: http.Client(),
    ),
  );

  runApp(
    FitnessApp(
      authRepository: authRepository,
      blogRepository: blogRepository,
      planRepository: planRepository,
      searchRepository: searchRepository,
      uploadRepository: uploadRepository,
      userRepository: userRepository,
    ),
  );
}

class FitnessApp extends StatelessWidget {
  final AuthRepository authRepository;
  final BlogRepository blogRepository;
  final PlanRepository planRepository;
  final SearchRepository searchRepository;
  final UploadRepository uploadRepository;
  final UserRepository userRepository;
  FitnessApp(
      {required this.authRepository,
      required this.blogRepository,
      required this.planRepository,
      required this.searchRepository,
      required this.uploadRepository,
      required this.userRepository})
      : assert(authRepository != null && blogRepository != null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: this.authRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) =>
                  AuthBloc(authRepository: this.authRepository),
            ),
            BlocProvider<PlanBloc>(
              create: (context) =>
                  PlanBloc(planRepository: this.planRepository),
            ),
            BlocProvider(
                create: (context) =>
                    BlogBloc(blogRepository: blogRepository)..add(BlogEvent())),
            BlocProvider(
              create: (context) => Plan2Bloc(Plan2CreateInit(),
                  planRepository: this.planRepository),
            ),
            BlocProvider(
                create: (context) =>
                    FoodLogBloc(planRepository: planRepository)),
            BlocProvider(
              create: (context) =>
                  WorkoutBloc(planRepository: this.planRepository),
            ),
            BlocProvider(
              create: (context) =>
                  FoodBloc(planRepository: this.planRepository),
            ),
            BlocProvider(
              create: (context) =>
                  UploadBloc(upRepository: this.uploadRepository),
            ),
            BlocProvider(
              create: (context) =>
                  UserBloc(userRepository: this.userRepository),
            ),
            BlocProvider(
              create: (context) =>
                  UdBloc(userRepository: this.userRepository),
            ),
            BlocProvider(
              create: (context) =>
                  ProgressBloc(planRepository: this.planRepository),
            ),
            BlocProvider(
              create: (context) =>
                  ProgressBloc2(planRepository: this.planRepository),
            ),
            BlocProvider(
              create: (context) =>
                  CalorieBloc(planRepository: this.planRepository),
            ),
            BlocProvider(
              create: (context) =>
                  PermanentBloc(planRepository: this.planRepository),
            ),
            BlocProvider(
              create: (context) =>
                  SearchBloc(searchRepository: this.searchRepository),
            ),
            BlocProvider(
              create: (context) => SearchBloc2(SearchInit2()),
            ),
            BlocProvider(
              create: (context) => ExpanderBloc(ExpandInit()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Social Fitness App',
            theme: ThemeData(
              primarySwatch: Colors.cyan,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: AuthRoute.generateRoute,
          ),
        ));
  }
}
