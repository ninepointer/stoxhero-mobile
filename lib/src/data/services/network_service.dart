import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:stoxhero/main.dart';

import '../../core/core.dart';
import '../data.dart';

class NetworkService {
  late Dio _dio;
  late Dio _formDio;

  NetworkService() {
    prepareRequest();
    prepareFormRequest();
  }
  static final NetworkService shared = NetworkService();

  void prepareRequest() {
    BaseOptions dioOptions = BaseOptions(
      baseUrl: AppUrls.baseURL,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {
        'Accept': Headers.jsonContentType,
      },
    );

    _dio = Dio(dioOptions);

    _dio.interceptors.clear();

    _dio.interceptors.add(
      PrettyDioLogger(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        compact: false,
      ),
    );
  }

  void prepareFormRequest() {
    BaseOptions dioOptions = BaseOptions(
      baseUrl: AppUrls.baseURL,
      contentType: "multipart/form-data",
      responseType: ResponseType.json,
    );

    _formDio = Dio(dioOptions);

    _formDio.interceptors.clear();

    _formDio.interceptors.add(LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: false,
      logPrint: _printLog,
    ));
  }

  _printLog(Object object) => log(object.toString());

  Future<Uint8List> getImageBytes(String imageUrl) async {
    var response = await Dio().get<Uint8List>(
      imageUrl,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
    return response.data!;
  }

  Future<dynamic> getAuth({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    try {
      final authDio = Dio();

      authDio.interceptors.clear();

      authDio.interceptors.add(
        PrettyDioLogger(
          error: true,
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: false,
          compact: false,
        ),
      );

      final headers = {
        'Authorization':
            'Bearer ${useTestToken ? AppConstants.token : AppStorage.getToken()}',
      };

      final response = await authDio.get(
        path,
        data: data,
        queryParameters: query,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.json,
        ),
      );

      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> postAuth({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    try {
      final authDio = Dio();

      authDio.interceptors.clear();

      authDio.interceptors.add(
        PrettyDioLogger(
          error: true,
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: false,
          compact: false,
        ),
      );

      final headers = {
        'Authorization':
            'Bearer ${useTestToken ? AppConstants.token : AppStorage.getToken()}',
      };

      final response = await authDio.post(
        path,
        data: data,
        queryParameters: query,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.json,
        ),
      );

      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> patchAuth({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    try {
      final authDio = Dio();

      authDio.interceptors.clear();

      authDio.interceptors.add(
        PrettyDioLogger(
          error: true,
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: false,
          compact: false,
        ),
      );

      final headers = {
        'Authorization':
            'Bearer ${useTestToken ? AppConstants.token : AppStorage.getToken()}',
      };

      final response = await authDio.patch(
        path,
        data: data,
        queryParameters: query,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.json,
        ),
      );

      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> putAuth({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    try {
      final authDio = Dio();

      authDio.interceptors.clear();

      authDio.interceptors.add(
        PrettyDioLogger(
          error: true,
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: false,
          compact: false,
        ),
      );

      final headers = {
        'Authorization':
            'Bearer ${useTestToken ? AppConstants.token : AppStorage.getToken()}',
      };

      final response = await authDio.put(
        path,
        data: data,
        queryParameters: query,
        options: Options(
          headers: headers,
          contentType: "application/json",
          responseType: ResponseType.json,
        ),
      );

      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: query,
        data: jsonEncode(data),
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final Response response = await _dio.post(
        path,
        queryParameters: query,
        data: jsonEncode(data),
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    try {
      final response = await _dio.put(
        path,
        queryParameters: query,
        data: jsonEncode(data),
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> patch({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        queryParameters: query,
        data: jsonEncode(data),
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> delete({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: query,
        data: jsonEncode(data),
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> postAuthFormData({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    Dio _authFormDio = Dio();

    BaseOptions dioOptions = BaseOptions(
      baseUrl: AppUrls.baseURL,
      contentType: "multipart/form-data",
      responseType: ResponseType.json,
    );

    _authFormDio = Dio(dioOptions);

    _authFormDio.interceptors.clear();

    _authFormDio.interceptors.add(PrettyDioLogger(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      compact: false,
    ));
    try {
      final response = await _authFormDio.post(
        path,
        queryParameters: query,
        data: FormData.fromMap(data!),
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> patchAuthFormData({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    Dio _authFormDio = Dio();

    final headers = {
      'Cookie': useTestToken
          ? 'jwtoken=${AppConstants.token}'
          : 'jwtoken=${AppStorage.getToken()}',
    };

    BaseOptions dioOptions = BaseOptions(
      baseUrl: AppUrls.baseURL,
      contentType: "multipart/form-data",
      responseType: ResponseType.json,
    );

    _authFormDio = Dio(dioOptions);

    _authFormDio.interceptors.clear();

    _authFormDio.interceptors.add(
      PrettyDioLogger(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        compact: false,
      ),
    );

    try {
      final response = await _authFormDio.patch(
        path,
        queryParameters: query,
        data: FormData.fromMap(data!),
        options: Options(
          headers: headers,
        ),
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> postFormData({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _formDio.post(
        path,
        queryParameters: query,
        data: FormData.fromMap(data!),
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> putFormData({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _formDio.put(
        path,
        queryParameters: query,
        data: FormData.fromMap(data!),
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

  Future<dynamic> downloadFile({
    required String path,
    required String filePath,
    Map<String, dynamic>? data,
  }) async {
    try {
      final headers = {
        'Cookie': useTestToken
            ? 'jwtoken=${AppConstants.token}'
            : 'jwtoken=${AppStorage.getToken()}',
      };
      final response = await _dio.download(
        path,
        filePath,
        data: data,
        options: Options(
          method: 'GET',
          headers: headers,
          responseType: ResponseType.bytes,
        ),
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }
}
