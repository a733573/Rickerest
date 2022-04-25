import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class Message {
  Message(this.createdAt, this.sentBy, this.text, this.readBy);

  Message.fromMap(Map<String, dynamic> map)
      : createdAt = (map['createdAt'] as Timestamp).toDate(),
        sentBy = map['sentBy'] as String,
        text = map['text'] as String,
        readBy =
            (map['readBy'] as List<dynamic>).map((e) => e.toString()).toList();

  Message.fromChatMessage(ChatMessage m)
      : createdAt = m.createdAt,
        sentBy = m.user.id,
        text = m.text,
        readBy = (m.customProperties?['readBy'] as List<dynamic>)
            .map((e) => e.toString())
            .toList();

  final DateTime createdAt;
  final String text;
  final String sentBy;
  final List<String> readBy;

  Map<String, dynamic> toMap() {
    return {
      'createdAt': Timestamp.fromDate(createdAt),
      'sentBy': sentBy,
      'text': text,
      'readBy': readBy,
    };
  }
}
