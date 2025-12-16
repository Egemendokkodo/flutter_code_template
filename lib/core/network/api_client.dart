import 'package:dio/dio.dart';
import 'package:flutter_code_template/core/exceptions/api_exception.dart';
import 'package:flutter_code_template/core/logger/service/logger_service.dart';
import 'package:flutter_code_template/core/network/interceptors.dart';
import 'package:flutter_code_template/data/models/common/common_api_response.dart';

// ONLY ONE INSTANCE, MEMORY FRIENDLY
class ApiClient {
  final Dio _dio;
  final LoggerService _logger;

  ApiClient(this._dio, this._logger);

  Future<CommonApiResponse<T>> get<T>(String path, {required T Function(dynamic json) fromJson}) async {
    try {
      final response = await _dio.get(path);
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e, s) {
      _logger.log('GET ERROR $path', level: LogLevel.error, error: e, stackTrace: s);
      return _handleDioError<T>(e);
    }
  }

  Future<CommonApiResponse<T>> post<T>(String path, {dynamic data, required T Function(dynamic json) fromJson}) async {
    try {
      final response = await _dio.post(path, data: data);
      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e, s) {
      _logger.log('POST ERROR $path', level: LogLevel.error, error: e, stackTrace: s);
      return _handleDioError<T>(e);
    }
  }

  CommonApiResponse<T> _handleResponse<T>(Response response, T Function(dynamic json) fromJson) {
    final body = response.data;
    final statusCode = response.statusCode ?? 500;

    if (body is Map<String, dynamic> && body.containsKey('success')) {
      final success = body['success'] as bool;
      final message = body['message'] as String?;

      // ❌ ERROR RESPONSE
      if (!success) {
        return CommonApiResponse.failure(message: message ?? 'An error occurred', statusCode: statusCode);
      }

      // ✅ SUCCESS RESPONSE → BACKEND "response"
      final responseData = body['response'];

      return CommonApiResponse.success((responseData != null ? fromJson(responseData) : null) as T, message: message, statusCode: statusCode);
    }

    // Fallback (raw response)
    return CommonApiResponse.success(fromJson(body), statusCode: statusCode);
  }

  CommonApiResponse<T> _handleDioError<T>(DioException e) {
    final response = e.response;
    final statusCode = response?.statusCode ?? 500;

    if (response?.data is Map<String, dynamic>) {
      final data = response!.data;
      return CommonApiResponse.failure(message: data['message'] ?? 'Unexpected error', statusCode: statusCode);
    }

    return CommonApiResponse.failure(message: _mapDioErrorMessage(e).message, statusCode: statusCode);
  }

  ApiException _mapDioErrorMessage(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
      return const NetworkException('Connection Timeout');
    }

    if (e.response != null) {
      final statusCode = e.response?.statusCode;
      final message = e.response?.data['message'] ?? 'An error ocurred. Please try again.';

      switch (statusCode) {
        case 401:
          return UnauthorizedException(message);
        case 404:
          return NotFoundException(message);

        default:
          return UnknownException(message);
      }
    }

    return const UnknownException('Unexpected error');
  }
}
