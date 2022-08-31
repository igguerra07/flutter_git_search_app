import 'package:dartz/dartz.dart';
import 'package:git_app/app/datasources/remote/git_search_remote_data.dart';
import 'package:git_app/app/models/user_model.dart';
import 'package:git_app/app/errors/failures.dart';
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
      return left(Failure());
    }
  }
}
