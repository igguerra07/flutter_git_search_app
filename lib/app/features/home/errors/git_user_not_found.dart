import 'package:git_app/app/errors/failures.dart';

class GithubUserNotFound extends NotFoundFailure {
  final String username;

  GithubUserNotFound({
    required this.username,
  });
}
