import 'package:firsstapp/FitnessApp/bloc/auth_event.dart';
import 'package:firsstapp/FitnessApp/models/AssignFitnessPlan.dart';
import 'package:firsstapp/FitnessApp/models/Blog.dart';
import 'package:firsstapp/FitnessApp/models/MealPlan.dart';
import 'package:firsstapp/FitnessApp/models/factor.dart';
import 'package:firsstapp/FitnessApp/models/workout.dart';
import 'package:firsstapp/FitnessApp/screens/Progress/statScreen.dart';
import 'package:firsstapp/FitnessApp/screens/plans/Activity_ui.dart';
import 'package:firsstapp/FitnessApp/screens/plans/allscreens.dart';
import 'package:firsstapp/FitnessApp/screens/plans/diet_ui.dart';
import 'package:firsstapp/FitnessApp/screens/plans/fitness_level.dart';
import 'package:firsstapp/FitnessApp/screens/plans/food_details.dart';
import 'package:firsstapp/FitnessApp/screens/plans/food_plans.dart';
import 'package:firsstapp/FitnessApp/screens/plans/foodandwater/LogFood.dart';
import 'package:firsstapp/FitnessApp/screens/plans/foodandwater/LogWater.dart';
import 'package:firsstapp/FitnessApp/screens/plans/foodandwater/all_food.dart';
import 'package:firsstapp/FitnessApp/screens/plans/foodandwater/all_workout.dart';
import 'package:firsstapp/FitnessApp/screens/plans/goal_ui.dart';
import 'package:firsstapp/FitnessApp/screens/plans/goal_weight.dart';
import 'package:firsstapp/FitnessApp/screens/plans/num_weeks_screen.dart';
import 'package:firsstapp/FitnessApp/screens/plans/num_workout_screen.dart';
import 'package:firsstapp/FitnessApp/screens/plans/plans_screen.dart';
import 'package:firsstapp/FitnessApp/screens/plans/weight_height_ui.dart';
import 'package:firsstapp/FitnessApp/screens/plans/workout_plans.dart';
import 'package:firsstapp/FitnessApp/screens/post.dart';
import 'package:firsstapp/FitnessApp/screens/post/create_postscreen.dart';
import 'package:firsstapp/FitnessApp/screens/profile/profile_screen.dart';
import 'package:firsstapp/FitnessApp/screens/signup_screen.dart';
import 'package:firsstapp/FitnessApp/screens/trainer/trainer_diet_plan.dart';
import 'package:firsstapp/FitnessApp/screens/trainer/trainer_plans.dart';
import 'package:firsstapp/FitnessApp/screens/trainer/trainer_screen.dart';
import 'package:firsstapp/FitnessApp/screens/trainer/trainer_workout_plan.dart';
import 'package:firsstapp/FitnessApp/screens/workout/exercise_screen.dart';
import 'package:firsstapp/FitnessApp/screens/workout/workout_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'confirmation_screen.dart';
import 'forgot_screen.dart';
import 'home.dart';
import 'login_screen.dart';

class AuthRoute {
  static Route generateRoute(RouteSettings settings) {
    if (LoginScreen.box.read('username') != null &&
        LoginScreen.box.read('password') != null &&
        settings.name == '/') {
      bool checker = LoginScreen.box.read('isconfirmed') ?? false;
      bool planCreated = LoginScreen.box.read('planCreated');
      if (checker && !planCreated) {
        return MaterialPageRoute(builder: (context) => Goal());
      }

      if (checker && planCreated) {
        return MaterialPageRoute(builder: (context) => AllScreen());
      }

      return MaterialPageRoute(
          builder: (context) => LoginScreen(ConfirmationEvent(), true));
      //  return MaterialPageRoute(builder: (context) => LoginScreen());
    }
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => LoginScreen());
    }
    if (settings.name == '/homescreen') {
      return MaterialPageRoute(builder: (context) => HomeScreen());
    }
    if (settings.name == '/signupscreen') {
      return MaterialPageRoute(builder: (context) => SignupScreen());
    }
    if (settings.name == '/postscreen') {
      final arg = settings.arguments as Blog;

      return MaterialPageRoute(builder: (context) => PostScreen(post: arg));
    }
    if (settings.name == CreatePostScreen.routeName) {
      return MaterialPageRoute(builder: (context) => CreatePostScreen());
    }
    if (settings.name == TrainerPlanScreen.routeName) {
      final arg = settings.arguments as int;
      return MaterialPageRoute(
          builder: (context) => TrainerPlanScreen(trid: arg));
    }

    if (settings.name == '/forgotscreen') {
      return MaterialPageRoute(builder: (context) => ForgotScreen());
    }
    if (settings.name == TrainerScreen.routeName) {
      return MaterialPageRoute(builder: (context) => TrainerScreen());
    }

    if (settings.name == ProfileScreen.routeName) {
      return MaterialPageRoute(builder: (context) => ProfileScreen());
    }
    if (settings.name == '/activityquestion') {
      final factor = settings.arguments as Factor;
      return MaterialPageRoute(
          builder: (context) => Activity(
                factor: factor,
              ));
    }
    if (settings.name == TrainerDietPlan.routeName) {
      final Asdplan = settings.arguments as AssignDietPlan;
      return MaterialPageRoute(
          builder: (context) => TrainerDietPlan(dplan: Asdplan));
    }
    if (settings.name == TrainerWorkoutScreen.routeName) {
      final Asplan = settings.arguments as AssignFitnessPlan;
      return MaterialPageRoute(
          builder: (context) => TrainerWorkoutScreen(fplan: Asplan));
    }
    if (settings.name == '/dietquestion') {
      final factor = settings.arguments as Factor;
      return MaterialPageRoute(
          builder: (context) => Diet(
                factor: factor,
              ));
    }
    if (settings.name == '/goalquestion') {
      return MaterialPageRoute(builder: (context) => Goal());
    }
    if (settings.name == '/generalquestion') {
      final factor = settings.arguments as Factor;
      return MaterialPageRoute(
          builder: (context) => GWH(
                factor: factor,
              ));
    }
    if (settings.name == '/goalweightscreen') {
      final factor = settings.arguments as Factor;
      return MaterialPageRoute(
          builder: (context) => GoalWeight(factor: factor));
    }
    if (settings.name == '/numweeksscreen') {
      final factor = settings.arguments as Factor;
      return MaterialPageRoute(builder: (context) => NumWeeks(factor: factor));
    }
    if (settings.name == NumDays.routeName) {
      final factor = settings.arguments as Factor;
      return MaterialPageRoute(builder: (context) => NumDays(factor: factor));
    }
    if (settings.name == FitnessLevel.routeName) {
      final factor = settings.arguments as Factor;
      return MaterialPageRoute(
          builder: (context) => FitnessLevel(factor: factor));
    }
    if (settings.name == PlansScreen.routeName) {
      return MaterialPageRoute(builder: (context) => PlansScreen());
    }
    if (settings.name == WorkoutDetailScreen.routeName) {
      final wkt = settings.arguments as Workout;
      return MaterialPageRoute(
          builder: (context) => WorkoutDetailScreen(wkt: wkt));
    }
    if (settings.name == ExerciseScreen.routeName) {
      final ls = settings.arguments as List;
      final exs = ls[0];
      final img = ls[1];
      final wkt = ls[2];
      return MaterialPageRoute(
          builder: (context) => ExerciseScreen(
                exs: exs,
                img: img,
                wk: wkt,
              ));
    }
    if (settings.name == WorkoutPlanScreen.routeName) {
      return MaterialPageRoute(builder: (context) => WorkoutPlanScreen());
    }
    if (settings.name == StatScreen.routeName) {
      return MaterialPageRoute(builder: (context) => StatScreen());
    }

    if (settings.name == FoodPlansScreen.routeName) {
      return MaterialPageRoute(builder: (context) => FoodPlansScreen());
    }
    if (settings.name == FoodDetailScreen.routeName) {
      final args = settings.arguments as Map;
      if (args.containsKey(1)) {
        Breakfast bfast = args[1] as Breakfast;
        Map<int, Breakfast> map = {1: bfast};
        return MaterialPageRoute(
            builder: (context) => FoodDetailScreen(
                  args: map,
                ));
      } else if (args.containsKey(2)) {
        Lunch bfast = args[2] as Lunch;
        Map<int, Lunch> map = {2: bfast};
        return MaterialPageRoute(
            builder: (context) => FoodDetailScreen(
                  args: map,
                ));
      } else if (args.containsKey(3)) {
        Dinner bfast = args[3] as Dinner;
        Map<int, Dinner> map = {3: bfast};
        return MaterialPageRoute(
            builder: (context) => FoodDetailScreen(
                  args: map,
                ));
      } else if (args.containsKey(4)) {
        Snack bfast = args[4] as Snack;
        Map<int, Snack> map = {4: bfast};
        return MaterialPageRoute(
            builder: (context) => FoodDetailScreen(
                  args: map,
                ));
      }
    }
    if (settings.name == LogFoodScreen.routeName) {
      final pvalue = settings.arguments as Map;
      return MaterialPageRoute(
          builder: (context) => LogFoodScreen(pvalue: pvalue));
    }

    if (settings.name == LogWaterScreen.routeName) {
      final pvalue = settings.arguments as Map;
      return MaterialPageRoute(
          builder: (context) => LogWaterScreen(pvalue: pvalue));
    }

    if (settings.name == AllFoodScreen.routeName) {
      return MaterialPageRoute(builder: (context) => AllFoodScreen());
    }
    if (settings.name == AllWorkoutScreen.routeName) {
      return MaterialPageRoute(builder: (context) => AllWorkoutScreen());
    }
    if (settings.name == AllScreen.routeName) {
      return MaterialPageRoute(builder: (context) => AllScreen());
    }

    return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
