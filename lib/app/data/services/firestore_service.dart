import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/data/models/current_user_model.dart';

import '../../core/utils/logger.dart';
import 'auth_service.dart';

class FirestoreService extends GetxService {
  static FirestoreService get to => Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> get currentUserStream =>
      firestore.collection('users').doc(AuthService.to.uid).snapshots();

  DocumentSnapshot? currentUserDocumentCache;

  CurrentUserModel? currentUserModel;

  Future<void> setDoc({
    required String colId,
    required String docId,
    required Map<String, dynamic> data,
  }) {
    return firestore
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
    required Map<String, dynamic> data,
  }) {
    return firestore
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

  Future<void> batchUpdate({
    required String colId,
    required List<MapEntry<String, Map<String, dynamic>>> data,
  }) {
    final batch = firestore.batch();
    for (final entry in data) {
      batch.update(firestore.collection(colId).doc(entry.key), entry.value);
    }
    return batch
        .commit()
        .then(
          (_) => logger.info(
            'Batch Updated: colId="$colId", length="${data.length}"',
          ),
        )
        .catchError(
          (error) => logger.warning('Failed to batch update: $error'),
        );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocByDocId({
    required String colId,
    required String docId,
  }) {
    return firestore.collection(colId).doc(docId).get().then(
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

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getDocsByField({
    required String colId,
    required String key,
    required dynamic val,
  }) {
    return firestore.collection(colId).where(key, isEqualTo: val).get().then(
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
        return (val as QuerySnapshot<Map<String, dynamic>>).docs;
      },
    );
  }

  Future<void> deleteDoc({
    required String colId,
    required String docId,
  }) {
    return firestore
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

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> findAccountByEmail(
    String email,
  ) {
    return getDocsByField(colId: 'users', key: 'email', val: email)
        .then((value) => value.isNotEmpty ? value[0] : null);
  }
}
