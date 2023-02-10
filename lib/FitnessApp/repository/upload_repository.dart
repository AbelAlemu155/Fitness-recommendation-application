import 'package:firsstapp/FitnessApp/data_provider/upload_provider.dart';
import 'package:firsstapp/FitnessApp/models/Blog.dart';
import 'package:firsstapp/FitnessApp/models/approval.dart';

class UploadRepository {
  final UploadProvider dataProvider;
  UploadRepository({required this.dataProvider}) : assert(dataProvider != null);

  Future<Blog> uploadPost(List<int> str, String title, String body) async {
    return await dataProvider.uploadPost(str, title, body);
  }

  Future<Approval> checkApproval(int trid) async {
    return await dataProvider.checkApproval(trid);
  }
}
