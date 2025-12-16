import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final String? token;

  ApiInterceptor({this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({'Accept': 'application/json', if (token != null) 'Authorization': 'Bearer $token'});

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
