import 'dart:convert';

import 'package:http/http.dart' as http;

import 'app_constant.dart';

class ApiResponse {
  final bool success;
  final int statusCode;
  final String? error;
  final dynamic data;

  ApiResponse({
    required this.success,
    required this.statusCode,
    this.error,
    this.data,
  });
}

ApiResponse handleApiResponse(http.Response response) {
  if (response.statusCode == 200) {
    // Successful response
    final jsonData = json.decode(response.body);

    return ApiResponse(
      success: true,
      statusCode: response.statusCode,
      data: jsonData,
    );
  } else {
    // Error response
    final jsonData = json.decode(response.body);
    final errorMessage = jsonData['error'] as String?;

    return ApiResponse(
      success: false,
      statusCode: response.statusCode,
      error:
          errorMessage ?? UNKNOWN_ERROR, // Provide a default message
      data: jsonData,
    );
  }
}
