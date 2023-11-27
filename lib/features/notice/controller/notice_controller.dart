import 'package:as_central_desk/apis/cloudinary_api.dart';
import 'package:as_central_desk/apis/notice_api.dart';
import 'package:as_central_desk/constants/ui_constants.dart';
import 'package:as_central_desk/core/enums/enums.dart';
import 'package:as_central_desk/features/auth/controller/auth_controller.dart';
import 'package:as_central_desk/models/notice.dart';
import 'package:as_central_desk/routes/route_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/snackbar.dart';

final noticeControllerProvider = StateNotifierProvider<NoticeController, bool>(
  (ref) => NoticeController(
    noticeAPI: ref.watch(noticeApiProvider),
    ref: ref,
  ),
);

final getNoticeByIdProvider = FutureProvider.family((ref, String noticeId) {
  final noticeController = ref.watch(noticeControllerProvider.notifier);
  return noticeController.getNoticeById(noticeId: noticeId);
});

final getAllNoticesProvider = FutureProvider<List<Notice>>((ref) async {
  final controller = NoticeController(
    noticeAPI: ref.read(noticeApiProvider),
    ref: ref,
  );
  return controller.getAllNotices();
});

// final getBookmarkednoticesProvider =
//     FutureProvider<List<Notice>>((ref) async {
//   // Assuming you have a function named getAllnotices in your controller
//   final controller = noticeController(
//     noticeAPI: ref.read(noticeApiProvider),
//     ref: ref,
//   );
//   return controller.getBookmarkedNotices();
// });

class NoticeController extends StateNotifier<bool> {
  final NoticeApi _noticeAPI;
  final Ref _ref;
  NoticeController({required NoticeApi noticeAPI, required Ref ref})
      : _noticeAPI = noticeAPI,
        _ref = ref,
        super(false); // loading while asynchronous tasks initially false

  void saveNoticeToDatabase({
    required String title,
    required String description,
    required String category,
    required List<String> campuses,
    required String visibility,
    required String priority,
    required DateTime startDate,
    required DateTime endDate,
    required String relatedNoticesLink,
    required String contact,
    required BuildContext context,
  }) async {
    state = true;

    final notice = Notice(
      id: '',
      title: title,
      category: category,
      postedAt: DateTime.now(),
      expirationDate: endDate,
      startDate: startDate,
      author: _ref.read(userProvider)!.uid,
      content: description,
      targetCampuses: campuses,
      priorityLevel: priority,
      status: 'Valid',
      visibility: visibility,
      relatedNotices: [relatedNoticesLink],
      tags: [],
      approvalStatus: true,
      authorContact: contact,
      lastModified: DateTime.now(),
    );
    final res = await _noticeAPI.saveNoticeToDatabase(
      notice: notice,
    );
    state = false;
    res.fold(
      (l) {
        print(l.message);
        showCustomSnackbar(context, l.message);
      },
      (user) {
        showCustomSnackbar(context, "notice Filed Successfully");
        Navigation.navigateToBack(context);
      },
    );
  }

  Future<void> updateNotice({
    required Notice notice,
    required BuildContext context,
  }) async {
    final res = await _noticeAPI.updateNotice(
      notice: notice,
    );
    res.fold((l) => showCustomSnackbar(context, l.message), (r) {
      _ref.invalidate(getAllNoticesProvider);
      _ref.invalidate(getNoticeByIdProvider);
      showCustomSnackbar(context, 'Updated!');
    });
  }

  Future<List<Notice>> getAllNotices() async {
    final res = await _ref.read(noticeApiProvider).getAllNotices();
    List<Notice> notices = [];

    res.fold(
      (failure) {
        notices = [];
        print(failure.message);
      },
      (noticeList) {
        print(noticeList);
        notices = noticeList;
      },
    );

    return notices;
  }

  // Future<List<Notice>> getBookmarkedNotices() async {
  //   final uid = _ref.read(userProvider)!.uid;
  //   final res = await _ref.read(noticeApiProvider).getBookmarkednotices(uid: uid);
  //   List<Notice> notices = [];

  //   res.fold(
  //     (failure) {
  //       notices = [];
  //     },
  //     (noticeList) {
  //       notices = noticeList;
  //     },
  //   );

  //   return notices;
  // }

  Future<Notice?> getNoticeById({required String noticeId}) async {
    final res = await _noticeAPI.getNoticeById(noticeId: noticeId);
    return res.fold((l) => null, (r) => r);
  }
}
