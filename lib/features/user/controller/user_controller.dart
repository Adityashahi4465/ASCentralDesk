import 'package:as_central_desk/apis/user_api.dart';
import 'package:as_central_desk/features/complaint/controller/compliant_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/snackbar.dart';
import '../../../models/user.dart';

final userControllerProvider = StateNotifierProvider<UserController, bool>(
  (ref) => UserController(
    userAPI: ref.watch(userApiProvider),
    ref: ref,
  ),
);

final getUserDataByIdProvider = FutureProvider.family((ref, String id) {
  final userController = ref.watch(userControllerProvider.notifier);
  return userController.getUserDataById(id: id);
});

class UserController extends StateNotifier<bool> {
  final UserAPI _userAPI;
  final Ref _ref;
  UserController({required UserAPI userAPI, required Ref ref})
      : _userAPI = userAPI,
        _ref = ref,
        super(false); // loading while asynchronous tasks initially false

  Future<User?> getUserDataById({required String id}) async {
    final res = await _userAPI.getUserDataById(id: id);
    User? user;
    res.fold((l) {
      user = null;
    }, (r) {
      user = r;
    });

    return user;
  }

  Future<void> updateUser({
    required User user,
    required BuildContext context,
  }) async {
    final res = await _userAPI.updateUser(user: user);
    res.fold(
      (l) => showCustomSnackbar(context, l.message),
      (r) {
      _ref.invalidate(getUserDataByIdProvider(user.uid));
      _ref.invalidate(getBookmarkedComplaintsProvider); // Refresh bookmarkedComplaintsProvider
    },
    );
  }
}
