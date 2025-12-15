class CommonApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final int? statusCode;

  const CommonApiResponse({
    required this.success,
    this.message,
    this.data,
    this.statusCode,
  });

  factory CommonApiResponse.success(
    T data, {
    String? message,
    int? statusCode,
  }) {
    return CommonApiResponse(
      success: true,
      data: data,
      message: message,
      statusCode: statusCode,
    );
  }

  factory CommonApiResponse.failure({
    String? message,
    int? statusCode,
  }) {
    return CommonApiResponse(
      success: false,
      message: message,
      statusCode: statusCode,
    );
  }
}
