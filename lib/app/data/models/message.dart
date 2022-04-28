import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

import '../services/firestore_service.dart';

class Message {
  Message(this.createdAt, this.sentBy, this.text);

  Message.fromJson(JsonMap map)
      : createdAt = (map['createdAt'] as Timestamp).toDate(),
        sentBy = map['sentBy'] as String,
        text = map['text'] as String;

  Message.fromChatMessage(ChatMessage m)
      : createdAt = m.createdAt,
        sentBy = m.user.id,
        text = m.text;

  final DateTime createdAt;
  final String text;
  final String sentBy;

  JsonMap toJson() {
    return {
      'createdAt': Timestamp.fromDate(createdAt),
      'sentBy': sentBy,
      'text': text,
    };
  }
}
