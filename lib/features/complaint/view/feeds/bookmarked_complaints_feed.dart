import 'package:as_central_desk/core/common/error_text.dart';
import 'package:as_central_desk/core/common/loader.dart';
import 'package:as_central_desk/core/utils/extensions/toggel_list_item.dart';
import 'package:as_central_desk/features/auth/controller/auth_controller.dart';
import 'package:as_central_desk/features/complaint/controller/compliant_controller.dart';
import 'package:as_central_desk/models/complaint.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/user.dart';
import '../../../user/controller/user_controller.dart';
import '../../widgets/complaint_card.dart';

class BookmarkedComplaintsFeed extends ConsumerWidget {
  const BookmarkedComplaintsFeed({super.key});

  void updateVotes(WidgetRef ref, BuildContext context, Complaint complaint) {
    final currentUserUid = ref.read(userProvider)!.uid;

    complaint.upvotes.toggle(currentUserUid);

    ref.read(complaintControllerProvider.notifier).updateComplaint(
          complaint: complaint,
          context: context,
        );
  }

  void addRemoveBookmarks(
    WidgetRef ref,
    BuildContext context,
    User user,
    String complaintId,
  ) {
    user.bookmarkedComplaints.toggle(complaintId);

    ref.read(userControllerProvider.notifier).updateUser(
          user: user,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getBookmarkedComplaintsProvider).when(
          data: (complaints) {
            return ListView.builder(
              itemCount: complaints.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final complaint = complaints[index];
                // Build your UI based on each complaint
                return ref
                    .watch(getUserDataByIdProvider(complaint.createdBy))
                    .when(
                      data: (user) {
                        return ComplaintCard(
                          user: user!,
                          complaint: complaint,
                          onUpvote: () => updateVotes(ref, context, complaint),
                          onBookmark: () => addRemoveBookmarks(
                            ref,
                            context,
                            user,
                            complaint.id,
                          ),
                        );
                      },
                      error: (error, stackTrace) => ErrorText(
                        error: error.toString(),
                      ),
                      loading: () => const SizedBox(),
                    );
              },
            );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
