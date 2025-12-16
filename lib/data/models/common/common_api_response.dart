class CommonApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final int statusCode;

  const CommonApiResponse({
    required this.success,
    this.data,
    this.message,
    required this.statusCode,
  });

  factory CommonApiResponse.success(
    T data, {
    String? message,
    required int statusCode,
  }) {
    return CommonApiResponse(
      success: true,
      data: data,
      message: message,
      statusCode: statusCode,
    );
  }

  factory CommonApiResponse.failure({
    required String message,
    required int statusCode,
  }) {
    return CommonApiResponse(
      success: false,
      message: message,
      statusCode: statusCode,
    );
  }
}
