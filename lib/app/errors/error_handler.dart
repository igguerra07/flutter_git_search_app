import 'dart:io';

import 'package:dio/dio.dart';
import 'package:git_app/app/errors/exceptions.dart';
import 'package:git_app/app/models/api_error.dart';

class ErrorHandler {
  static Future handleApi(Future Function() request) async {
    try {
      final response = await request();
      return response.data;
    } on DioError catch (dioError) {
      switch (dioError.type) {
        case DioErrorType.sendTimeout:
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
          throw const NoConnectionException();
        case DioErrorType.response:
          throw _throwExceptionByResponse(dioError.error);
        case DioErrorType.other:
          throw _throwExceptionByError(dioError);
        default:
          rethrow;
      }
    }
  }

  static _throwExceptionByError(DioError dioError) {
    final error = dioError.error;
    switch (error.runtimeType) {
      case SocketException:
        throw const NoConnectionException();
      case TypeError:
        throw const FormatException(); //model //stacktrace //message
      default:
        throw dioError.error;
    }
  }

  static _throwExceptionByResponse(DioError dioError) {
    final response = dioError.response;
    final request = dioError.requestOptions;
    final path = "${request.baseUrl}${request.path}";
    final error = ApiResponseError.fromJson(response?.data);

    switch (response?.statusCode) {
      case 401:
        throw NoAuthorizedException;
      case 404:
        throw NotFoundException(
          path: path,
          message: error.message,
        );
      default:
        throw ServerResponseException(
          statusCode: response?.statusCode ?? -1,
          message: error.message,
        );
    }
  }

  static handleCache() {}
}
