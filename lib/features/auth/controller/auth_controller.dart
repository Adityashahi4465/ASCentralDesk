import 'package:as_central_desk/apis/auth_api.dart';
import 'package:as_central_desk/apis/local_storage_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../core/utils/snackbar.dart';
import '../../../models/user.dart';

final userProvider = StateProvider<User?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authAPI: ref.watch(authApiProvider),
    ref: ref,
  ),
);

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final Ref _ref;
  AuthController({required AuthAPI authAPI, required Ref ref})
      : _authAPI = authAPI,
        _ref = ref,
        super(false); // loading while asynchronous tasks initially false

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String rollNo,
    required String campus,
    required String course,
    required String semester,
    required BuildContext context,
  }) async {
    User user = User(
      uid: '',
      token: '',
      name: name,
      email: email,
      campus: campus,
      course: course,
      rollNo: rollNo,
      section: '',
      role: 'student',
      semester: semester,
      photoUrl: '',
      linkedInProfileUrl: '',
      isAccountActive: true,
      bookmarkedComplaints: [],
      bookmarkedEvents: [],
      bookmarkedNotifications: [],
    );
    state = true; // loading starts
    final res = await _authAPI.registerWithEmailAndPassword(
      user: user,
      password: password,
      email: email,
    );
    state = false;
    res.fold((l) {
      showCustomSnackbar(context, l.message);
      print(l.message);
    }, (user) {
      _ref.read(userProvider.notifier).update((state) => user);
      Routemaster.of(context).replace('/');
    });
  }

  Future<User?> getCurrentUserData() async {
    final res = await _ref.read(authApiProvider).getCurrentUserData();
    User? user;
    res.fold((l) {
      user = null;
    }, (r) {
      user = r;
    });

    return user;
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _ref.read(authApiProvider).logIn(
          email: email,
          password: password,
        );
    state = false;
    res.fold(
      (l) => showCustomSnackbar(context, l.message),
      (user) => _ref.read(userProvider.notifier).update(
            (state) => user,
          ),
    );
  }

  void logOut() {
    _ref.read(authApiProvider).logOut();
    _ref.read(userProvider.notifier).update((state) => null);
  }
}
