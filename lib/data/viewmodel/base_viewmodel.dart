import 'package:flutter/material.dart';
import 'package:flutter_code_template/core/network/api_state.dart';
import 'package:flutter_code_template/data/models/common/common_api_response.dart';

abstract class BaseViewModel extends ChangeNotifier {
  Future<ApiState<T>> executeApiRequest<T>(
    Future<CommonApiResponse<T>> Function() apiCall,
  ) async {
    try {
      final response = await apiCall();
      if (response.success && response.data != null) {
        return ApiState.success(response.data as T);
      } else {
        return ApiState.error(response.message ?? 'An error occurred');
      }
    } catch (_) {
      return const ApiState.error('Unexpected error');
    }
  }

  /// state management and notifyListeners automatic
  Future<void> runApi<T>(
    ValueSetter<ApiState<T>> stateSetter,
    Future<CommonApiResponse<T>> Function() apiCall,
  ) async {
    stateSetter(const ApiState.loading());
    notifyListeners();

    final result = await executeApiRequest(apiCall);
    stateSetter(result);
    notifyListeners();
  }
}
