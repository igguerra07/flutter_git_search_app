import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_app/app/features/home/cubit/home_state.dart';
import 'package:git_app/app/usecases/find_user_by_username.dart';
import 'package:git_app/app/usecases/get_users.dart';

class HomeCubit extends Cubit<HomeState> {
  late final GetUsersUseCase _getUsers;
  late final FindUserByUsernameUseCase _findUserByUsername;

  Timer? _debounce;

  HomeCubit({
    required GetUsersUseCase getUsers,
    required FindUserByUsernameUseCase findUserByUsername,
  }) : super(HomeInitialState()) {
    _getUsers = getUsers;
    _findUserByUsername = findUserByUsername;
  }

  Future<void> getUsers() async {
    emit(HomeLoadingState());

    final eitherUsers = await _getUsers.call();

    eitherUsers.fold(
      (failure) => emit(HomeFailureState(failure: failure)),
      (users) => users.isNotEmpty
          ? emit(HomeLoadedState(users: users))
          : emit(HomeEmptyState()),
    );
  }

  Future<void> findUserByUsername({
    required String username,
  }) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () async {
        if (username.trim().isEmpty) getUsers();

        final eitherUser = await _findUserByUsername.call(
          username: username,
        );

        eitherUser.fold(
          (failure) => emit(HomeFailureState(failure: failure)),
          (user) {
            if (state is HomeLoadedState) {
              final newState = state as HomeLoadedState;
              emit(newState.copyWith(users: [user]));
              return;
            }
            emit(HomeLoadedState(users: [user]));
          },
        );
      },
    );
  }
}
