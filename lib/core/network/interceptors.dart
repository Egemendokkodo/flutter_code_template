import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final String? token;

  ApiInterceptor({this.token});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers.addAll({
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    });

    // Debug log
    print('➡️ ${options.method} ${options.path}');
    print('Headers: ${options.headers}');
    print('Body: ${options.data}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    print('✅ ${response.statusCode} ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    print('❌ ${err.response?.statusCode} ${err.message}');
    super.onError(err, handler);
  }
}
