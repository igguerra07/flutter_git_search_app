import 'package:dartz/dartz.dart';
import 'package:git_app/app/datasources/remote/git_search_remote_data.dart';
import 'package:git_app/app/errors/exceptions.dart';
import 'package:git_app/app/errors/failures.dart';
import 'package:git_app/app/features/home/errors/api_rate_limit_exceeded.dart';
import 'package:git_app/app/features/home/errors/git_user_not_found.dart';
import 'package:git_app/app/models/user_model.dart';
import 'package:git_app/app/repositories/git_search_repository.dart';

class GitSearchRepositoryImpl implements GitHubSearchRepository {
  late final GitSearchRemoteDataSource _remote;

  GitSearchRepositoryImpl({
    required GitSearchRemoteDataSource remote,
  }) {
    _remote = remote;
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUsers() async {
    try {
      final users = await _remote.getUsers();
      return right(users);
    } catch (e) {
      if (e is NotFoundException) {
        return left(NotFoundFailure());
      }
      if (e is NoConnectionException) {
        return left(NoConnectionFailure());
      }
      if (e is NoAuthorizedException) {
        return left(ApiRateLimitExceeded());
      }
      return left(Failure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> findUserByUsername({
    required String username,
  }) async {
    try {
      final user = await _remote.getUserByUsername(username: username);
      return right(user);
    } catch (e) {
      if (e is NotFoundException) {
        return left(GithubUserNotFound(username: username));
      }
      if (e is NoAuthorizedException) {
        return left(ApiRateLimitExceeded());
      }
      if (e is NoConnectionException) {
        return left(NoConnectionFailure());
      }
      return left(Failure());
    }
  }
}
