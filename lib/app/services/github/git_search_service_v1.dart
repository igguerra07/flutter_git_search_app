import 'package:dio/dio.dart';
import 'package:git_app/app/errors/error_handler.dart';
import 'package:git_app/app/models/user_model.dart';
import 'package:git_app/app/services/github/git_search_service.dart';

class GitSearchServiceV1 implements GitSearchService {
  late final Dio _dio;

  GitSearchServiceV1({
    required Dio dio,
  }) {
    _dio = dio;
    _dio.options.baseUrl = GitSearchService.baseUrl;
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await ErrorHandler.handleApi(
      () => _dio.get(GitSearchService.users),
    );
    return UserModel.fromJsonList(response);
  }

  @override
  Future<UserModel> findUserByUsername({
    required String username,
  }) async {
    final path = GitSearchService.findUserByLogin.replaceAll(
      ":username:",
      username,
    );
    final response = await ErrorHandler.handleApi(() => _dio.get(path));
    return UserModel.fromJson(response);
  }
}
