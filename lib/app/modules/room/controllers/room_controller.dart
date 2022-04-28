import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/data/models/message.dart';
import 'package:rickerest/app/data/models/room.dart';
import 'package:rickerest/app/data/services/auth_service.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

class RoomController extends GetxController {
  RoomController get to => Get.find();

  final currentChatUser = FirestoreService.to.currentUser!.toChatUser();

  final friendChatUsers = <ChatUser>[];

  final Room room = Get.arguments as Room;

  List<ChatUser> get chatUsers => [currentChatUser, ...friendChatUsers];

  Future<void> sendMessage(ChatMessage m) async {
    final batchCommands = <BatchCommand>[
      _updateLatestMessageBatchCommand(Message.fromChatMessage(m)),
      _addMessageBatchCommand(Message.fromChatMessage(m))
    ]
        // if (room.isNew) {
        //   batchCommands
        //       .addAll(_createRoomBatchCommands(Message.fromChatMessage(m)));
        // } else {
        //
        // }

        ;
    return FirestoreService.to.batch(batchCommands);
  }

  BatchCommand _addMessageBatchCommand(Message message) {
    return BatchCommand(
      docRef: room.ref.collection('messages').doc(),
      batchOperation: BatchOperation.set,
      data: message.toJson(),
    );
  }

  BatchCommand _updateLatestMessageBatchCommand(Message latestMessage) {
    return BatchCommand(
      docRef: room.ref,
      batchOperation: BatchOperation.update,
      data: {'latestMessage': latestMessage.toJson()},
    );
  }

  // List<BatchCommand> _createRoomBatchCommands(Message latestMessage) {
  //   room.latestMessage = latestMessage;
  //   return <BatchCommand>[
  //     BatchCommand(
  //       docRef: room.ref,
  //       batchOperation: BatchOperation.set,
  //       data: room.toJson(),
  //     ),
  //     ...chatUsers.map(
  //       (chatUser) => BatchCommand(
  //         docRef: chatUser.customProperties!['ref'] as DocumentReference,
  //         batchOperation: BatchOperation.update,
  //         data: {
  //           'rooms': FieldValue.arrayUnion([room.id])
  //         },
  //       ),
  //     )
  //   ];
  // }

  @override
  void onInit() {
    super.onInit();
    for (final friendUid
        in room.members.where((uid) => uid != AuthService.to.uid!)) {
      final friendChatUser = FirestoreService.to.friendUsers
          .firstWhere((friendUser) => friendUser.uid == friendUid)
          .toChatUser();
      friendChatUsers.add(friendChatUser);
    }
  }
}
