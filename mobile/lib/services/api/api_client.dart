import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../storage/secure_storage.dart';
import 'api_endpoints.dart';
import 'api_exceptions.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onResponse: _onResponse,
      onError: _onError,
    ));

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ));
    }
  }

  Dio get dio => _dio;

  Future<void> _onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SecureStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    // We can extract custom data format here if we want,
    // but usually, we just return the response.
    return handler.next(response);
  }

  Future<void> _onError(DioException err, ErrorInterceptorHandler handler) async {
    String message = 'Something went wrong';
    int? statusCode = err.response?.statusCode;
    dynamic data;

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      message = 'Connection timed out. Please check your internet.';
    } else if (err.type == DioExceptionType.connectionError) {
      message = 'No internet connection.';
    } else if (err.response != null) {
      data = err.response?.data;
      if (data != null && data is Map<String, dynamic>) {
        // Our backend sends errors in this format:
        // { success: false, message: "...", errors: [...] }
        message = data['message'] ?? message;
        if (data['errors'] != null && data['errors'] is List && data['errors'].isNotEmpty) {
          message = data['errors'][0]; // Get first specific validation error
        }
      }
      
      // Handle 401 Unauthorized (Token expired)
      if (statusCode == 401) {
        // TODO: Implement token refresh logic here
        // For now, just log out the user
        await SecureStorage.clearTokens();
      }
    }

    return handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: ApiException(message, statusCode, data),
      ),
    );
  }
}
