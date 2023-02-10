import 'package:equatable/equatable.dart';

class UploadEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UploadPostEvent extends UploadEvent {
  List<int> bstr;
  String body;
  String title;
  UploadPostEvent(
      {required this.bstr, required this.body, required this.title});
}

class getApprovalEvent extends UploadEvent {
 
  int trainer_id;
  getApprovalEvent({required this.trainer_id});
}
