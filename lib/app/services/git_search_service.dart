import 'package:git_app/app/models/user_model.dart';

abstract class GitSearchService {
  static const baseUrl = "https://api.github.com/";
  static const users = "users";
  static const findUserByLogin = "users/:username:";

  Future<List<UserModel>> getUsers();
  Future<UserModel?> findUserByUsername({
    required String username,
  });
}
