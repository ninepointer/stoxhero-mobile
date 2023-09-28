import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../data.dart';

class APIException implements Exception {
  final String? message;

  APIException({required this.message});
}

class ExceptionHandler {
  ExceptionHandler._privateConstructor();

  static APIException handleError(Exception error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.sendTimeout:
          return APIException(message: ErrorMessages.noInternet);
        case DioExceptionType.connectionTimeout:
          return APIException(message: ErrorMessages.connectionTimeout);
        case DioExceptionType.badResponse:
          return APIException(
            message: ErrorResponse.fromJson(error.response?.data).message ??
                ErrorMessages.somethingWentWrong,
          );
        case DioExceptionType.unknown:
          return APIException(
            message: ErrorResponse.fromJson(error.response?.data).message ??
                ErrorMessages.somethingWentWrong,
          );
        default:
          return APIException(message: ErrorMessages.networkGeneral);
      }
    } else {
      return APIException(message: ErrorMessages.networkGeneral);
    }
  }
}

class HandleError {
  HandleError._privateConstructor();

  static handleError(APIException? error) {
    Get.rawSnackbar(message: error?.message ?? ErrorMessages.networkGeneral);
  }
}
