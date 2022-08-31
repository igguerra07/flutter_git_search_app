import 'package:equatable/equatable.dart';
import 'package:git_app/app/models/user_model.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [null];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<UserModel> users;

  HomeLoadedState({
    required this.users,
  });

  @override
  List<Object?> get props => [users];
}

class HomeFailureState extends HomeState {}
