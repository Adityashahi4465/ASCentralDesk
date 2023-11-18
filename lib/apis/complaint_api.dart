import 'dart:convert';

import 'package:as_central_desk/apis/local_storage_api.dart';
import 'package:as_central_desk/core/core.dart';
import 'package:as_central_desk/core/providers.dart';
import 'package:as_central_desk/models/complaint.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import '../constants/app_constant.dart';
import '../core/api_config.dart';
import '../core/utils/error_hendling.dart';

final complaintApiProvider = Provider<ComplaintApi>((ref) {
  return ComplaintApi(
      client: ref.watch(clientProvider),
      localStorageApi: ref.watch(localStorageApiProvider));
});

abstract class IComplaintAPI {
  FutureVoid saveComplaintToDatabase({
    required Complaint complaint,
  });
  FutureEither<List<Complaint>> getAllComplaints();
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
    try {
      String? token = await _localStorageApi.getToken();

      final encodedJson = complaint.toJson();
      print('Encoded JSON: $encodedJson');
      final response = await _client.post(
        Uri.parse('$hostUrl/api/v1/auth/complaint/add-new-complaint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!,
        },
        body: complaint.toJson(),
      );

      final apiResponse = handleApiResponse(response);
      if (apiResponse.success) {
        print(apiResponse.statusCode);
        return right(null);
      } else {
        print('khhhhhhhhhhhhhhhhhhh ${apiResponse.error}!');
        return left(
          Failure(
            apiResponse.error!,
          ),
        );
      }
    } catch (e) {
      print("Chached " + e.toString());
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  FutureEither<List<Complaint>> getAllComplaints() async {
    try {
      String? token = await _localStorageApi.getToken();
      if (token != null) {
        var res = await _client.get(
            Uri.parse('$hostUrl/api/v1/auth/complaint/get-all-complaints'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token': token,
            });

        final apiResponse = handleApiResponse(res);
        if (apiResponse.success) {
          final complaintsJson = jsonDecode(res.body)['complaints'];

          List<Complaint> complaints = [];

          for (var complaintMap in complaintsJson) {
            print('\n\nProcessing complaintMap: $complaintMap\n');
            try {
              Complaint complaint =
                  Complaint.fromMap(complaintMap as Map<String, dynamic>);
              print('Adding complaint to list: $complaint');
              complaints.add(complaint);
            } catch (e) {
              print('Error processing complaintMap: $e');
            }
          }

          print('List of complaints: $complaints');

          return right(complaints);
        } else {
          return left(
            Failure(
              apiResponse.error!,
            ),
          );
        }
      } else {
        return left(
          const Failure(
            TOKEN_NOT_FOUND_ERROR,
          ),
        );
      }
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
