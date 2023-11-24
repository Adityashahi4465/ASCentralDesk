import 'package:as_central_desk/apis/cloudinary_api.dart';
import 'package:as_central_desk/apis/complaint_api.dart';
import 'package:as_central_desk/constants/ui_constants.dart';
import 'package:as_central_desk/core/enums/enums.dart';
import 'package:as_central_desk/features/auth/controller/auth_controller.dart';
import 'package:as_central_desk/models/complaint.dart';
import 'package:as_central_desk/routes/route_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/snackbar.dart';

final complaintControllerProvider =
    StateNotifierProvider<ComplaintController, bool>(
  (ref) => ComplaintController(
    complaintAPI: ref.watch(complaintApiProvider),
    ref: ref,
  ),
);

final getComplaintByIdProvider =
    FutureProvider.family((ref, String complaintId) {
  final complaintController = ref.watch(complaintControllerProvider.notifier);
  return complaintController.getComplaintById(complaintId: complaintId);
});

final getAllComplaintsProvider = FutureProvider<List<Complaint>>((ref) async {
  // Assuming you have a function named getAllComplaints in your controller
  final controller = ComplaintController(
    complaintAPI: ref.read(complaintApiProvider),
    ref: ref,
  );
  return controller.getAllComplaints();
});

final getBookmarkedComplaintsProvider =
    FutureProvider<List<Complaint>>((ref) async {
  // Assuming you have a function named getAllComplaints in your controller
  final controller = ComplaintController(
    complaintAPI: ref.read(complaintApiProvider),
    ref: ref,
  );
  return controller.getBookmarkedComplaints();
});

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
    required List<dynamic> imagesData,
    required String category,
    required BuildContext context,
  }) async {
    state = true;

    List<String> images = [];

    // Check the platform and handle image data accordingly
    if (kIsWeb) {
      // For web, use image bytes
      final res = await _ref.read(cloudinaryApiProvider).uploadMultipleImages(
            images: imagesData.cast<List<int>>(),
            folder: "complaint_images",
          );
      res.fold((l) {
        showCustomSnackbar(context, l.message);
        state = false;
      }, (r) => images = r);
    } else {
      // For other platforms (Android, iOS), use file paths
      final res = await _ref.read(cloudinaryApiProvider).uploadMultipleImages(
            images: imagesData.cast<String>(),
            folder: "complaint_images",
          );
      res.fold(
        (l) {
          showCustomSnackbar(context, l.message);
          state = false;
        },
        (r) => images = r,
      );
    }
    final complaint = Complaint(
      id: "",
      title: title,
      description: description,
      images: images,
      category: category,
      consults: "",
      filingTime: DateTime.now(),
      fund: 0,
      status: UiConstants.complaintStatus[0],
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

  Future<void> updateComplaint({
    required Complaint complaint,
    required BuildContext context,
  }) async {
    final res = await _complaintAPI.updateComplaint(
      complaint: complaint,
    );
    res.fold((l) => showCustomSnackbar(context, l.message), (r) {
      _ref.invalidate(getAllComplaintsProvider);
      _ref.invalidate(getComplaintByIdProvider);
    });
  }

  Future<List<Complaint>> getAllComplaints() async {
    final res = await _ref.read(complaintApiProvider).getAllComplaints();
    List<Complaint> complaints = [];

    res.fold(
      (failure) {
        complaints = [];
      },
      (complaintList) {
        complaints = complaintList;
      },
    );

    return complaints;
  }

  Future<List<Complaint>> getBookmarkedComplaints() async {
    final uid = _ref.read(userProvider)!.uid;
    final res =
        await _ref.read(complaintApiProvider).getBookmarkedComplaints(uid: uid);
    List<Complaint> complaints = [];

    res.fold(
      (failure) {
        complaints = [];
      },
      (complaintList) {
        complaints = complaintList;
      },
    );

    return complaints;
  }

  Future<Complaint?> getComplaintById({required String complaintId}) async {
    final res = await _complaintAPI.getComplaintById(complaintId: complaintId);
    return res.fold((l) => null, (r) => r);
  }
}
