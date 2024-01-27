import 'package:flutter_riverpod/flutter_riverpod.dart';

final validationServiceProvider = Provider<ValidationService>((ref) {
  return ValidationService();
});


class ValidationService {
   String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    // You can add more specific email validation if needed
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateRollNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your roll number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    // You can add more specific password validation if needed
    return null;
  }

  String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
