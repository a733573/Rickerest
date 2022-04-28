import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/core/utils/logger.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';
import 'package:rickerest/app/modules/home/views/widgets/avatar_image_dialog.dart';

import '../controllers/room_controller.dart';

class RoomView extends GetView<RoomController> {
  const RoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.room.name),
      ),
      body: StreamBuilder<QuerySnapshot>(
        initialData: FirestoreService.to.messagesCache[controller.room.id],
        stream: FirestoreService.to.messagesStream(controller.room.id),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            logger.warning('Snapshot has error.');
            return const SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          FirestoreService.to.messagesCache[controller.room.id] = snapshot.data;

          // final isFromCache = snapshot.data?.metadata.isFromCache;
          // if (isFromCache != null && !isFromCache) {
          //   logger.info('isFromCache=$isFromCache');
          // }

          final docs = snapshot.data?.docs;
          final chatMessages = docs?.map((doc) {
                final data = doc.data()! as JsonMap;
                final ChatUser user = controller.chatUsers.firstWhere(
                  (chatUser) => chatUser.id == data['sentBy'],
                );
                final DateTime createdAt =
                    (data['createdAt'] as Timestamp).toDate();
                final String text = data['text'] as String;
                return ChatMessage(
                  user: user,
                  createdAt: createdAt,
                  text: text,
                );
              }).toList() ??
              [];
          return DashChat(
            currentUser: controller.currentChatUser,
            onSend: controller.sendMessage,
            messages: chatMessages,
            inputOptions: const InputOptions(
              inputTextStyle: TextStyle(color: Colors.black),
            ),
            messageOptions: MessageOptions(
              onPressAvatar: (chatUser) => Get.to(
                () => AvatarImageDialog(chatUser.profileImage!),
                fullscreenDialog: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
