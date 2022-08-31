import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_app/app/features/home/cubit/home_state.dart';
import 'package:git_app/app/usecases/get_users.dart';

class HomeCubit extends Cubit<HomeState> {
  late final GetUsersUseCase _getUsers;

  HomeCubit({
    required GetUsersUseCase getUsers,
  }) : super(HomeInitialState()) {
    _getUsers = getUsers;
  }

  Future<void> getUsers() async {
    emit(HomeLoadingState());

    final eitherUsers = await _getUsers.call();

    eitherUsers.fold(
      (failure) => emit(HomeFailureState()),
      (users) => emit(HomeLoadedState(users: users)),
    );
  }
}
