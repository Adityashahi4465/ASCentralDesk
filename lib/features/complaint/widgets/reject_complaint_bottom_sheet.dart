import 'package:as_central_desk/constants/ui_constants.dart';
import 'package:as_central_desk/features/complaint/controller/compliant_controller.dart';
import 'package:as_central_desk/models/complaint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/rounded_button.dart';
import '../../../core/utils/snackbar.dart';
import '../../../theme/app_colors.dart';
import '../controller/local_complaint_providers.dart';

// ignore: must_be_immutable
class RejectComplaintBottomSheet extends ConsumerWidget {
  final Complaint complaint;
  RejectComplaintBottomSheet({
    super.key,
    required this.complaint,
  });
  void handleReject(
      String selectedReason, WidgetRef ref, BuildContext context) {
    print("Rejected with reason: $selectedReason");
    if (complaint.status != UiConstants.complaintStatus[2]) {
      ref.read(complaintControllerProvider.notifier).updateComplaint(
            complaint: complaint.copyWith(
              status: UiConstants.complaintStatus[3],
            ),
            context: context,
          );
      showCustomSnackbar(context, 'Complaint Rejected');
    }
  }

  String temp = "";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String rejectionReason = ref.watch(complaintRejectionReasonProvider);

    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Select a reason for rejecting the complaint:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text("Incomplete Information"),
                selected: rejectionReason == "Incomplete Information",
                onSelected: (selected) {
                  ref.read(complaintRejectionReasonProvider.notifier).state =
                      selected ? "Incomplete Information" : "";
                  temp = "";
                },
              ),
              ChoiceChip(
                label: const Text("Duplicate Complaint"),
                selected: rejectionReason == "Duplicate Complaint",
                onSelected: (selected) {
                  ref.read(complaintRejectionReasonProvider.notifier).state =
                      selected ? "Duplicate Complaint" : "";
                  temp = "";
                },
              ),
              ChoiceChip(
                label: const Text("Not Appropriate"),
                selected: rejectionReason == "Not Appropriate",
                onSelected: (selected) {
                  ref.read(complaintRejectionReasonProvider.notifier).state =
                      selected ? "Not Appropriate" : "";
                  temp = "";
                },
              ),
              ChoiceChip(
                label: const Text("Out of Scope"),
                selected: rejectionReason == "Out of Scope",
                onSelected: (selected) {
                  ref.read(complaintRejectionReasonProvider.notifier).state =
                      selected ? "Out of Scope" : "";
                  temp = "";
                },
              ),
              ChoiceChip(
                label: const Text("Resolved"),
                selected: rejectionReason == "Resolved",
                onSelected: (selected) {
                  ref.read(complaintRejectionReasonProvider.notifier).state =
                      selected ? "Resolved" : "";

                  temp = "";
                },
              ),
              ChoiceChip(
                label: const Text("Other"),
                selected: temp == "Other",
                onSelected: (selected) {
                  ref.read(complaintRejectionReasonProvider.notifier).state =
                      selected ? "Other" : "";
                  temp = "Other";
                },
              ),
            ],
          ),
          if (temp == "Other")
            TextField(
              decoration: const InputDecoration(
                labelText: "Enter The reason",
              ),
              onChanged: (customReason) {
                ref.read(complaintRejectionReasonProvider.notifier).update(
                      (state) => customReason,
                    );
              },
            ),
          const SizedBox(height: 16),
          RoundedButton(
            onPressed: () {
              handleReject(
                rejectionReason,
                ref,
                context,
              );
              Navigator.pop(context);
            },
            text: "Submit",
            linearGradient: AppColors.redGradient,
          ),
        ],
      ),
    );
  }

  void showCustomTextfieldBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Enter custom consults:"),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Type here...",
                ),
                // Handle the input as needed
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        );
      },
    );
  }
}
