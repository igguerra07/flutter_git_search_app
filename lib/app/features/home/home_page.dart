import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_app/app/datasources/remote/git_search_remote_data.dart';
import 'package:git_app/app/datasources/remote/git_search_remote_data_impl.dart';
import 'package:git_app/app/errors/failures.dart';
import 'package:git_app/app/features/home/cubit/home_cubit.dart';
import 'package:git_app/app/features/home/cubit/home_state.dart';
import 'package:git_app/app/features/home/errors/git_user_not_found.dart';
import 'package:git_app/app/features/home/widgets/user_item.dart';
import 'package:git_app/app/repositories/git_search_repository.dart';
import 'package:git_app/app/repositories/git_search_repository_impl.dart';
import 'package:git_app/app/services/git_search_service.dart';
import 'package:git_app/app/services/git_search_service_v1.dart';
import 'package:git_app/app/usecases/find_user_by_username.dart';
import 'package:git_app/app/usecases/get_users.dart';
import 'package:git_app/app/extensions/extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Dio _dio;
  late GitSearchService _apiService;
  late GitSearchRemoteDataSource _remote;
  late GitHubSearchRepository _repository;
  late GetUsersUseCase _getUsers;
  late FindUserByUsernameUseCase _findUserByUsername;
  late HomeCubit _cubit;

  @override
  void initState() {
    _dio = Dio();
    //api_client
    _apiService = GitSearchServiceV1(dio: _dio);
    _remote = GitSearchRemoteDataSourceImpl(apiService: _apiService);
    _repository = GitSearchRepositoryImpl(remote: _remote);
    _getUsers = GetUsersUseCase(repository: _repository);
    _findUserByUsername = FindUserByUsernameUseCase(repository: _repository);
    _cubit = HomeCubit(
      getUsers: _getUsers,
      findUserByUsername: _findUserByUsername,
    );
    super.initState();

    _cubit.getUsers();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE9EF),
      body: SafeArea(
        child: Column(
          children: [
            Material(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(8),
              ),
              elevation: 8,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF0063E1),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      context.l10n.globalAppName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      onChanged: (value) => _cubit.findUserByUsername(
                        username: value,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.search_rounded),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        hintText: context.l10n.homeSearchUserHint,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                bloc: _cubit,
                builder: (_, state) {
                  if (state is HomeLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is HomeFailureState) {
                    final failure = state.failure;
                    if (failure is NoConnectionFailure) {
                      return Center(
                        child: Text(context.l10n.globalNoConnectionError),
                      );
                    }
                    if (failure is GithubUserNotFound) {
                      return Center(
                        child: Text(context.l10n.homeGithubUserNotFound),
                      );
                    }
                    if (state.failure is NotFoundFailure) {
                      return Center(
                        child: Text(context.l10n.globalResourceNotFound),
                      );
                    }
                    return Center(
                      child: Text(context.l10n.globalResourceNotFound),
                    );
                  }
                  if (state is HomeEmptyState) {
                    return Center(
                      child: Text(context.l10n.homeEmptyUserList),
                    );
                  }

                  if (state is HomeLoadedState) {
                    return ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16),
                      itemCount: state.users.length,
                      itemBuilder: (_, index) => UserItem(
                        user: state.users[index],
                      ),
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
