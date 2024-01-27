import 'package:as_central_desk/core/enums/enums.dart';
import 'package:as_central_desk/core/utils/extensions/toggel_list_item.dart';
import 'package:as_central_desk/features/auth/controller/auth_controller.dart';
import 'package:as_central_desk/routes/route_utils.dart';
import 'package:as_central_desk/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../models/notice.dart';
import '../../../models/user.dart';
import '../../../theme/theme.dart';
import '../../user/controller/user_controller.dart';

class NoticeOverViewCard extends ConsumerWidget {
  final Notice notice;
  const NoticeOverViewCard({
    super.key,
    required this.notice,
  });

  Color getStatusColor(String status) {
    switch (status) {
      case 'Upcoming':
        return Colors.blue;
      case 'Active':
        return Colors.green;
      case 'Expired':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  String checkValidity(DateTime start, DateTime end) {
    DateTime now = DateTime.now();
    if (now.isBefore(start)) {
      return 'Upcoming';
    } else if (now.isAfter(end)) {
      return 'Expired';
    } else {
      return 'Active';
    }
  }

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        child: InkWell(
          splashColor: AppColors.splashColor,
          onTap: () => Navigation.navigateToNoticeDetailsScreen(
            context,
            notice.id,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: <Widget>[
                Text(
                  notice.title,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.textBold
                      .copyWith(fontSize: 20, color: AppColors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Posted on: ',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.displayBold.copyWith(
                        fontSize: 13,
                        color: AppColors.black,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        DateFormat.yMMMMd().format(notice.postedAt).toString(),
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.textSemiBold.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => addRemoveBookmarks(
                        ref: ref,
                        context: context,
                        user: currentUser,
                        noticeId: notice.id,
                      ),
                      icon: Icon(
                        currentUser.bookmarkedNotifications.contains(notice.id)
                            ? Icons.bookmark_added
                            : Icons.bookmark_add_outlined,
                        color:
                            currentUser.bookmarkedNotifications.contains(notice.id)
                                ? AppColors.primary
                                : AppColors.mDisabledColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Text(
                      'Valid From: ',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.displayBold.copyWith(
                        fontSize: 13,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMd().format(notice.startDate).toString(),
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.textSemiBold.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        notice.content,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: AppTextStyle.textRegular.copyWith(
                          fontSize: 14,
                          color: AppColors.greyColor,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            notice.priorityLevel,
                            style: TextStyle(
                              fontSize: 16,
                              color: notice.priorityLevel ==
                                      NoticePriority.low.toString()
                                  ? Colors.green
                                  : notice.priorityLevel ==
                                          NoticePriority.medium.toString()
                                      ? Colors.yellow
                                      : notice.priorityLevel ==
                                              NoticePriority.high.toString()
                                          ? Colors.red
                                          : Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'priority',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          checkValidity(
                              notice.startDate, notice.expirationDate),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: getStatusColor(
                              checkValidity(
                                notice.startDate,
                                notice.expirationDate,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'status',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
