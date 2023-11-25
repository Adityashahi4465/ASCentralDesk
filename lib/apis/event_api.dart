import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import '../core/api_config.dart';
import '../core/failure.dart';
import '../core/providers.dart';
import '../core/type_defs.dart';
import '../core/utils/error_hendling.dart';
import '../models/event.dart';
import 'local_storage_api.dart';

final eventApiProvider = Provider<EventAPI>((ref) {
  return EventAPI(
      client: ref.watch(clientProvider),
      localStorageApi: ref.watch(localStorageApiProvider));
});

abstract class IEventAPI {
  FutureVoid saveEventToDatabase({
    required Event event,
  });
  // FutureEither updateEvent({
  //   required Event Event,
  // });
  // FutureEither<List<Event>> getAllEvents();
  // FutureEither<List<Event>> getBookmarkedEvents({required String uid});
  // FutureEither<Event> getEventById({required String EventId});
}

class EventAPI implements IEventAPI {
  final Client _client;
  final LocalStorageApi _localStorageApi;
  EventAPI({required Client client, required LocalStorageApi localStorageApi})
      : _client = client,
        _localStorageApi = localStorageApi;

  @override
  FutureEither saveEventToDatabase({
    required Event event,
  }) async {
    try {
      String? token = await _localStorageApi.getToken();

      final encodedJson = event.toJson();
      final response = await _client.post(
        Uri.parse('$hostUrl/api/v1/auth/event/add-new-event'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!,
        },
        body: event.toJson(),
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
}
