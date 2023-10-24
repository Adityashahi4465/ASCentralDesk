import 'package:as_central_desk/apis/cloudinary_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/snackbar.dart';

class CloudinaryController extends StateNotifier<bool> {
  final CloudinaryApi _cloudinaryAPI;
  final Ref _ref;
  CloudinaryController({
    required CloudinaryApi cloudinaryAPI,
    required Ref ref,
  })  : _cloudinaryAPI = cloudinaryAPI,
        _ref = ref,
        super(false); // loading while asynchronous tasks initially false

  Future<List<String>?> uploadMultipleImages({
    required List<List<int>> images,
    required String folder,
    required BuildContext context,
  }) async {
    List<String>? imageUrls;
    final res = await _ref.read(cloudinaryApiProvider).uploadMultipleImages(
          images: images,
          folder: folder,
        );
    res.fold(
      (l) => showCustomSnackbar(
        context,
        'Image upload failed ${l.message}',
      ),
      (r) => imageUrls = r,
    );
    return imageUrls;
  }
}

