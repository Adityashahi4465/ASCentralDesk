import 'dart:convert';

import 'package:as_central_desk/apis/local_storage_api.dart';
import 'package:as_central_desk/core/core.dart';
import 'package:as_central_desk/core/providers.dart';
import 'package:as_central_desk/models/notice.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import '../constants/app_constant.dart';
import '../core/api_config.dart';
import '../core/utils/error_hendling.dart';

final noticeApiProvider = Provider<NoticeApi>((ref) {
  return NoticeApi(
      client: ref.watch(clientProvider),
      localStorageApi: ref.watch(localStorageApiProvider));
});

abstract class INoticeAPI {
  FutureVoid saveNoticeToDatabase({
    required Notice notice,
  });
  FutureEither updateNotice({
    required Notice notice,
  });
  FutureEither<List<Notice>> getAllNotices();
  FutureEither<List<Notice>> getBookmarkedNotices({required String uid});
  FutureEither<Notice> getNoticeById({required String noticeId});
}

class NoticeApi implements INoticeAPI {
  final Client _client;
  final LocalStorageApi _localStorageApi;
  NoticeApi({required Client client, required LocalStorageApi localStorageApi})
      : _client = client,
        _localStorageApi = localStorageApi;

  @override
  FutureEither saveNoticeToDatabase({
    required Notice notice,
  }) async {
    try {
      String? token = await _localStorageApi.getToken();

      final encodedJson = notice.toJson();
      final response = await _client.post(
        Uri.parse('$hostUrl/api/v1/auth/notice/add-new-notice'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!,
        },
        body: notice.toJson(),
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
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  FutureEither updateNotice({
    required Notice notice,
  }) async {
    try {
      String? token = await _localStorageApi.getToken();

      final encodedJson = notice.toJson();
      print('Encoded JSON: $encodedJson');
      final response = await _client.put(
        Uri.parse('$hostUrl/api/v1/auth/Notice/update-notice/${notice.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!,
        },
        body: encodedJson,
      );

      final apiResponse = handleApiResponse(response);
      if (apiResponse.success) {
        print(apiResponse.statusCode);
        return right(null);
      } else {
        print('Error: ${apiResponse.error}!');
        return left(
          Failure(
            apiResponse.error!,
          ),
        );
      }
    } catch (e) {
      print("Caught exception: " + e.toString());
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  @override
  FutureEither<List<Notice>> getAllNotices() async {
    try {
      String? token = await _localStorageApi.getToken();
      if (token != null) {
        var res = await _client.get(
            Uri.parse('$hostUrl/api/v1/auth/notice/get-all-notices'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token': token,
            });

        final apiResponse = handleApiResponse(res);
        if (apiResponse.success) {
          final noticesJson = jsonDecode(res.body)['notices'];

          List<Notice> notices = [];

          for (var noticeMap in noticesJson) {
            try {
              Notice notice = Notice.fromMap(noticeMap as Map<String, dynamic>);
              notices.add(notice);
            } catch (e) {
              print('Error processing noticeMap: $e');
            }
          }
          return right(notices);
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

  @override
  FutureEither<List<Notice>> getBookmarkedNotices({required String uid}) async {
    try {
      String? token = await _localStorageApi.getToken();
      if (token != null) {
        var res = await _client.get(
            Uri.parse(
              '$hostUrl/api/v1/auth/Notice/get-bookmarked-Notices/$uid',
            ),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token': token,
            });

        final apiResponse = handleApiResponse(res);
        print("resssssssssssssssssss :  ${apiResponse.error}");
        if (apiResponse.success) {
          final noticesJson = jsonDecode(res.body)['Notices'];
          print("resssssssssssssssssss :  $noticesJson");

          List<Notice> Notices = [];

          for (var noticeMap in noticesJson) {
            try {
              Notice notice = Notice.fromMap(
                noticeMap as Map<String, dynamic>,
              );
              Notices.add(notice);
            } catch (e) {
              print('Error processing noticeMap: $e');
            }
          }
          print(Notices);
          return right(Notices);
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

  @override
  FutureEither<Notice> getNoticeById({required String noticeId}) async {
    try {
      String? token = await _localStorageApi.getToken();
      if (token != null) {
        var res = await _client.get(
            Uri.parse(
              '$hostUrl/api/v1/auth/Notice/get-notice-by-id/$noticeId',
            ),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token': token,
            });

        final apiResponse = handleApiResponse(res);
        if (apiResponse.success) {
          final noticesJson = jsonDecode(res.body)['notice'];

          Notice notice = Notice.fromMap(
            noticesJson as Map<String, dynamic>,
          );
          return right(notice);
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
