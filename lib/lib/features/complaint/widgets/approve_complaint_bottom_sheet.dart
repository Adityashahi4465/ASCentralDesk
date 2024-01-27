import 'package:as_central_desk/constants/ui_constants.dart';
import 'package:as_central_desk/core/common/rounded_button.dart';
import 'package:as_central_desk/core/common/text_input_field.dart';
import 'package:as_central_desk/features/complaint/controller/compliant_controller.dart';
import 'package:as_central_desk/models/complaint.dart';
import 'package:as_central_desk/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/snackbar.dart';
import '../controller/local_complaint_providers.dart';

// ignore: must_be_immutable
class ApproveComplaintBottomSheet extends ConsumerWidget {
  final Complaint complaint;
  ApproveComplaintBottomSheet({
    super.key,
    required this.complaint,
  });

  final TextEditingController consultController = TextEditingController();
  final TextEditingController fundController = TextEditingController();

  void handleSolve(WidgetRef ref, BuildContext context) {
    if (complaint.status != UiConstants.complaintStatus[3]) {
      ref.read(complaintControllerProvider.notifier).updateComplaint(
            complaint: complaint.copyWith(
              status: UiConstants.complaintStatus[1],
              fund: int.parse(fundController.text.trim()),
              consults: consultController.text.trim(),
            ),
            context: context,
          );
      showCustomSnackbar(context, 'Complaint Approved');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextInputFieldWithToolTip(
              controller: consultController,
              toolTipMessage: 'Enter Any Feedback if any',
              tipText: 'Any Feedback?',
              hintText: 'Enter Feedback',
              maxLength: 1000,
              validator: (validator) {
                return null;
              },
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            TextInputFieldWithToolTip(
              controller: fundController,
              toolTipMessage: 'Enter Fund if allocated',
              tipText: 'Fund Allocated for this complaint',
              hintText: 'Enter Allocated Fund',
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: true,
              ),
              maxLength: 8,
              validator: (value) {
                if (value is num)
                  return null;
                else {
                  return 'Should contain only numbers';
                }
              },
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            RoundedButton(
              onPressed: () {
                handleSolve(ref, context);
                Navigator.pop(context);
              },
              text: "Submit",
              linearGradient: AppColors.blueGradient,
            )
          ],
        ),
      ),
    );
  }
}
