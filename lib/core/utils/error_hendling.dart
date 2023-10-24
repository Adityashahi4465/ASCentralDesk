import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/app_constant.dart';

class ApiResponse {
  final bool success;
  final int statusCode;
  final String? error;

  ApiResponse({
    required this.success,
    required this.statusCode,
    this.error,
  });
}

ApiResponse handleApiResponse(http.Response response) {
  if (response.statusCode == 200) {
    // Successful response
    return ApiResponse(
      success: true,
      statusCode: response.statusCode,
    );
  } else {
    // Error response
    final String responseBody = response.body;
    final jsonData = responseBody.isNotEmpty ? json.decode(responseBody) : null;
    final errorMessage = jsonData != null ? jsonData['error'] as String? : null;

    return ApiResponse(
      success: false,
      statusCode: response.statusCode,
      error: errorMessage ?? UNKNOWN_ERROR, // Provide a default message
    );
  }
}
