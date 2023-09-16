import 'dart:convert';

import 'package:as_central_desk/apis/local_storage_api.dart';
import 'package:as_central_desk/constants/app_constant.dart';
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
  FutureEither<User> getCurrentUserData();
  FutureEither<User> logIn({
    required String password,
    required String email,
  });
  void logOut();
  void sandVerificationEmail({required String email});
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
      final Map<String, dynamic> userData =
          jsonDecode(user.toJson()) as Map<String, dynamic>;
      userData['password'] = password;

      final Map<String, dynamic> requestBody = userData;

      // final Map<String, dynamic> userMap =
      //     user.toJson() as Map<String, dynamic>; // Convert user data to a map
      // userMap['password'] = password; // Add the 'password' field

      final Response response = await _client.post(
        Uri.parse('$hostUrl/api/v1/auth/register'),
        body: json.encode(requestBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      final apiResponse = handleApiResponse(response);
      if (apiResponse.success) {
        final userJson = jsonDecode(response.body);
        final newUser = user.copyWith(
          uid: userJson['user']['_id'],
          token: userJson['token'],
        );
        _localStorageApi.setToken(userJson['token']);
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
      print(e);
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  FutureEither<User> getCurrentUserData() async {
    try {
      String? token = await _localStorageApi.getToken();
      if (token != null) {
        var res =
            await _client.get(Uri.parse('$hostUrl/api/v1/auth/me'), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        });

        final apiResponse = handleApiResponse(res);
        if (apiResponse.success) {
          final userJson = jsonDecode(res.body)['user'];
          // print(userJson);
          final newUser = User.fromMap(userJson)
              .copyWith(token: token); // Use fromMap method
          // print('------------------------- $newUser');
          _localStorageApi.setToken(newUser.token);

          return right(newUser);
        } else {
          return left(
            Failure(
              apiResponse.error!,
            ),
          );
        }
      } else {
        return left(
          const Failure(
            TOKEN_NOT_FOUND_ERROR,
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

  @override
  FutureEither<User> logIn({
    required String email,
    required String password,
  }) async {
    try {
      var response = await _client.post(
        Uri.parse('$hostUrl/api/v1/auth/login'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final apiResponse = handleApiResponse(response);

      if (apiResponse.success) {
        final userJson = jsonDecode(response.body);
        // print(userJson);
        final userData = User.fromMap(userJson['user']).copyWith(
          token: userJson['token'],
        ); // Use fromMap method

        _localStorageApi.setToken(userData.token);
        return right(userData);
      } else {
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

  @override
  void logOut() {
    _localStorageApi.removeToken();
  }

  @override
  FutureEitherVoid sandVerificationEmail({
    required String email,
  }) async {
    try {
      final res = await _client.post(
        Uri.parse('$hostUrl/api/v1/auth/send-verification-email'),
        body: jsonEncode({'email': email}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final apiResponse = handleApiResponse(res);
      if (apiResponse.success) {
        return right(null);
      } else {
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
