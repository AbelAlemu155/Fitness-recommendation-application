import 'package:equatable/equatable.dart';

class SearchFoodr extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];

  List foods;
  String prev_url;
  String next_url;
  int count_b;
  int count_l;
  int count_s;
  int count_d;

  SearchFoodr(
      {required this.count_b,
      required this.count_d,
      required this.count_l,
      required this.count_s,
      required this.foods,
      required this.next_url,
      required this.prev_url});

  factory SearchFoodr.fromJson(Map<String, dynamic> json) {
    String nexturl = json['next_url'] == null ? '' : json['next_url'];
    String prevurl = json['prev_url'] == null ? '' : json['prev_url'];
    return SearchFoodr(
        count_b: json['count_b'],
        count_d: json['count_d'],
        count_l: json['count_l'],
        count_s: json['count_s'],
        foods: json['meal'],
        next_url: nexturl,
        prev_url: prevurl);
  }
}
