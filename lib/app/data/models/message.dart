import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class Message {
  Message(this._createdAt, this._sentBy, this._text);

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

  static Message fromMap(Map<String, dynamic> map) {
    return Message(
      (map['createdAt'] as Timestamp).toDate(),
      map['sentBy'] as String,
      map['text'] as String,
    );
  }

  static Message fromChatMessage(ChatMessage m) {
    return Message(m.createdAt, m.user.id, m.text);
  }
}
