import 'package:as_central_desk/features/notice/controller/notice_controller.dart';
import 'package:as_central_desk/features/notice/widgets/notice_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';

class AllNoticeScreen extends ConsumerWidget {
  final bool backNavigationAllowed;

  const AllNoticeScreen({
    super.key,
    required this.backNavigationAllowed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(getAllNoticesProvider).when(
            data: (allNotices) {
              return ListView.builder(
                itemCount: allNotices.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  allNotices.sort(
                    (a, b) => b.postedAt.compareTo(
                      a.postedAt,
                    ),
                  ); // Sort by postedAt in descending order)
                  final notice = allNotices[index];

                  return NoticeOverViewCard(
                    notice: notice,
                  );
                },
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
