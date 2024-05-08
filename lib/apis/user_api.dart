import 'dart:convert';

import 'package:as_central_desk/apis/local_storage_api.dart';
import 'package:as_central_desk/constants/app_constant.dart';
import 'package:as_central_desk/core/api_config.dart';
import 'package:as_central_desk/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import '../core/utils/error_hendling.dart';
import '../core/core.dart';
import '../models/user.dart';

final userApiProvider = Provider((ref) {
  return UserAPI(
    client: ref.watch(clientProvider),
    localStorageApi: ref.watch(localStorageApiProvider),
  );
});

abstract class IUserAPI {
  FutureEither<User> getUserDataById({
    required String id,
  });

  FutureEither updateUser({
    required User user,
  });
}

class UserAPI implements IUserAPI {
  final Client _client;
  final LocalStorageApi _localStorageApi;

  UserAPI({
    required Client client,
    required LocalStorageApi localStorageApi,
  })  : _client = client,
        _localStorageApi = localStorageApi;

  @override
  FutureEither<User> getUserDataById({required String id}) async {
    try {
      print(id);
      String? token = await _localStorageApi.getToken();
      if (token != null) {
        var res = await _client
            .get(Uri.parse('$hostUrl/api/v1/auth/user/$id'), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        });

        print(res.body);
        final apiResponse = handleApiResponse(res);
        if (apiResponse.success) {
          final userJson = jsonDecode(res.body)['data'];
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
  FutureEither updateUser({
    required User user,
  }) async {
    try {
      String? token = await _localStorageApi.getToken();

      final encodedJson = user.toJson();
      print('Encoded JSON: $encodedJson');
      final response = await _client.put(
        Uri.parse('$hostUrl/api/v1/auth/user/${user.uid}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!,
        },
        body: encodedJson,
      );

      final apiResponse = handleApiResponse(response);
      if (apiResponse.success) {
        print(apiResponse.statusCode);
        return right(null);
      } else {
        print('Error while updating user:: ${apiResponse.error}!');
        return left(
          Failure(
            apiResponse.error!,
          ),
        );
      }
    } catch (e) {
      print("Caught exception while updating user: " + e.toString());
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
