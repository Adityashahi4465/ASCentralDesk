// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  final String uid; // Mongoose _id field
  final String token; // JWT token
  final String name; // Name field
  final String email; // Email field
  final String campus; // Campus field
  final String course;
  final String rollNo; // RollNo field
  final String section; // Section field
  final String role; // Role field
  final String semester; // Semester field
  final String photoUrl; // photoUrl field
  final String linkedInProfileUrl; // linkedInProfileUrl field
  final bool isAccountActive; // isAccountActive field
  final bool emailVerified; // isAccountActive field
  final List<String> bookmarkedComplaints; // bookmarkedComplaints field
  final List<String> bookmarkedEvents; // bookmarkedEvents field
  final List<String> bookmarkedNotifications; // bookmarkedNotifications field

  User({
    required this.uid,
    required this.token,
    required this.name,
    required this.email,
    required this.campus,
    required this.course,
    required this.rollNo,
    required this.section,
    required this.role,
    required this.semester,
    required this.photoUrl,
    required this.linkedInProfileUrl,
    required this.isAccountActive,
    required this.emailVerified,
    required this.bookmarkedComplaints,
    required this.bookmarkedEvents,
    required this.bookmarkedNotifications,
  });

  User copyWith({
    String? uid,
    String? token,
    String? name,
    String? email,
    String? campus,
    String? course,
    String? rollNo,
    String? section,
    String? role,
    String? semester,
    String? photoUrl,
    String? linkedInProfileUrl,
    bool? isAccountActive,
    bool? emailVerified,
    List<String>? bookmarkedComplaints,
    List<String>? bookmarkedEvents,
    List<String>? bookmarkedNotifications,
  }) {
    return User(
      uid: uid ?? this.uid,
      token: token ?? this.token,
      name: name ?? this.name,
      email: email ?? this.email,
      campus: campus ?? this.campus,
      course: course ?? this.course,
      rollNo: rollNo ?? this.rollNo,
      section: section ?? this.section,
      role: role ?? this.role,
      semester: semester ?? this.semester,
      photoUrl: photoUrl ?? this.photoUrl,
      linkedInProfileUrl: linkedInProfileUrl ?? this.linkedInProfileUrl,
      isAccountActive: isAccountActive ?? this.isAccountActive,
      emailVerified: emailVerified ?? this.emailVerified,
      bookmarkedComplaints: bookmarkedComplaints ?? this.bookmarkedComplaints,
      bookmarkedEvents: bookmarkedEvents ?? this.bookmarkedEvents,
      bookmarkedNotifications:
          bookmarkedNotifications ?? this.bookmarkedNotifications,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'token': token,
      'name': name,
      'email': email,
      'campus': campus,
      'course': course,
      'rollNo': rollNo,
      'section': section,
      'role': role,
      'semester': semester,
      'photoUrl': photoUrl,
      'linkedInProfileUrl': linkedInProfileUrl,
      'isAccountActive': isAccountActive,
      'emailVerified': emailVerified,
      'bookmarkedComplaints': bookmarkedComplaints,
      'bookmarkedEvents': bookmarkedEvents,
      'bookmarkedNotifications': bookmarkedNotifications,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['_id'] as String? ?? '',
      token: map['token'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      campus: map['campus'] as String? ?? '',
      course: map['course'] as String? ?? '',
      rollNo: map['rollNo'] as String? ?? '',
      section: map['section'] as String? ?? '',
      role: map['role'] as String? ?? '',
      semester: map['semester'] as String? ?? '',
      photoUrl: map['photoUrl'] as String? ?? '',
      linkedInProfileUrl: map['linkedInProfileUrl'] as String? ?? '',
      isAccountActive: map['isAccountActive'] as bool? ??
          false, // Provide a default value for bool.
      emailVerified: map['emailVerified'] as bool? ??
          false, // Provide a default value for bool.
      bookmarkedComplaints: (map['bookmarkedComplaints'] != null)
          ? List<String>.from(map['bookmarkedComplaints'])
          : [], // Handle the case when it's null.
      bookmarkedEvents: (map['bookmarkedEvents'] != null)
          ? List<String>.from(map['bookmarkedEvents'])
          : [], // Handle the case when it's null.
      bookmarkedNotifications: (map['bookmarkedNotifications'] != null)
          ? List<String>.from(map['bookmarkedNotifications'])
          : [], // Handle the case when it's null.
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, email: $email, campus: $campus, course: $course, rollNo: $rollNo, section: $section, role: $role, semester: $semester, photoUrl: $photoUrl, linkedInProfileUrl: $linkedInProfileUrl, isAccountActive: $isAccountActive, emailVerified: $emailVerified, bookmarkedComplaints: $bookmarkedComplaints, bookmarkedEvents: $bookmarkedEvents, bookmarkedNotifications: $bookmarkedNotifications)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.campus == campus &&
        other.course == course &&
        other.rollNo == rollNo &&
        other.section == section &&
        other.role == role &&
        other.semester == semester &&
        other.photoUrl == photoUrl &&
        other.linkedInProfileUrl == linkedInProfileUrl &&
        other.isAccountActive == isAccountActive &&
        other.emailVerified == emailVerified &&
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
        course.hashCode ^
        rollNo.hashCode ^
        section.hashCode ^
        role.hashCode ^
        semester.hashCode ^
        photoUrl.hashCode ^
        linkedInProfileUrl.hashCode ^
        isAccountActive.hashCode ^
        emailVerified.hashCode ^
        bookmarkedComplaints.hashCode ^
        bookmarkedEvents.hashCode ^
        bookmarkedNotifications.hashCode;
  }
}
