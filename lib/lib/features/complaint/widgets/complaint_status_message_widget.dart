import 'package:flutter/material.dart';

import '../../../constants/ui_constants.dart';
import '../../../models/complaint.dart';
import '../../../models/user.dart';
import '../../../theme/theme.dart';

class CompliantStatusMessage extends StatelessWidget {
  final Complaint complaint;
  final User user;

  const CompliantStatusMessage({
    super.key,
    required this.user,
    required this.complaint,
  });

  @override
  Widget build(BuildContext context) {
    final rejectedCompliant =
        complaint.status == UiConstants.complaintStatus[3];
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: rejectedCompliant
              ? AppColors.red.withOpacity(0.1)
              : AppColors.green
                  .withOpacity(0.1), // Background color for rejection
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            rejectedCompliant
                ? const Icon(
                    Icons.cancel,
                    color: AppColors.red,
                    size: 24,
                  )
                : const Icon(
                    Icons.done_all_sharp,
                    color: AppColors.green,
                    size: 24,
                  ),
            const SizedBox(
              width: 8,
            ),
            rejectedCompliant
                ? Text(
                    'Unfortunately, ${complaint.createdBy == user.uid ? "your" : "this"} complaint has been rejected.',
                    style: AppTextStyle.displayBold.copyWith(
                      color: AppColors.red,
                      fontSize: 16,
                    ),
                  )
                : Text(
                    'Yeh!, ${complaint.createdBy == user.uid ? "your" : "this"} complaint has been solved!.',
                    style: AppTextStyle.displayBold.copyWith(
                      color: AppColors.green,
                      fontSize: 16,
                    ),
                  ),
            // You can add more information or details about the rejection if needed
          ],
        ),
      ),
    );
  }
}
