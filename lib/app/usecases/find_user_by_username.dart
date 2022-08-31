import 'package:dartz/dartz.dart';
import 'package:git_app/app/errors/failures.dart';
import 'package:git_app/app/models/user_model.dart';
import 'package:git_app/app/repositories/git_search_repository.dart';

class FindUserByUsernameUseCase {
  late GitHubSearchRepository _repository;

  FindUserByUsernameUseCase({
    required GitHubSearchRepository repository,
  }) {
    _repository = repository;
  }

  Future<Either<Failure, UserModel?>> call({
    required String username,
  }) {
    return _repository.findUserByUsername(username: username);
  }
}
