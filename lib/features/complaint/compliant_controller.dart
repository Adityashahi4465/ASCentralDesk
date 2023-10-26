import 'package:as_central_desk/apis/cloudinary_api.dart';
import 'package:as_central_desk/apis/complaint_api.dart';
import 'package:as_central_desk/core/enums/enums.dart';
import 'package:as_central_desk/features/auth/controller/auth_controller.dart';
import 'package:as_central_desk/models/complaint.dart';
import 'package:as_central_desk/routes/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/snackbar.dart';

final controllerProvider = StateNotifierProvider<ComplaintController, bool>(
  (ref) => ComplaintController(
    complaintAPI: ref.watch(complaintApiProvider),
    ref: ref,
  ),
);

class ComplaintController extends StateNotifier<bool> {
  final ComplaintApi _complaintAPI;
  final Ref _ref;
  ComplaintController({required ComplaintApi complaintAPI, required Ref ref})
      : _complaintAPI = complaintAPI,
        _ref = ref,
        super(false); // loading while asynchronous tasks initially false

  void saveComplaintToDatabase({
    required String title,
    required String description,
    required List<List<int>> imageBytesList,
    required String category,
    required BuildContext context,
  }) async {
    state = true;

    List<String> images = [];

    _ref.read(cloudinaryApiProvider).uploadMultipleImages(
          images: imageBytesList,
          folder: "complaint_images",
        );

    final complaint = Complaint(
      id: "",
      title: title,
      description: description,
      images: images,
      category: category,
      consults: "",
      filingTime: DateTime.now(),
      fund: 0,
      status: ComplaintStatus.pending.toString(),
      upvotes: [],
      createdBy: _ref.read(userProvider)!.uid,
    );
    final res = await _complaintAPI.saveComplaintToDatabase(
          complaint: complaint,
        );
    state = false;
    res.fold(
      (l) {
        print(l.message);
        showCustomSnackbar(context, l.message);
      },
      (user) {
        showCustomSnackbar(context, "Complaint Filed Successfully");
        Navigation.navigateToBack(context);
      },
    );
  }
}
