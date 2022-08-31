import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:git_app/app/datasources/remote/git_search_remote_data.dart';
import 'package:git_app/app/datasources/remote/git_search_remote_data_impl.dart';
import 'package:git_app/app/features/home/cubit/home_cubit.dart';
import 'package:git_app/app/features/home/cubit/home_state.dart';
import 'package:git_app/app/features/home/widgets/user_item.dart';
import 'package:git_app/app/repositories/git_search_repository.dart';
import 'package:git_app/app/repositories/git_search_repository_impl.dart';
import 'package:git_app/app/services/git_search_service.dart';
import 'package:git_app/app/services/git_search_service_v1.dart';
import 'package:git_app/app/usecases/get_users.dart';

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
  late HomeCubit _cubit;

  @override
  void initState() {
    _dio = Dio();
    //api_client
    _apiService = GitSearchServiceV1(dio: _dio);
    _remote = GitSearchRemoteDataSourceImpl(apiService: _apiService);
    _repository = GitSearchRepositoryImpl(remote: _remote);
    _getUsers = GetUsersUseCase(repository: _repository);
    _cubit = HomeCubit(getUsers: _getUsers);
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
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: _cubit,
          builder: (_, state) {
            if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is HomeFailureState) {
              return const Center(
                child: Text("Something was wrong..."),
              );
            }

            if (state is HomeLoadedState) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Git Search",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.search_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: "Search user",
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16),
                      itemCount: state.users.length,
                      itemBuilder: (_, index) =>
                          UserItem(user: state.users[index]),
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
