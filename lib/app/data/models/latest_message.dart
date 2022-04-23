import 'package:cloud_firestore/cloud_firestore.dart';

class LatestMessage {
  LatestMessage(this._createdAt, this._text);

  final DateTime _createdAt;
  final String _text;

  DateTime get createdAt => _createdAt;

  String get text => _text;

  static LatestMessage fromMap(Map<String, dynamic> map) {
    return LatestMessage(
      (map['createdAt'] as Timestamp).toDate(),
      map['text'] as String,
    );
  }
}
