import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/Blog.dart';

class UploadState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UploadPostSuccess extends UploadState {
  Blog post;
  UploadPostSuccess({required this.post});
}

class UploadPostFail extends UploadState {
  final String message;
  UploadPostFail({required this.message});
}

class UploadPostLoad extends UploadState {}

class UploadInit extends UploadState {}

class ApprovalLoad extends UploadState {}

class ApprovalFail extends UploadState {
  final String message;

  ApprovalFail({required this.message});
}

class ApprovalPending extends UploadState {
  int trid;
  ApprovalPending({required this.trid});
}

class ApprovalNotRequested extends UploadState {
  int trid;
  ApprovalNotRequested ({required this.trid});
}

class ApprovalCompleted extends UploadState {
  int trid;
  ApprovalCompleted({required this.trid});
}
