import 'package:as_central_desk/apis/local_storage_api.dart';
import 'package:as_central_desk/core/core.dart';
import 'package:as_central_desk/core/providers.dart';
import 'package:as_central_desk/models/complaint.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import '../core/api_config.dart';
import '../core/utils/error_hendling.dart';
import '../models/user.dart';

final complaintApiProvider = Provider<ComplaintApi>((ref) {
  return ComplaintApi(
      client: ref.watch(clientProvider),
      localStorageApi: ref.watch(localStorageApiProvider));
});

abstract class IComplaintAPI {
  FutureVoid saveComplaintToDatabase({
    required Complaint complaint,
  });
}

class ComplaintApi implements IComplaintAPI {
  final Client _client;
  final LocalStorageApi _localStorageApi;
  ComplaintApi(
      {required Client client, required LocalStorageApi localStorageApi})
      : _client = client,
        _localStorageApi = localStorageApi;

  @override
  FutureEither saveComplaintToDatabase({
    required Complaint complaint,
  }) async {
    String? token = await _localStorageApi.getToken();
    final response = await _client.post(
      Uri.parse('$hostUrl/api/v1/auth/complaint/add-new-complaint'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token!,
      },
    );

    final apiResponse = handleApiResponse(response);
    if (apiResponse.success) {
      return right(null);
    } else {
      return left(
        Failure(
          apiResponse.error!,
        ),
      );
    }
  }
}
