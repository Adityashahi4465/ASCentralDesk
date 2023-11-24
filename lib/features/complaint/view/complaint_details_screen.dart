import 'dart:convert';

import 'package:as_central_desk/core/common/label_chip.dart';
import 'package:as_central_desk/core/common/rounded_button.dart';
import 'package:as_central_desk/core/core.dart';
import 'package:as_central_desk/core/utils/extensions/toggel_list_item.dart';
import 'package:as_central_desk/core/utils/snackbar.dart';
import 'package:as_central_desk/features/complaint/controller/compliant_controller.dart';
import 'package:as_central_desk/features/user/controller/user_controller.dart';
import 'package:as_central_desk/routes/route_utils.dart';
import 'package:as_central_desk/theme/app_colors.dart';
import 'package:as_central_desk/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../constants/ui_constants.dart';
import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';
import '../../../models/complaint.dart';
import '../../../models/user.dart';
import '../../auth/controller/auth_controller.dart';
import '../widgets/approve_complaint_bottom_sheet.dart';
import '../widgets/complaint_status_message_widget.dart';
import '../widgets/reject_complaint_bottom_sheet.dart';
import '../widgets/solve_complaint_bottom_sheet.dart';

class ComplaintDetailsScreen extends ConsumerWidget {
  final String complaintId;
  const ComplaintDetailsScreen({
    Key? key,
    required this.complaintId,
  }) : super(key: key);

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

  FutureVoid onRefresh(
    WidgetRef ref,
    String id,
    String uid,
  ) async {
    ref.invalidate(
      getUserDataByIdProvider(uid),
    );
    ref.invalidate(
      getComplaintByIdProvider(id),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final user = ref.watch(userProvider)!;
    return ref.watch(getComplaintByIdProvider(complaintId)).when(
          data: (complaint) {
            return Scaffold(
              body: SafeArea(
                child: LiquidPullToRefresh(
                  color: AppColors.secondary,
                  height: 300,
                  backgroundColor: AppColors.white,
                  animSpeedFactor: 2,
                  showChildOpacityTransition: false,
                  onRefresh: () => onRefresh(
                    ref,
                    complaint.id,
                    complaint.createdBy,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.orangeGradient,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: AppColors.orangeGradient,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: AppColors.white,
                                      ),
                                      onPressed: () =>
                                          Navigation.navigateToBack(context),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            LabelChip(
                                              label: complaint!.status,
                                              color: getStatusColor(
                                                  complaint.status),
                                              icon: null,
                                              backgroundColor: AppColors.white,
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            LabelChip(
                                              label: '#id: $complaintId',
                                              color: AppColors.greyColor,
                                              icon: null,
                                              backgroundColor: AppColors.white,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          complaint.title,
                                          style:
                                              AppTextStyle.textHeavy.copyWith(
                                            color: AppColors.white,
                                            fontSize: 16,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'complaint raised at:${DateFormat('d MMM yyyy hh:mm a').format(complaint.filingTime)}',
                                          style:
                                              AppTextStyle.textRegular.copyWith(
                                            color: AppColors.lightWhite,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //////////////////////////////////////////////////////////         BODY         ///////////////////////////////
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20.0)),
                              ),
                              child: SingleChildScrollView(
                                physics: const ClampingScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          LabelChip(
                                            label:
                                                'Fund alloted: ${complaint.fund}',
                                            color: AppColors.green,
                                            icon: Icons.money,
                                            backgroundColor: null,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () =>
                                                        updateVotes(ref,
                                                            context, complaint),
                                                    icon: Icon(
                                                      complaint.upvotes
                                                              .contains(
                                                                  user.uid)
                                                          ? Icons
                                                              .thumb_up_alt_sharp
                                                          : Icons
                                                              .thumb_up_alt_outlined,
                                                      color: complaint.upvotes
                                                              .contains(
                                                                  user.uid)
                                                          ? AppColors.primary
                                                          : AppColors
                                                              .mDisabledColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    complaint.upvotes.length
                                                        .toString(),
                                                    style: AppTextStyle
                                                        .displayBold
                                                        .copyWith(
                                                      color: AppColors.primary,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                onPressed: () =>
                                                    addRemoveBookmarks(
                                                  ref,
                                                  context,
                                                  user,
                                                  complaintId,
                                                ),
                                                icon: Icon(
                                                  user.bookmarkedComplaints
                                                          .contains(
                                                              complaint.id)
                                                      ? Icons.bookmark_added
                                                      : Icons
                                                          .bookmark_add_outlined,
                                                  color: user
                                                          .bookmarkedComplaints
                                                          .contains(
                                                              complaint.id)
                                                      ? AppColors.primary
                                                      : AppColors
                                                          .mDisabledColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Description',
                                        style: AppTextStyle.textBold.copyWith(
                                          fontSize: 16,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        complaint.description,
                                        style: AppTextStyle.displayRegular
                                            .copyWith(
                                          fontSize: 12,
                                          color: AppColors.black,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      ref
                                          .watch(
                                            getUserDataByIdProvider(
                                              complaint.createdBy,
                                            ),
                                          )
                                          .when(
                                            data: (userData) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                child: Container(
                                                  width: double.maxFinite,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: AppColors.white,
                                                    border: Border.all(
                                                      width: 1,
                                                      color: AppColors
                                                          .mDisabledColor,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    userData!
                                                                        .photoUrl,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      userData
                                                                          .name,
                                                                      style: AppTextStyle
                                                                          .textSemiBold
                                                                          .copyWith(
                                                                        color: AppColors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      DateFormat(
                                                                        'd MMM yyyy hh:mm a',
                                                                      ).format(
                                                                        complaint
                                                                            .filingTime,
                                                                      ),
                                                                      style: AppTextStyle
                                                                          .textRegular
                                                                          .copyWith(
                                                                        color: AppColors
                                                                            .mDisabledColor,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            const Divider(
                                                              thickness: 1,
                                                              color: AppColors
                                                                  .mDisabledColor,
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            const SizedBox(
                                                              height: 12,
                                                            ),
                                                            InkWell(
                                                              splashColor:
                                                                  AppColors
                                                                      .splashColor,
                                                              hoverColor:
                                                                  AppColors
                                                                      .greyColor,
                                                              onTap: () =>
                                                                  Navigation
                                                                      .navigateToComplaintDetailsScreen(
                                                                context,
                                                                complaint.id,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    'View Profile',
                                                                    style: AppTextStyle
                                                                        .textLight
                                                                        .copyWith(
                                                                      color: AppColors
                                                                          .greyColor,
                                                                      fontSize:
                                                                          11,
                                                                    ),
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {},
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .arrow_forward_ios_rounded,
                                                                      color: AppColors
                                                                          .greyColor,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            error: (error, stackTrace) =>
                                                ErrorText(
                                              error: error.toString(),
                                            ),
                                            loading: () => const Loader(),
                                          ),
                                      Text(
                                        'Consults',
                                        style: AppTextStyle.textBold.copyWith(
                                          fontSize: 16,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        complaint.consults,
                                        style: AppTextStyle.displayRegular
                                            .copyWith(
                                          fontSize: 12,
                                          color: AppColors.black,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      SizedBox(
                                        height: 250,
                                        child: PageView.builder(
                                          itemCount: complaint.images.length,
                                          itemBuilder: (context, index) =>
                                              Image.network(
                                            complaint.images[index],
                                            width: double.maxFinite,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),

                                      ////// //////////////////////////////       BOTTOM RESPONSE BUTTON       ///////////////////////////////////
                                      (complaint.status !=
                                                  UiConstants
                                                      .complaintStatus[0] &&
                                              complaint.status !=
                                                  UiConstants
                                                      .complaintStatus[1])
                                          ? CompliantStatusMessage(
                                              user: user,
                                              complaint: complaint,
                                            )
                                          : user.role !=
                                                  UiConstants.userRoles[1]
                                              ? Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    InkWell(
                                                      onTap: () =>
                                                          showCustomSnackbar(
                                                        context,
                                                        "Double Tap to Reject the complaint",
                                                      ),
                                                      onDoubleTap: () async {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) =>
                                                              RejectComplaintBottomSheet(
                                                            complaint:
                                                                complaint,
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        //color: Color(0xFF181D3D),
                                                        width: (0.9 *
                                                                    MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                25) /
                                                            3,
                                                        height: (0.6 *
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height) /
                                                            9,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.deepOrange,
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft: Radius.circular((0.6 *
                                                                    MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height) /
                                                                20),
                                                            bottomLeft:
                                                                Radius.circular(
                                                              (0.6 *
                                                                      MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height) /
                                                                  20,
                                                            ),
                                                            topRight:
                                                                Radius.zero,
                                                            bottomRight:
                                                                Radius.zero,
                                                          ),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            "Reject",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const VerticalDivider(
                                                      color: Color.fromRGBO(
                                                          58, 128, 203, 1),
                                                      width: 1.0,
                                                    ),

                                                    ///////////////////////////////////////// Approve  /////////////////////////////
                                                    InkWell(
                                                      onTap: () =>
                                                          showCustomSnackbar(
                                                        context,
                                                        "Double Tap to Approve the complaint",
                                                      ),
                                                      onDoubleTap: () async {
                                                        // if (snapshot.data!['status'] !=
                                                        //     status[2]) {
                                                        //   await ComplaintFiling()
                                                        //       .complaints
                                                        //       .doc(widget._complaintID)
                                                        //       .update({'status': status[1]});
                                                        // }
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) =>
                                                              ApproveComplaintBottomSheet(
                                                            complaint:
                                                                complaint,
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        //color: Color(0xFF181D3D),
                                                        width: (0.9 *
                                                                    MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                25) /
                                                            3,
                                                        height: (0.6 *
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height) /
                                                            9,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xFF181D3D),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius: user
                                                                      .role ==
                                                                  UiConstants
                                                                      .userRoles[2]
                                                              ? BorderRadius.only(
                                                                  topLeft:
                                                                      Radius
                                                                          .zero,
                                                                  bottomLeft:
                                                                      Radius
                                                                          .zero,
                                                                  topRight: Radius
                                                                      .circular((0.6 *
                                                                              MediaQuery.of(
                                                                                context,
                                                                              ).size.height) /
                                                                          20),
                                                                  bottomRight:
                                                                      Radius
                                                                          .circular(
                                                                    (0.6 *
                                                                            MediaQuery.of(
                                                                              context,
                                                                            ).size.height) /
                                                                        20,
                                                                  ),
                                                                )
                                                              : null,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            complaint.status ==
                                                                    UiConstants
                                                                        .complaintStatus[2]
                                                                ? "Approved"
                                                                : "Approve",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const VerticalDivider(
                                                      color: Color.fromRGBO(
                                                          58, 128, 203, 1),
                                                      width: 1.0,
                                                    ),

                                                    /////////////////////////////////          Solved          //////////////////////////
                                                    user.role ==
                                                            UiConstants
                                                                .userRoles[0]
                                                        ? InkWell(
                                                            onTap: () =>
                                                                showCustomSnackbar(
                                                              context,
                                                              "Double Tap to Solve the complaint",
                                                            ),
                                                            onDoubleTap:
                                                                () async {
                                                              // if (snapshot.data!['status'] !=
                                                              //     status[2]) {
                                                              //   //await snapshot.data.data().update('status', (value) => status[4]);
                                                              //   await ComplaintFiling()
                                                              //       .complaints
                                                              //       .doc(widget._complaintID)
                                                              //       .update({'status': status[3]});
                                                              // }
                                                              showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        SolveComplaintBottomSheet(
                                                                  complaint:
                                                                      complaint,
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              //color: Color(0xFF181D3D),
                                                              width: (0.9 *
                                                                          MediaQuery.of(context)
                                                                              .size
                                                                              .width -
                                                                      25) /
                                                                  3,
                                                              height: (0.6 *
                                                                      MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height) /
                                                                  9,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft:
                                                                      Radius
                                                                          .zero,
                                                                  bottomLeft:
                                                                      Radius
                                                                          .zero,
                                                                  topRight: Radius
                                                                      .circular((0.6 *
                                                                              MediaQuery.of(
                                                                                context,
                                                                              ).size.height) /
                                                                          20),
                                                                  bottomRight:
                                                                      Radius
                                                                          .circular(
                                                                    (0.6 *
                                                                            MediaQuery.of(
                                                                              context,
                                                                            ).size.height) /
                                                                        20,
                                                                  ),
                                                                ),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  "Solved",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                )
                                              : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
