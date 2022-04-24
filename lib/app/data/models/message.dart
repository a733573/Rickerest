import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class Message {
  Message(this._createdAt, this._sentBy, this._text);

  Message.fromMap(Map<String, dynamic> map)
      : _createdAt = (map['createdAt'] as Timestamp).toDate(),
        _sentBy = map['sentBy'] as String,
        _text = map['text'] as String;

  Message.fromChatMessage(ChatMessage m)
      : _createdAt = m.createdAt,
        _sentBy = m.user.id,
        _text = m.text;

  final DateTime _createdAt;
  final String _text;
  final String _sentBy;

  DateTime get createdAt => _createdAt;

  String get text => _text;

  String get sentBy => _sentBy;

  Map<String, dynamic> toMap() {
    return {
      'createdAt': Timestamp.fromDate(_createdAt),
      'sentBy': _sentBy,
      'text': _text
    };
  }
}
