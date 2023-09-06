// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Student {
  final String uid;
  final String name;
  final String email;
  final String campus;
  final String rollNo;
  final String section;
  final String role;
  final String semester;
  final String photoUrl;
  final String linkedInProfileUrl;
  final bool isAccountActive;
  final List<String> bookmarkedComplaints;
  final List<String> bookmarkedEvents;
  final List<String> bookmarkedNotifications;
  Student({
    required this.uid,
    required this.name,
    required this.email,
    required this.campus,
    required this.rollNo,
    required this.section,
    required this.role,
    required this.semester,
    required this.photoUrl,
    required this.linkedInProfileUrl,
    required this.isAccountActive,
    required this.bookmarkedComplaints,
    required this.bookmarkedEvents,
    required this.bookmarkedNotifications,
  });

  Student copyWith({
    String? uid,
    String? name,
    String? email,
    String? campus,
    String? rollNo,
    String? section,
    String? role,
    String? semester,
    String? photoUrl,
    String? linkedInProfileUrl,
    bool? isAccountActive,
    List<String>? bookmarkedComplaints,
    List<String>? bookmarkedEvents,
    List<String>? bookmarkedNotifications,
  }) {
    return Student(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      campus: campus ?? this.campus,
      rollNo: rollNo ?? this.rollNo,
      section: section ?? this.section,
      role: role ?? this.role,
      semester: semester ?? this.semester,
      photoUrl: photoUrl ?? this.photoUrl,
      linkedInProfileUrl: linkedInProfileUrl ?? this.linkedInProfileUrl,
      isAccountActive: isAccountActive ?? this.isAccountActive,
      bookmarkedComplaints: bookmarkedComplaints ?? this.bookmarkedComplaints,
      bookmarkedEvents: bookmarkedEvents ?? this.bookmarkedEvents,
      bookmarkedNotifications:
          bookmarkedNotifications ?? this.bookmarkedNotifications,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'campus': campus,
      'rollNo': rollNo,
      'section': section,
      'role': role,
      'semester': semester,
      'photoUrl': photoUrl,
      'linkedInProfileUrl': linkedInProfileUrl,
      'isAccountActive': isAccountActive,
      'bookmarkedComplaints': bookmarkedComplaints,
      'bookmarkedEvents': bookmarkedEvents,
      'bookmarkedNotifications': bookmarkedNotifications,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      campus: map['campus'] as String,
      rollNo: map['rollNo'] as String,
      section: map['section'] as String,
      role: map['role'] as String,
      semester: map['semester'] as String,
      photoUrl: map['photoUrl'] as String,
      linkedInProfileUrl: map['linkedInProfileUrl'] as String,
      isAccountActive: map['isAccountActive'] as bool,
      bookmarkedComplaints: List<String>.from(
        (map['bookmarkedComplaints'] as List<String>),
      ),
      bookmarkedEvents: List<String>.from(
        (map['bookmarkedEvents'] as List<String>),
      ),
      bookmarkedNotifications: List<String>.from(
        (map['bookmarkedNotifications'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(uid: $uid, name: $name, email: $email, campus: $campus, rollNo: $rollNo, section: $section, role: $role, semester: $semester, photoUrl: $photoUrl, linkedInProfileUrl: $linkedInProfileUrl, isAccountActive: $isAccountActive, bookmarkedComplaints: $bookmarkedComplaints, bookmarkedEvents: $bookmarkedEvents, bookmarkedNotifications: $bookmarkedNotifications)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.campus == campus &&
        other.rollNo == rollNo &&
        other.section == section &&
        other.role == role &&
        other.semester == semester &&
        other.photoUrl == photoUrl &&
        other.linkedInProfileUrl == linkedInProfileUrl &&
        other.isAccountActive == isAccountActive &&
        listEquals(other.bookmarkedComplaints, bookmarkedComplaints) &&
        listEquals(other.bookmarkedEvents, bookmarkedEvents) &&
        listEquals(other.bookmarkedNotifications, bookmarkedNotifications);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        campus.hashCode ^
        rollNo.hashCode ^
        section.hashCode ^
        role.hashCode ^
        semester.hashCode ^
        photoUrl.hashCode ^
        linkedInProfileUrl.hashCode ^
        isAccountActive.hashCode ^
        bookmarkedComplaints.hashCode ^
        bookmarkedEvents.hashCode ^
        bookmarkedNotifications.hashCode;
  }
}
