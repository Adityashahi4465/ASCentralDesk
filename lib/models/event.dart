// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:as_central_desk/models/event_questions.dart';

class Event {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String campus;
  final DateTime postedAt;
  final String venueType;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> tags;

  // Additional fields (customize based on your needs)
  final int capacity;
  final List<String> eventImages;
  final String organizerInfo;
  final List<String> attendees;
  final String registrationLink;
  final String contactInfo;
  final String eventType;
  final String location;
  final List<double> feedback;
  Event({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.campus,
    required this.postedAt,
    required this.venueType,
    required this.startDate,
    required this.endDate,
    required this.tags,
    required this.capacity,
    required this.eventImages,
    required this.organizerInfo,
    required this.attendees,
    required this.registrationLink,
    required this.contactInfo,
    required this.eventType,
    required this.location,
    required this.feedback,
  });

  Event copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? description,
    String? campus,
    DateTime? postedAt,
    String? venueType,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? tags,
    int? capacity,
    List<String>? eventImages,
    String? organizerInfo,
    List<String>? attendees,
    String? registrationLink,
    String? contactInfo,
    String? eventType,
    String? location,
    List<double>? feedback,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      campus: campus ?? this.campus,
      postedAt: postedAt ?? this.postedAt,
      venueType: venueType ?? this.venueType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      tags: tags ?? this.tags,
      capacity: capacity ?? this.capacity,
      eventImages: eventImages ?? this.eventImages,
      organizerInfo: organizerInfo ?? this.organizerInfo,
      attendees: attendees ?? this.attendees,
      registrationLink: registrationLink ?? this.registrationLink,
      contactInfo: contactInfo ?? this.contactInfo,
      eventType: eventType ?? this.eventType,
      location: location ?? this.location,
      feedback: feedback ?? this.feedback,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'campus': campus,
      'postedAt': postedAt.millisecondsSinceEpoch,
      'venueType': venueType,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'tags': tags,
      'capacity': capacity,
      'eventImages': eventImages,
      'organizerInfo': organizerInfo,
      'attendees': attendees,
      'registrationLink': registrationLink,
      'contactInfo': contactInfo,
      'eventType': eventType,
      'location': location,
      'feedback': feedback,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      description: map['description'] as String,
      campus: map['campus'] as String,
      postedAt: DateTime.parse(map['postedAt'] as String),
      venueType: map['venueType'] as String,
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: DateTime.parse(map['endDate'] as String),
      tags: List<String>.from((map['tags'] as List<String>)),
      capacity: map['capacity'] as int,
      eventImages: List<String>.from((map['eventImages'] as List<String>)),
      organizerInfo: map['organizerInfo'] as String,
      attendees: List<String>.from((map['attendees'] as List<String>)),
      registrationLink: map['registrationLink'] as String,
      contactInfo: map['contactInfo'] as String,
      eventType: map['eventType'] as String,
      location: map['location'] as String,
      feedback: List<double>.from((map['feedback'] as List<int>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);
}
