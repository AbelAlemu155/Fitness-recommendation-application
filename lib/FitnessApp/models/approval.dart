import 'package:equatable/equatable.dart';

class Approval extends Equatable {
  bool request;
  bool approval;
  Approval({required this.approval, required this.request});
  @override
  // TODO: implement props
  List<Object?> get props => [];

  factory Approval.fromJson(Map<String, dynamic> json) {
    return Approval(approval: json['approval'], request: json['request']);
  }
}
