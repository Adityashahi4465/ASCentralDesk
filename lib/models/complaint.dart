// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class Complaint {
  final String id; // Assuming you have an identifier for the complaint
  final String title;
  final String description;
  final List<int> images; // Represented as a list of bytes
  final String category;
  final String consults;
  final DateTime filingTime;
  final int fund;
  final String status;
  final int upvotes;
  final String createdBy;
  Complaint({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.category,
    required this.consults,
    required this.filingTime,
    required this.fund,
    required this.status,
    required this.upvotes,
    required this.createdBy,
  });

  Complaint copyWith({
    String? id,
    String? title,
    String? description,
    List<int>? images,
    String? category,
    String? consults,
    DateTime? filingTime,
    int? fund,
    String? status,
    int? upvotes,
    String? createdBy,
  }) {
    return Complaint(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      category: category ?? this.category,
      consults: consults ?? this.consults,
      filingTime: filingTime ?? this.filingTime,
      fund: fund ?? this.fund,
      status: status ?? this.status,
      upvotes: upvotes ?? this.upvotes,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'title': title,
      'description': description,
      'images': images,
      'category': category,
      'consults': consults,
      'filingTime': filingTime.millisecondsSinceEpoch,
      'fund': fund,
      'status': status,
      'upvotes': upvotes,
      'createdBy': createdBy,
    };
  }

  factory Complaint.fromMap(Map<String, dynamic> map) {
    return Complaint(
      id: map['_id'] as String? ?? '', // Handle null case if _id is not present
      title: map['title'] as String,
      description: map['description'] as String,
      images: List<int>.from(map['images'] as List<int>),
      category: map['category'] as String,
      consults: map['consults'] as String,
      filingTime: DateTime.fromMillisecondsSinceEpoch(map['filingTime'] as int),
      fund: map['fund'] as int,
      status: map['status'] as String,
      upvotes: map['upvotes'] as int,
      createdBy: map['createdBy'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Complaint.fromJson(String source) =>
      Complaint.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Complaint(id: $id, title: $title, description: $description, images: $images, category: $category, consults: $consults, filingTime: $filingTime, fund: $fund, status: $status, upvotes: $upvotes, createdBy: $createdBy)';
  }

  @override
  bool operator ==(covariant Complaint other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        listEquals(other.images, images) &&
        other.category == category &&
        other.consults == consults &&
        other.filingTime == filingTime &&
        other.fund == fund &&
        other.status == status &&
        other.upvotes == upvotes &&
        other.createdBy == createdBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        images.hashCode ^
        category.hashCode ^
        consults.hashCode ^
        filingTime.hashCode ^
        fund.hashCode ^
        status.hashCode ^
        upvotes.hashCode ^
        createdBy.hashCode;
  }
}
