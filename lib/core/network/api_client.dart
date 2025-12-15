import 'package:dio/dio.dart';
import 'package:flutter_code_template/core/exceptions/api_exception.dart';
import 'package:flutter_code_template/core/logger/service/logger_service.dart';
import 'package:flutter_code_template/core/network/interceptors.dart';
import 'package:flutter_code_template/data/models/common/common_api_response.dart';

// ONLY ONE INSTANCE, MEMORY FRIENDLY
class ApiClient {
  final Dio _dio;
  final LoggerService _logger;
  ApiClient(this._dio,this._logger);

  Future<CommonApiResponse<T>> get<T>(
    String endpoint, {
    required T Function(dynamic json) fromJson,
  }) async {
    _logger.log('GET $endpoint', level: LogLevel.info);

    try {
      final response = await _dio.get(endpoint);
      _logger.log(
        'RESPONSE [$endpoint] ${response.statusCode}',
        level: LogLevel.debug,
      );
      return _parseResponse<T>(response, fromJson);
    } catch (e, s) {
      _logger.log(
        'GET ERROR $endpoint',
        level: LogLevel.error,
        error: e,
        stackTrace: s,
      );
      rethrow;
    }
  }


Future<CommonApiResponse<T>> post<T>(
  String path, {
  dynamic data,
  Map<String, dynamic>? queryParameters,
  required T Function(dynamic json) fromJson,
  Options? options,
}) async {
  try {
    final response = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    return _parseResponse<T>(response, fromJson);
  } on DioException catch (e) {
    final exception = _mapDioException(e);
    return _exceptionToResponse<T>(exception);
  }
}



  ApiException _mapDioException(DioException e) {
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

  CommonApiResponse<T> _exceptionToResponse<T>(ApiException e) {
    return CommonApiResponse.failure(message: e.message, statusCode: e.statusCode);
  }

CommonApiResponse<T> _parseResponse<T>(
  Response response,
  T Function(dynamic json) fromJson,
) {
  final data = response.data;

  // 🔹 WRAPPED RESPONSE
  if (data is Map<String, dynamic> &&
      data.containsKey('success') &&
      data.containsKey('data')) {
    return CommonApiResponse<T>(
      success: data['success'] as bool,
      message: data['message'] as String?,
      statusCode: data['statusCode'] as int? ?? response.statusCode,
      data: data['data'] != null ? fromJson(data['data']) : null,
    );
  }

  // 🔹 EMPTY BODY (ex: 200 but {})
  if (data == null ||
      (data is Map<String, dynamic> && data.isEmpty)) {
    return CommonApiResponse.failure(
      message: 'No data found',
      statusCode: response.statusCode,
    );
  }

  // 🔹 RAW RESPONSE
  return CommonApiResponse.success(
    fromJson(data),
    statusCode: response.statusCode,
    message: response.statusMessage ?? 'Success',
  );
}

}
