import 'dart:io';

import 'package:dio/dio.dart';
import 'package:git_app/app/errors/exceptions.dart';
import 'package:git_app/app/models/api_error.dart';

class ErrorHandler {
  static Future handleApi(Future Function() request) async {
    try {
      final response = await request();
      return response.data;
    } on DioError catch (ex) {
      switch (ex.type) {
        case DioErrorType.sendTimeout:
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
          throw const NoConnectionException();
        case DioErrorType.response:
          final error = ApiResponseError.fromJson(ex.response?.data);
          switch (ex.response?.statusCode) {
            case 404:
              throw NotFoundException(
                path: "${ex.requestOptions.baseUrl}${ex.requestOptions.path}",
                message: error.message,
              );
            default:
              throw ServerResponseException(
                statusCode: ex.response?.statusCode ?? -1,
                message: error.message,
              );
          }
        case DioErrorType.other:
          if (ex.error is SocketException) {
            throw const NoConnectionException();
          }
          rethrow;
        default:
          rethrow;
      }
    }
  }

  static handleCache() {}
}
