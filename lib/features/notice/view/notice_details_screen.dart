import 'package:as_central_desk/core/utils/extensions/toggel_list_item.dart';
import 'package:as_central_desk/features/notice/controller/notice_controller.dart';
import 'package:as_central_desk/features/user/controller/user_controller.dart';
import 'package:as_central_desk/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../core/type_defs.dart';
import '../../../models/user.dart';
import '../../../routes/route_utils.dart';
import '../../auth/controller/auth_controller.dart';

class NoticeDetailsScreen extends ConsumerWidget {
  final String noticeId;

  const NoticeDetailsScreen({
    super.key,
    required this.noticeId,
  });
  void addRemoveBookmarks({
    required WidgetRef ref,
    required BuildContext context,
    required User user,
    required String noticeId,
  }) {
    user.bookmarkedNotifications.toggle(noticeId);
    ref.read(userControllerProvider.notifier).updateUser(
          user: user,
          context: context,
        );
  }

  FutureVoid onRefresh(
    WidgetRef ref,
    String id,
    String uid,
  ) async {
    ref.invalidate(
      getUserDataByIdProvider(uid),
    );
    ref.invalidate(
      getNoticeByIdProvider(id),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider)!;

    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          'Notice Details',
          style: AppTextStyle.displayBlack.copyWith(
            color: AppColors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: AppColors.black,
            size: 30,
          ),
          onPressed: () => Navigation.navigateToBack(context),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => addRemoveBookmarks(
              ref: ref,
              context: context,
              user: currentUser,
              noticeId: noticeId,
            ),
            icon: Icon(
              currentUser.bookmarkedNotifications.contains(noticeId)
                  ? Icons.bookmark_added
                  : Icons.bookmark_add_outlined,
              color: currentUser.bookmarkedNotifications.contains(noticeId)
                  ? AppColors.primary
                  : AppColors.mDisabledColor,
            ),
          ),
        ],
      ),
      body: ref.watch(getNoticeByIdProvider(noticeId)).when(
            data: (notice) {
              return ref.watch(getUserDataByIdProvider(notice!.author)).when(
                    data: (user) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notice.title,
                                style: AppTextStyle.textBold.copyWith(
                                  fontSize: 24,
                                  color: AppColors.black,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    size: 18.0,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    'Posted by: ',
                                    style: AppTextStyle.textBold.copyWith(
                                      fontSize: 18,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Text(
                                    user!.email,
                                    style: AppTextStyle.displayMedium.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.school,
                                    size: 18.0,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    'Targeted Campuses: ',
                                    style: AppTextStyle.textBold.copyWith(
                                      fontSize: 18,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Text(
                                    notice.targetCampuses.join(
                                        ', '), // Join the campuses with ', '
                                    style: AppTextStyle.displayMedium.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              SelectableText(
                                notice.content,
                                style: AppTextStyle.displayBold.copyWith(
                                    fontSize: 16.0,
                                    color: AppColors.black,
                                    letterSpacing: 1.5),
                              ),
                              const SizedBox(height: 20.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                ),
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: AppColors.lightShadowColor
                                        .withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Valid From',
                                              style: AppTextStyle.displayLight
                                                  .copyWith(
                                                color: AppColors.black,
                                                fontSize: 14,
                                                letterSpacing: 3,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              DateFormat('d MMM yyyy hh:mm a')
                                                  .format(
                                                notice.startDate,
                                              ),
                                              style: AppTextStyle.textBold
                                                  .copyWith(
                                                color: AppColors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Valid Till',
                                              style: AppTextStyle.displayLight
                                                  .copyWith(
                                                color: AppColors.black,
                                                fontSize: 14,
                                                letterSpacing: 3,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              DateFormat('d MMM yyyy hh:mm a')
                                                  .format(
                                                notice.expirationDate,
                                              ),
                                              style: AppTextStyle.textHeavy
                                                  .copyWith(
                                                color: AppColors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Priority:',
                                          style: AppTextStyle.textBold.copyWith(
                                            fontSize: 18,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          notice.priorityLevel,
                                          style: AppTextStyle.displayMedium
                                              .copyWith(
                                            fontSize: 16.0,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Posted At:',
                                          style: AppTextStyle.textBold.copyWith(
                                            fontSize: 18,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          DateFormat.yMMMMd()
                                              .format(notice.postedAt),
                                          style: AppTextStyle.displayMedium
                                              .copyWith(
                                            fontSize: 16.0,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Category:',
                                          style: AppTextStyle.textBold.copyWith(
                                            fontSize: 18,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          notice.category,
                                          style: AppTextStyle.displayMedium
                                              .copyWith(
                                            fontSize: 16.0,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Visibility:',
                                          style: AppTextStyle.textBold.copyWith(
                                            fontSize: 18,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          notice.visibility,
                                          style: AppTextStyle.displayMedium
                                              .copyWith(
                                            fontSize: 16.0,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.mail,
                                    size: 18.0,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 6.0),
                                  Text(
                                    'Contact: ',
                                    style: AppTextStyle.textBold.copyWith(
                                      fontSize: 18,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Text(
                                    notice
                                        .authorContact, // Join the campuses with ', '
                                    style: AppTextStyle.displayMedium.copyWith(
                                      fontSize: 16.0,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    error: (error, stackTrace) => ErrorText(
                      error: error.toString(),
                    ),
                    loading: () => const Loader(),
                  );
            },
            error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loader(),
          ),
    );
  }
}
