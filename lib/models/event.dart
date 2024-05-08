import 'dart:convert';


class Event {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String campus;
  final String criteria;
  final int prize;
  final DateTime postedAt;
  final String venueType;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> tags;

  final int capacity;
  final List<String> eventImages;
  final String organizerInfo;
  final List<String> attendees;
  final String registrationLink;
  final String contactInfo;
  final String eventType;
  final String location;
  final List<double> feedback;
  final List<String> admins;
  final String createdBy;

  Event(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.description,
      required this.campus,
      required this.criteria,
      required this.prize,
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
      required this.admins,
      required this.createdBy});

  Event copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? description,
    String? campus,
    String? criteria,
    DateTime? postedAt,
    String? venueType,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? tags,
    int? capacity,
    int? prize,
    List<String>? eventImages,
    String? organizerInfo,
    List<String>? attendees,
    String? registrationLink,
    String? contactInfo,
    String? eventType,
    String? location,
    List<double>? feedback,
    List<String>? admins,
    String? createdBy,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      campus: campus ?? this.campus,
      criteria: criteria ?? this.criteria,
      postedAt: postedAt ?? this.postedAt,
      venueType: venueType ?? this.venueType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      tags: tags ?? this.tags,
      capacity: capacity ?? this.capacity,
      prize: prize ?? this.prize,
      eventImages: eventImages ?? this.eventImages,
      organizerInfo: organizerInfo ?? this.organizerInfo,
      attendees: attendees ?? this.attendees,
      registrationLink: registrationLink ?? this.registrationLink,
      contactInfo: contactInfo ?? this.contactInfo,
      eventType: eventType ?? this.eventType,
      location: location ?? this.location,
      feedback: feedback ?? this.feedback,
      admins: admins ?? this.admins,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'campus': campus,
      'criteria': criteria,
      'postedAt': postedAt.millisecondsSinceEpoch,
      'venueType': venueType,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'tags': tags,
      'capacity': capacity,
      'prize': prize,
      'eventImages': eventImages,
      'organizerInfo': organizerInfo,
      'attendees': attendees,
      'registrationLink': registrationLink,
      'contactInfo': contactInfo,
      'eventType': eventType,
      'location': location,
      'feedback': feedback,
      'createdBy': createdBy,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['_id'] as String,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      description: map['description'] as String,
      campus: map['campus'] as String,
      criteria: map['criteria'] as String,
      postedAt: DateTime.parse(map['postedAt'] as String),
      venueType: map['venueType'] as String,
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: DateTime.parse(map['endDate'] as String),
      tags: List<String>.from((map['tags'])),
      capacity: map['capacity'] as int,
      prize: map['prize'] as int,
      eventImages: List<String>.from((map['eventImages'])),
      organizerInfo: map['organizerInfo'] as String,
      attendees: List<String>.from((map['attendees'])),
      registrationLink: map['registrationLink'] as String,
      contactInfo: map['contactInfo'] as String,
      eventType: map['eventType'] as String,
      location: map['location'] as String,
      createdBy: map['createdBy'] as String,
      feedback: List<double>.from((map['feedback'])),
      admins: List<String>.from((map['admins'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);
}
