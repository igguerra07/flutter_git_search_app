import 'package:dartz/dartz.dart';
import 'package:git_app/app/errors/failures.dart';
import 'package:git_app/app/models/user_model.dart';
import 'package:git_app/app/repositories/git_search_repository.dart';

class GetUsersUseCase {
  late GitHubSearchRepository _repository;

  GetUsersUseCase({
    required GitHubSearchRepository repository,
  }) {
    _repository = repository;
  }

  Future<Either<Failure, List<UserModel>>> call() {
    return _repository.getUsers();
  }
}
