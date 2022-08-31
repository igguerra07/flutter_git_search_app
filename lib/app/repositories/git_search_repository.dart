import 'package:dartz/dartz.dart';
import 'package:git_app/app/errors/failures.dart';
import 'package:git_app/app/models/user_model.dart';

abstract class GitHubSearchRepository {
  Future<Either<Failure, List<UserModel>>> getUsers();
  Future<Either<Failure, UserModel?>> findUserByUsername({
    required String username,
  });
}
