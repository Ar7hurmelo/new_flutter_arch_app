import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthApiService {
  final url =
      'https://api.staging.sti.ufpb.br/submit/publico/processos-submissoes';
  late final Dio _dio;

  AuthApiService() {
    configureDio(baseUrl: url);
  }

  // Configuration function
  void configureDio({
    required String baseUrl,
    Map<String, dynamic>? defaultHeaders,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    void Function(RequestOptions options, RequestInterceptorHandler handler)?
    onRequest,
    void Function(Response response, ResponseInterceptorHandler handler)?
    onResponse,
    void Function(DioException e, ErrorInterceptorHandler handler)? onError,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout ?? const Duration(seconds: 30),
        receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
        headers:
            defaultHeaders ??
            {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            onRequest ??
            (options, handler) {
              debugPrint('Request: ${options.method} ${options.path}');
              debugPrint('Headers: ${options.headers}');
              debugPrint('Query Params: ${options.queryParameters}');
              handler.next(options);
            },
        onResponse:
            onResponse ??
            (response, handler) {
              //debugPrint('Response: ${response.statusCode} ${response.data}');
              handler.next(response);
            },
        onError:
            onError ??
            (DioException e, handler) {
              debugPrint('Error: ${e.message}');
              handler.next(e);
            },
      ),
    );
  }

  Future<Response> getRequest(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postRequest(
    String endpoint, {
    Options? options,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await _dio.post(
        endpoint,
        data: data,
        options:
            options ??
            Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ),
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
