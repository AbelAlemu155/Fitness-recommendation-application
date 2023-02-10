import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/MealPlan.dart';
import 'package:firsstapp/FitnessApp/models/factor.dart';

class UdState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UdLoadFail extends UdState {
  final String message;
  UdLoadFail({required this.message});
}

class UdLoadSuccess extends UdState {
  Factor factor;
  UdLoadSuccess({required this.factor});
}

class UdLoadProgress extends UdState {}

class UdInit extends UdState {}

class FListSuccess extends UdState {
  List<Breakfast> bfs;
  FListSuccess({required this.bfs});
}

class FListLoad extends UdState {}

class FListFail extends UdState {
  final String message;
  FListFail({required this.message});
}
