// ignore_for_file: use_build_context_synchronously

import 'package:as_central_desk/core/core.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final cloudinaryApiProvider = Provider((ref) {
  return CloudinaryApi(
    cloudinary: CloudinaryPublic('dpnawkd7i', 'pzr05f28'),
  );
});

abstract class ICloudinaryApi {
  FutureEither<List<String>> uploadMultipleImages({
    required List<List<int>> images,
    required String folder,
  });
}

class CloudinaryApi implements ICloudinaryApi {
  final CloudinaryPublic _cloudinary;

  CloudinaryApi({
    required CloudinaryPublic cloudinary,
  }) : _cloudinary = cloudinary;

  @override
  FutureEither<List<String>> uploadMultipleImages(
      {required List<List<int>> images, required String folder,}) async {
    List<String> uploadedUrls = [];

    try {
      for (int i = 0; i < images.length; i++) {
        final response = await _cloudinary.uploadFile(
          CloudinaryFile.fromBytesData(
            images[i],
            identifier: '${images[i]}',
            folder: folder,
          ),
        );
        uploadedUrls.add(response.secureUrl);
      }
      return right(uploadedUrls);
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
