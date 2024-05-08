import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

import '../constants/app_constant.dart';
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
  FutureEither updateEvent({
    required Event event,
  });
  FutureEither<List<Event>> getAllEvents();
  // FutureEither<List<Event>> getBookmarkedEvents({required String uid});
  FutureEither<Event> getEventById({required String eventId});
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

  @override
  FutureEither updateEvent({
    required Event event,
  }) async {
    try {
      String? token = await _localStorageApi.getToken();

      final encodedJson = event.toJson();
      print('Encoded JSON: $encodedJson');
      final response = await _client.put(
        Uri.parse('$hostUrl/api/v1/auth/event/update-event/${event.id}'),
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
  FutureEither<List<Event>> getAllEvents() async {
    try {
      String? token = await _localStorageApi.getToken();
      if (token != null) {
        var res = await _client.get(
            Uri.parse('$hostUrl/api/v1/auth/event/get-all-events'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token': token,
            });

        final apiResponse = handleApiResponse(res);
        if (apiResponse.success) {
          final eventsJson = jsonDecode(res.body)['events'];
          print('  eventjsongsjjjjjjjjj  $eventsJson\n');

          List<Event> events = [];

          for (var eventMap in eventsJson) {
            try {
              Event event = Event.fromMap(eventMap as Map<String, dynamic>);
              events.add(event);
            } catch (e) {
              print('Error processing EventMap: $e');
            }
          }
          return right(events);
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
  FutureEither<Event> getEventById({required String eventId}) async {
    try {
      String? token = await _localStorageApi.getToken();
      if (token != null) {
        var res = await _client.get(
            Uri.parse(
              '$hostUrl/api/v1/auth/event/get-event-by-id/$eventId',
            ),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'token': token,
            });

        final apiResponse = handleApiResponse(res);
        print("eventtttttttt errror :  ${apiResponse.error}");
        if (apiResponse.success) {
          final eventJson = jsonDecode(res.body)['event'];
          print("eventtttttttt json :  ${eventJson}");

          Event event = Event.fromMap(
            eventJson as Map<String, dynamic>,
          );

          return right(event);
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
