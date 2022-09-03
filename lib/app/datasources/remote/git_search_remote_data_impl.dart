import 'package:git_app/app/datasources/remote/git_search_remote_data.dart';
import 'package:git_app/app/models/user_model.dart';
import 'package:git_app/app/services/git_search_service.dart';

class GitSearchRemoteDataSourceImpl implements GitSearchRemoteDataSource {
  late final GitSearchService _apiService;

  GitSearchRemoteDataSourceImpl({
    required GitSearchService apiService,
  }) {
    _apiService = apiService;
  }

  @override
  Future<List<UserModel>> getUsers() async {
    return await _apiService.getUsers();
  }

  @override
  Future<UserModel> getUserByUsername({
    required String username,
  }) {
    return _apiService.findUserByUsername(username: username);
  }
}
