import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/DailyLog.dart';

class LogState extends Equatable {
  const LogState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FoodLoadSuccess2 extends LogState {
  List<DailyLogModel> dlogs;
  FoodLoadSuccess2({required this.dlogs});
}

class FoodLoadProgress2 extends LogState {}

class FoodLoadFailure2 extends LogState {
  final String message;
  FoodLoadFailure2({required this.message});
}

class FoodLogInitial2 extends LogState {}

