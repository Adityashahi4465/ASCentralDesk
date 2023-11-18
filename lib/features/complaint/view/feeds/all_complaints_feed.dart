import 'package:as_central_desk/core/common/error_text.dart';
import 'package:as_central_desk/core/common/loader.dart';
import 'package:as_central_desk/features/complaint/controller/compliant_controller.dart';
import 'package:as_central_desk/theme/app_colors.dart';
import 'package:as_central_desk/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllComplaintsFeed extends ConsumerWidget {
  const AllComplaintsFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getAllComplaintsProvider).when(
          data: (complaints) {
            return ListView.builder(
              itemCount: complaints.length,
              itemBuilder: (context, index) {
                final complaint = complaints[index];
                // Build your UI based on each complaint
                return ListTile(
                  title: Text(
                    complaint.title,
                    style: AppTextStyle.textMedium
                        .copyWith(color: AppColors.black,),
                  ),
                  // Add other widgets as needed
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
