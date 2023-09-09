import 'package:as_central_desk/constants/app_constant.dart';
import 'package:as_central_desk/core/utils/extensions/validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final validationServiceProvider = Provider<ValidationService>((ref) {
  return ValidationService();
});

class ValidationService {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return EMAIL_AUTH_VALIDATION_EMPTY;
    } else if (value.isValidEmail()) {
      return EMAIL_AUTH_VALIDATION_INVALID;
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return NAME_AUTH_VALIDATION_EMPTY;
    } else if (value.isValidName()) {
      return NAME_AUTH_VALIDATION_INVALID;
    }
    return null;
  }

  String? validateRollNumber(String? value) {
    if (value == null || value.isEmpty) {
      return ROLL_NUMBER_AUTH_VALIDATION_EMPTY;
    } else if (value.isValidRollNo()) {
      return ROLL_NUMBER_AUTH_VALIDATION_INVALID;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return PASSWORD_AUTH_VALIDATION_EMPTY;
    }
    if (value.length < 6) {
      return PASSWORD_AUTH_VALIDATION_TOO_SHORT;
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return CONFIRM_PASSWORD_AUTH_VALIDATION_EMPTY;
    }
    if (value != password) {
      return CONFIRM_PASSWORD_AUTH_VALIDATION_NOT_MATCHED;
    }
    return null;
  }

  String? validateSelectCampus(String? value) {
    if (value == null || value.isEmpty) {
      return SELECT_CAMPUS_EMPTY;
    }
    return null;
  }

  String? validateSelectCourse(String? value) {
    if (value == null || value.isEmpty) {
      return SELECT_COURSE_EMPTY;
    }
    return null;
  }

  String? validateSelectSemester(String? value) {
    if (value == null || value.isEmpty) {
      return SELECT_SEMESTER_EMPTY;
    }
    return null;
  }
}
