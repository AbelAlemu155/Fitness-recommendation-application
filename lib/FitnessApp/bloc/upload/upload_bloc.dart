import 'package:firsstapp/FitnessApp/bloc/upload/upload_event.dart';
import 'package:firsstapp/FitnessApp/bloc/upload/upload_state.dart';
import 'package:firsstapp/FitnessApp/models/approval.dart';
import 'package:firsstapp/FitnessApp/repository/upload_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UploadRepository upRepository;

  UploadBloc({required this.upRepository})
      : assert(upRepository != null),
        super(UploadInit());

  @override
  Stream<UploadState> mapEventToState(UploadEvent event) async* {
    if (event is UploadPostEvent) {
      yield UploadPostLoad();
      try {
        final post =
            await upRepository.uploadPost(event.bstr, event.title, event.body);
        yield UploadPostSuccess(post: post);
      } catch (e) {
        yield UploadPostFail(message: '$e');
      }
    }
    if (event is getApprovalEvent) {
      yield ApprovalLoad();
      try {
        Approval ap = await upRepository.checkApproval(event.trainer_id);
        if (ap.approval) {
          yield ApprovalCompleted(trid: event.trainer_id);
        } else if (ap.request) {
          yield ApprovalPending(trid: event.trainer_id);
        } else {
          yield ApprovalNotRequested(trid:  event.trainer_id);
        }
      } catch (e) {
        yield ApprovalFail(message: '$e');
      }
    }
  }
}
