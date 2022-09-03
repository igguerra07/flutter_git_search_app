import 'package:git_app/app/models/user_model.dart';

abstract class GitSearchRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> getUserByUsername({
    required String username,
  });
}
