import 'package:dio/dio.dart';
import 'package:flutter_code_template/core/logger/service/console_logger_service.dart';
import 'package:flutter_code_template/core/logger/service/logger_service.dart';
import 'package:provider/provider.dart';

import '../../core/constants/api_url.dart';
import '../../core/network/api_client.dart';
import '../../core/network/interceptors.dart';
import '../../data/repository/service/user_service.dart';
import '../../data/repository/impl/user_service_impl.dart';
import '../../feature/auth/viewmodel/login_viewmodel.dart';

/// =======================================================
///  LOW LEVEL
/// =======================================================

final dioProvider = Provider<Dio>(
  create: (_) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiUrl.BASE_URL,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(ApiInterceptor(token: null));
    return dio;
  },
);

final loggerProvider = Provider<LoggerService>(
  create: (_) => ConsoleLoggerService(),
);


final apiClientProvider = Provider<ApiClient>(
  create: (context) {
    final dio = context.read<Dio>();
    final logger = context.read<LoggerService>();
    return ApiClient(dio, logger);
  },
);


/// =======================================================
///  SERVICES
/// =======================================================

final userServiceProvider = Provider<UserService>(
  create: (context) {
    final apiClient = context.read<ApiClient>();
    return UserServiceImpl(apiClient);
  },
);


/// =======================================================
///  VIEW MODELS
/// =======================================================

final authViewModelProvider = ChangeNotifierProvider<LoginViewModel>(
  create: (context) {
    final userService = context.read<UserService>();
    return LoginViewModel(userService);
  },
);
