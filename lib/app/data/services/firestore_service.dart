import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/data/models/current_user.dart';
import 'package:rickerest/app/data/models/room.dart';
import 'package:rickerest/app/data/models/user.dart';
import 'package:rickerest/app/data/services/auth_service.dart';

import '../../core/utils/logger.dart';

class FirestoreService extends GetxService {
  static FirestoreService get to => Get.find();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> get currentUserStream =>
      db.collection('users').doc(AuthService.to.uid).snapshots();
  DocumentSnapshot? currentUserSnapshotCache;
  CurrentUser? currentUser;

  Query? get friendUsersQuery => currentUser!.friends.isEmpty
      ? null
      : db
          .collection('users')
          .where('uid', whereIn: currentUser!.friends)
          .orderBy('name');

  Stream<QuerySnapshot>? get friendUsersStream => friendUsersQuery?.snapshots();
  QuerySnapshot? friendUsersSnapshotCache;
  List<User> friendUsers = [];

  Query? get roomsQuery => currentUser!.rooms.isEmpty
      ? null
      : db
          .collection('rooms')
          .where('id', whereIn: currentUser!.rooms)
          .orderBy('latestMessage.createdAt', descending: true);

  Stream<QuerySnapshot>? get roomsStream => roomsQuery?.snapshots();
  QuerySnapshot? roomsCache;
  List<Room> rooms = [];

  Stream<QuerySnapshot> messagesStream(String roomId) {
    return db
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Map<String, QuerySnapshot?> messagesCache = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    // currentUserSnapshotCache = await db
    //     .collection('users')
    //     .doc(AuthService.to.uid)
    //     .get(const GetOptions(source: Source.cache));
    // currentUser =
    //     CurrentUser.fromMap(currentUserSnapshotCache!.data()! as JsonMap);
    // friendUsersSnapshotCache =
    //     await friendUsersQuery?.get(const GetOptions(source: Source.cache));
    // friendUsers = friendUsersSnapshotCache?.docs
    //         .map((doc) => User.fromMap(doc.data()! as JsonMap))
    //         .toList() ??
    //     [];
    // logger
    //   ..info(
    //     'currentUserSnapshotCache: isFromCache='
    //     '${currentUserSnapshotCache?.metadata.isFromCache}',
    //   )
    //   ..info(
    //     'friendUsersSnapshotCache: isFromCache='
    //     '${friendUsersSnapshotCache?.metadata.isFromCache}',
    //   );
  }

  Future<void> addDoc({
    required CollectionReference ref,
    required JsonMap data,
  }) {
    return ref
        .add(data)
        .then(
          (_) => logger.info(
            'Add a document to firestore: path="${ref.path}", data=$data',
          ),
        )
        .catchError(
          (error) =>
              logger.warning('Failed to Add a document to firestore: $error'),
        );
  }

  Future<void> setDoc({
    required String colId,
    required String docId,
    required JsonMap data,
  }) {
    return db
        .collection(colId)
        .doc(docId)
        .set(data)
        .then(
          (_) => logger.info(
            'Set a document to firestore: colId="$colId", docId="$docId", '
            'data=$data',
          ),
        )
        .catchError(
          (error) =>
              logger.warning('Failed to set a document to firestore: $error'),
        );
  }

  Future<void> updateDoc({
    required String colId,
    required String docId,
    required JsonMap data,
  }) {
    return db
        .collection(colId)
        .doc(docId)
        .update(data)
        .then(
          (_) => logger.info(
            'Updated a firestore document: colId="$colId", docId="$docId", '
            'data=$data',
          ),
        )
        .catchError(
          (error) =>
              logger.warning('Failed to update a firestore document: $error'),
        );
  }

  Future<void> batch(List<BatchCommand> batchCommands) {
    final batch = db.batch();
    for (final batchCommand in batchCommands) {
      switch (batchCommand.batchOperation) {
        case BatchOperation.set:
          batch.set(batchCommand.docRef, batchCommand.data);
          break;
        case BatchOperation.update:
          batch.update(batchCommand.docRef, batchCommand.data!);
          break;
        case BatchOperation.delete:
          batch.delete(batchCommand.docRef);
          break;
      }
    }
    return batch.commit().then((_) => logger.info('Ran a batch.')).catchError(
          (error) => logger.warning('Failed to run a batch: $error'),
        );
  }

  Future<DocumentSnapshot<JsonMap>> getDocByDocId({
    required String colId,
    required String docId,
  }) {
    return db.collection(colId).doc(docId).get().then(
      (value) {
        logger.info(
          'Got a firestore document: colId="$colId", docId="$docId"',
        );
        return value;
      },
    ).catchError(
      (error) {
        logger.warning('Failed to get a firestore document: $error');
      },
    );
  }

  Future<List<QueryDocumentSnapshot<JsonMap>>> getDocsByField({
    required String colId,
    required String key,
    required dynamic val,
  }) {
    return db.collection(colId).where(key, isEqualTo: val).get().then(
      (value) {
        logger.info(
          'Got firestore documents: colId="$colId", where="$key=$val", '
          'length=${value.docs.length}',
        );
        return value.docs;
      },
    ).catchError(
      (error) {
        logger.warning('Failed to get firestore documents: $error');
        return (val as QuerySnapshot<JsonMap>).docs;
      },
    );
  }

  Future<void> deleteDoc({
    required String colId,
    required String docId,
  }) {
    return db
        .collection(colId)
        .doc(docId)
        .delete()
        .then(
          (_) => logger.info(
            'Deleted a firestore document: colId="$colId", docId="$docId"',
          ),
        )
        .catchError(
          (error) =>
              logger.warning('Failed to delete a firestore document: $error'),
        );
  }

  Future<QueryDocumentSnapshot<JsonMap>?> findAccountByEmail(
    String email,
  ) {
    return getDocsByField(colId: 'users', key: 'email', val: email)
        .then((value) => value.isNotEmpty ? value[0] : null);
  }
}

class BatchCommand {
  BatchCommand({
    required this.docRef,
    required this.batchOperation,
    this.data,
  })  : assert(
          !((batchOperation == BatchOperation.update ||
                  batchOperation == BatchOperation.set) &&
              data == null),
        ),
        assert(!(batchOperation == BatchOperation.delete && data != null));

  final DocumentReference docRef;
  final BatchOperation batchOperation;
  JsonMap? data;
}

enum BatchOperation {
  set,
  update,
  delete,
}

typedef JsonMap = Map<String, dynamic>;
