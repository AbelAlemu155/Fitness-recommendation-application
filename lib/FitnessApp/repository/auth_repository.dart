import 'package:firsstapp/FitnessApp/data_provider/auth_provider.dart';
import 'package:firsstapp/FitnessApp/models/user.dart';

class AuthRepository {
  final AuthDataProvider dataProvider;
  AuthRepository({required this.dataProvider}) : assert(dataProvider != null);

  Future<void> loginUser(String username, String password) async {
    await dataProvider.loginUser(username, password);
  }

  Future<bool> updateToken(User user, String username, String password) async {
    return await dataProvider.updateToken(user, username, password);
  }

  Future<void> registerUser(
      {required String username,
      required String password,
      required String email}) async {
    await dataProvider.registerUser(
        username: username, password: password, email: email);
  }

  Future<void> validateForm(
      {required String username, required String email}) async {
    await dataProvider.validateForm(username: username, email: email);
  }

  Future<void> validateForm2({required String email}) async {
    await dataProvider.validateForm2(email: email);
  }

  Future<String> sendEmail(String email) async {
    return await dataProvider.sendEmail(email);
  }

  Future<bool> isConfirmed() async {
    return await dataProvider.isConfirmed();
  }

  Future<void> finalConfirmation() async {
    await dataProvider.finalConfirmation();
  }

  Future<void> changePassword(String email, String password) async {
    await dataProvider.changePassword(email, password);
  }
}
