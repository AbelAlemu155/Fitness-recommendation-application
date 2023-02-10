

import 'package:equatable/equatable.dart';

class ProgressEvent2 extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class setProgress2 extends ProgressEvent2 {
  bool? initial;
  double calorie;
  setProgress2({required this.calorie, this.initial});
}

