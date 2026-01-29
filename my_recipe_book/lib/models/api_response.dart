/// Generic wrapper for API responses.
///
/// This pattern provides consistent error handling across all API calls:
/// - [success]: Whether the request succeeded
/// - [data]: The response payload (null on error)
/// - [error]: Error information (null on success)
/// - [message]: Optional message from the server
///
/// Usage:
/// ```dart
/// final response = ApiResponse.fromJson(json, (data) => User.fromJson(data));
/// if (response.success) {
///   print(response.data);
/// } else {
///   print(response.error?.message);
/// }
/// ```
class ApiResponse<T> {
  final bool success;
  final T? data;
  final ApiError? error;
  final String? message;

  const ApiResponse({
    required this.success,
    this.data,
    this.error,
    this.message,
  });

  /// Creates an ApiResponse from JSON.
  ///
  /// The [fromJsonT] function converts the 'data' field to type T.
  /// Pass null for endpoints that don't return data.
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json)? fromJsonT,
  ) {
    return ApiResponse(
      success: json['success'] as bool? ?? false,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
      error: json['error'] != null
          ? ApiError.fromJson(json['error'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
    );
  }

  /// Creates a success response.
  factory ApiResponse.successWith(T data, {String? message}) {
    return ApiResponse(
      success: true,
      data: data,
      message: message,
    );
  }

  /// Creates an error response.
  factory ApiResponse.errorWith(ApiError error) {
    return ApiResponse(
      success: false,
      error: error,
    );
  }

  @override
  String toString() {
    return 'ApiResponse(success: $success, data: $data, error: $error, message: $message)';
  }
}

/// Represents an API error with code and message.
///
/// Error codes follow a consistent pattern:
/// - VALIDATION_ERROR: Invalid request data
/// - NOT_FOUND: Resource doesn't exist
/// - UNAUTHORIZED: Authentication required
/// - FORBIDDEN: Insufficient permissions
/// - SERVER_ERROR: Internal server error
class ApiError {
  final String code;
  final String message;
  final Map<String, dynamic>? details;

  const ApiError({
    required this.code,
    required this.message,
    this.details,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      code: json['code'] as String? ?? 'UNKNOWN_ERROR',
      message: json['message'] as String? ?? 'An unknown error occurred',
      details: json['details'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      if (details != null) 'details': details,
    };
  }

  @override
  String toString() => 'ApiError(code: $code, message: $message)';
}

/// Custom exception for API errors.
///
/// Thrown by the repository layer when API calls fail.
/// Contains the original [ApiError] for detailed error information.
class ApiException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;
  final ApiError? apiError;

  const ApiException({
    required this.message,
    this.code,
    this.statusCode,
    this.apiError,
  });

  /// Creates an ApiException from an ApiError.
  factory ApiException.fromApiError(ApiError error, {int? statusCode}) {
    return ApiException(
      message: error.message,
      code: error.code,
      statusCode: statusCode,
      apiError: error,
    );
  }

  /// Creates a network error exception.
  factory ApiException.network(String message) {
    return ApiException(
      message: message,
      code: 'NETWORK_ERROR',
    );
  }

  /// Creates a timeout exception.
  factory ApiException.timeout() {
    return const ApiException(
      message: 'Request timed out. Please try again.',
      code: 'TIMEOUT',
    );
  }

  @override
  String toString() => 'ApiException: $message (code: $code)';
}
