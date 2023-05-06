import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

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
      headers: {'Accept': Headers.jsonContentType},
    );

    _dio = Dio(dioOptions);

    _dio.interceptors.clear();

    _dio.interceptors.add(LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: false,
      logPrint: _printLog,
    ));
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
      final response = await _dio.download(
        path,
        filePath,
        data: data,
        options: Options(
          method: 'POST',
          responseType: ResponseType.bytes,
        ),
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }
}
