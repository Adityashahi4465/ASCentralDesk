// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Notice {
  final String id;
  final String title; //
  final String category; //
  final DateTime postedAt;
  final DateTime expirationDate; //
  final DateTime startDate; //
  final String author; //
  final String content; //
  final List<String> targetCampuses; //
  final String priorityLevel; //
  final String status; //
  final String visibility; //
  final List<String> relatedNotices; //
  final List<String> tags; //
  final bool approvalStatus;
  final String authorContact;
  final DateTime lastModified;
  Notice({
    required this.id,
    required this.title,
    required this.category,
    required this.postedAt,
    required this.expirationDate,
    required this.startDate,
    required this.author,
    required this.content,
    required this.targetCampuses,
    required this.priorityLevel,
    required this.status,
    required this.visibility,
    required this.relatedNotices,
    required this.tags,
    required this.approvalStatus,
    required this.authorContact,
    required this.lastModified,
  });

  Notice copyWith({
    String? id,
    String? title,
    String? category,
    DateTime? postedAt,
    DateTime? expirationDate,
    DateTime? startDate,
    String? author,
    String? content,
    List<String>? targetCampuses,
    String? priorityLevel,
    String? status,
    String? visibility,
    List<String>? relatedNotices,
    List<String>? tags,
    bool? approvalStatus,
    String? authorContact,
    DateTime? lastModified,
  }) {
    return Notice(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      postedAt: postedAt ?? this.postedAt,
      expirationDate: expirationDate ?? this.expirationDate,
      startDate: startDate ?? this.startDate,
      author: author ?? this.author,
      content: content ?? this.content,
      targetCampuses: targetCampuses ?? this.targetCampuses,
      priorityLevel: priorityLevel ?? this.priorityLevel,
      status: status ?? this.status,
      visibility: visibility ?? this.visibility,
      relatedNotices: relatedNotices ?? this.relatedNotices,
      tags: tags ?? this.tags,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      authorContact: authorContact ?? this.authorContact,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'title': title,
      'category': category,
      'postedAt': postedAt.millisecondsSinceEpoch,
      'expirationDate': expirationDate.millisecondsSinceEpoch,
      'startDate': startDate.millisecondsSinceEpoch,
      'author': author,
      'content': content,
      'targetCampuses': targetCampuses,
      'priorityLevel': priorityLevel,
      'status': status,
      'visibility': visibility,
      'relatedNotices': relatedNotices,
      'tags': tags,
      'approvalStatus': approvalStatus,
      'authorContact': authorContact,
      'lastModified': lastModified.millisecondsSinceEpoch,
    };
  }

  factory Notice.fromMap(Map<String, dynamic> map) {
    return Notice(
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      postedAt: map['postedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['postedAt'],
            )
          : DateTime.now(),
      expirationDate: map['expirationDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['expirationDate'],
            )
          : DateTime.now(),
      startDate: map['startDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['startDate'],
            )
          : DateTime.now(),
      author: map['author'] ?? '',
      content: map['content'] ?? '',
      targetCampuses: map['targetCampuses'] != null
          ? List<String>.from(
              map['targetCampuses'],
            )
          : [],
      priorityLevel: map['priorityLevel'] ?? '',
      status: map['status'] ?? '',
      visibility: map['visibility'] ?? '',
      relatedNotices: map['relatedNotices'] != null
          ? List<String>.from(
              map['relatedNotices'],
            )
          : [],
      tags: map['tags'] != null
          ? List<String>.from(
              map['tags'],
            )
          : [],
      approvalStatus: map['approvalStatus'] ?? false,
      authorContact: map['authorContact'] ?? '',
      lastModified: map['lastModified'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['lastModified'],
            )
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Notice.fromJson(String source) =>
      Notice.fromMap(json.decode(source) as Map<String, dynamic>);
}
