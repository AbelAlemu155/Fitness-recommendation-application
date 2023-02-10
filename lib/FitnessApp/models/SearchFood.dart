import 'package:equatable/equatable.dart';

class SearchFModel extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];

  int page;
  String keyword;
  int type;
  int count;
  int category;
  bool sort;
  SearchFModel(
      {required this.page,
      required this.keyword,
      required this.type,
      required this.count,
      required this.category,
      required this.sort});
}
