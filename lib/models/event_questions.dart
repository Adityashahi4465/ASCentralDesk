// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EventQuestion {
  final String eventId;
  final String userId;
  final String question;
  final DateTime askedAt;
  String? answer;
  EventQuestion({
    required this.eventId,
    required this.userId,
    required this.question,
    required this.askedAt,
    this.answer,
  });

  EventQuestion copyWith({
    String? eventId,
    String? userId,
    String? question,
    DateTime? askedAt,
    bool? isAnswered,
    String? answer,
  }) {
    return EventQuestion(
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      question: question ?? this.question,
      askedAt: askedAt ?? this.askedAt,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventId': eventId,
      'userId': userId,
      'question': question,
      'askedAt': askedAt.millisecondsSinceEpoch,
      'answer': answer,
    };
  }

  factory EventQuestion.fromMap(Map<String, dynamic> map) {
    return EventQuestion(
      eventId: map['eventId'] as String,
      userId: map['userId'] as String,
      question: map['question'] as String,
      askedAt: DateTime.fromMillisecondsSinceEpoch(map['askedAt'] as int),
      answer: map['answer'] != null ? map['answer'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EventQuestion.fromJson(String source) =>
      EventQuestion.fromMap(json.decode(source) as Map<String, dynamic>);
}
