import 'package:as_central_desk/routes/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_constant.dart';
import '../../../core/common/label_chip.dart';
import '../../../models/complaint.dart';
import '../../../models/user.dart';
import '../../../theme/theme.dart';

class ComplaintCard extends StatelessWidget {
  final User user;
  final Complaint complaint;
  final VoidCallback onUpvote;
  final VoidCallback onBookmark;
  const ComplaintCard({
    super.key,
    required this.user,
    required this.complaint,
    required this.onUpvote,
    required this.onBookmark,
  });

  Color getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'REJECTED':
        return Colors.red;
      case 'SOLVED':
        return Colors.green;
      case 'IN PROGRESS':
        return Colors.blue;
      default:
        return Colors.deepOrange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          border: Border.all(
            width: 1,
            color: AppColors.mDisabledColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundImage: (user.photoUrl != "")
                            ? NetworkImage(user.photoUrl)
                            : const AssetImage(
                                IMAGE_PATH_DEFAULT_USER_PROFILE_IMAGE,
                              ) as ImageProvider<Object>?,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: AppTextStyle.textSemiBold.copyWith(
                              color: AppColors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            DateFormat(
                              'd MMM yyyy hh:mm a',
                            ).format(
                              complaint.filingTime,
                            ),
                            style: AppTextStyle.textRegular.copyWith(
                              color: AppColors.mDisabledColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: onUpvote,
                            icon: Icon(
                              complaint.upvotes.contains(user.uid)
                                  ? Icons.thumb_up_alt_sharp
                                  : Icons.thumb_up_alt_outlined,
                              color: complaint.upvotes.contains(user.uid)
                                  ? AppColors.primary
                                  : AppColors.mDisabledColor,
                            ),
                          ),
                          Text(
                            complaint.upvotes.length.toString(),
                            style: AppTextStyle.displayBold.copyWith(
                              color: AppColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: onBookmark,
                        icon: Icon(
                          user.bookmarkedComplaints.contains(complaint.id)
                              ? Icons.bookmark_added
                              : Icons.bookmark_add_outlined,
                          color:
                              user.bookmarkedComplaints.contains(complaint.id)
                                  ? AppColors.primary
                                  : AppColors.mDisabledColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                thickness: 1,
                color: AppColors.mDisabledColor,
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 6,
                  runSpacing: 8,
                  children: [
                    LabelChip(
                      label: complaint.status.toString(),
                      color: getStatusColor(
                        complaint.status.toUpperCase(),
                      ),
                      icon: null,
                      backgroundColor: null,
                    ),
                    LabelChip(
                      label: complaint.category.toString(),
                      color: AppColors.purpleColor,
                      icon: null,
                      backgroundColor: null,
                    ),
                    LabelChip(
                      label: complaint.fund.toString(),
                      color: AppColors.green,
                      icon: Icons.money,
                      backgroundColor: null,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                splashColor: AppColors.splashColor,
                hoverColor: AppColors.greyColor,
                onTap: () => Navigation.navigateToComplaintDetailsScreen(
                  context,
                  complaint.id,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            complaint.title,
                            style: AppTextStyle.textRegular.copyWith(
                              color: AppColors.black,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            complaint.description,
                            style: AppTextStyle.textLight.copyWith(
                              color: AppColors.greyColor,
                              fontSize: 11,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.greyColor,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
