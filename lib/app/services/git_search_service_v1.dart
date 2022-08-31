import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:git_app/app/models/user_model.dart';
import 'package:git_app/app/services/git_search_service.dart';

class GitSearchServiceV1 implements GitSearchService {
  late final Dio _dio;

  GitSearchServiceV1({
    required Dio dio,
  }) {
    _dio = dio;

    _dio.options.baseUrl = GitSearchService.baseUrl;

    _dio.interceptors.add(LogInterceptor());
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _dio.get(GitSearchService.users);
      final data = response.data;
      return UserModel.fromJsonList(data);
    } catch (e) {
      //errorHandler
      //format
      //socket
      //response
      debugPrint(e.toString());
      return [];
    }
  }
}