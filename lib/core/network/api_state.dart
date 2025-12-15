enum UiStatus { idle, loading, success, error }

class ApiState<T> {
  final UiStatus status;
  final T? data;
  final String? errorMessage;

  const ApiState._({
    required this.status,
    this.data,
    this.errorMessage,
  });

  const ApiState.idle() : this._(status: UiStatus.idle);
  const ApiState.loading() : this._(status: UiStatus.loading);
  const ApiState.success(T data)
      : this._(status: UiStatus.success, data: data);
  const ApiState.error(String message)
      : this._(status: UiStatus.error, errorMessage: message);
}
