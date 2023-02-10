import 'package:equatable/equatable.dart';

class SearchWorkoutTo extends Equatable {
  int page;
  String keyword;
  int type;
  int cduration;

  int duration;
  int intensity;
  bool sort;
  int ctype;
  int cintensity;
  SearchWorkoutTo({required this.cduration,required this.cintensity,required this.ctype,required this.duration,required this.intensity,
  required this.keyword,required this.page,required this.sort,required this.type});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
