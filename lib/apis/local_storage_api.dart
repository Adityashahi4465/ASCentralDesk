import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localStorageApiProvider = Provider((ref) {
  return LocalStorageApi();
});

abstract class ILocalStorageApi {
  Future<void> setToken(String token);
  Future<String?> getToken();
}

class LocalStorageApi implements ILocalStorageApi {
  @override
  Future<void> setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('x-auth-token', token);
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('x-auth-token');
    return token;
  }
}
