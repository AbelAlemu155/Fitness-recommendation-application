import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/MealPlan.dart';

class MultipleFoods extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];

  List<Breakfast> bs;
  List<Lunch> ls;
  List<Dinner> ds;
  List<Snack> ss;
  String prevb;
  String prevl;
  String prevd;
  String prevs;
  String nextb;
  String nextl;
  String nextd;
  String nexts;
  MultipleFoods(
      {required this.bs,
      required this.ds,
      required this.ls,
      required this.nextb,
      required this.nextd,
      required this.nextl,
      required this.nexts,
      required this.prevb,
      required this.prevd,
      required this.prevl,
      required this.prevs,
      required this.ss});

  factory MultipleFoods.fromJson(Map<String, dynamic> json) {
    final prevb = json['prevb'] == null ? '' : json['prevb'];
    final prevl = json['prevl'] == null ? '' : json['prevl'];
    final prevd = json['prevd'] == null ? '' : json['prevd'];
    final prevs = json['prevs'] == null ? '' : json['prevs'];
    final nextb = json['nextb'] == null ? '' : json['nextb'];
    final nextl = json['nextl'] == null ? '' : json['nextl'];
    final nextd = json['nextd'] == null ? '' : json['nextd'];
    final nexts = json['nexts'] == null ? '' : json['nexts'];

    return MultipleFoods(
        bs: json['breakfast'],
        ds: json['dinner'],
        ls: json['lunch'],
        nextb: nextb,
        nextd: nextd,
        nextl: nextl,
        nexts: nexts,
        prevb: prevb,
        prevd: prevd,
        prevl: prevl,
        prevs: prevs,
        ss: json['snack']);
  }
}
