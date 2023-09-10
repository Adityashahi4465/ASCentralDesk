import 'dart:convert';

import 'package:as_central_desk/apis/local_storage_api.dart';
import 'package:as_central_desk/core/api_config.dart';
import 'package:as_central_desk/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import '../constants/error_hendling.dart';
import '../core/core.dart';
import '../models/user.dart';

final authApiProvider = Provider((ref) {
  return AuthAPI(
    client: ref.watch(clientProvider),
    localStorageApi: ref.watch(localStorageApiProvider),
  );
});

abstract class IAuthAPI {
  FutureEither<User> registerWithEmailAndPassword({
    required User user,
    required String password,
    required String email,
  });
}

class AuthAPI implements IAuthAPI {
  final Client _client;
  final LocalStorageApi _localStorageApi;

  AuthAPI({
    required Client client,
    required LocalStorageApi localStorageApi,
  })  : _client = client,
        _localStorageApi = localStorageApi;
  @override
  FutureEither<User> registerWithEmailAndPassword({
    required User user,
    required String password,
    required String email,
  }) async {
    try {
      final Response response = await _client.post(
        Uri.parse('$hostUrl/api/v1/auth/register'),
        body: user.toJson(),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      final apiResponse = handleApiResponse(response);

      if (apiResponse.success) {
        print('Success! Status Code: ${apiResponse.statusCode}');
        final userJson = apiResponse.data;
        final newUser = user.copyWith(
          uid: userJson['user']['_id'],
          token: userJson['token'],
        );
        return right(newUser);
      } else {
        print('Failure! Status Code: ${apiResponse.statusCode}');
        return left(
          Failure(
            apiResponse.error!,
          ),
        );
      }
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
