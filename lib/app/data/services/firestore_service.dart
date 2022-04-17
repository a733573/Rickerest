import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FirestoreService extends GetxService {
  static FirestoreService get to => Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
          (_) => debugPrint(
            'Set a document to firestore: colId=$colId, docId=$docId, '
            'data=$data',
          ),
        )
        .catchError(
          (error) =>
              debugPrint('Failed to set a document to firestore: $error'),
        );
  }

  Future<void> updateDoc({
    required String colId,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    return firestore
        .collection(colId)
        .doc(docId)
        .update(data)
        .then(
          (_) => debugPrint(
            'Updated a firestore document: colId=$colId, docId=$docId, '
            'data=$data',
          ),
        )
        .catchError(
          (error) =>
              debugPrint('Failed to update a firestore document: $error'),
        );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocByDocId({
    required String colId,
    required String docId,
  }) async {
    final doc = firestore.collection(colId).doc(docId).get();
    await doc
        .then(
          (_) => debugPrint(
            'Got a firestore document: colId=$colId, docId=$docId',
          ),
        )
        .catchError(
          (error) => debugPrint('Failed to get a firestore document: $error'),
        );
    return doc;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getDocsByField({
    required String colId,
    required String key,
    required dynamic value,
  }) async {
    final querySnapshot =
        await firestore.collection(colId).where(key, isEqualTo: value).get();
    if (querySnapshot.docs.isNotEmpty) {
      debugPrint(
        'Got firestore documents: colId=$colId, where="$key=$value", '
        'length=${querySnapshot.docs.length}',
      );
    }
    return querySnapshot.docs;
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
          (_) => debugPrint(
            'Deleted a firestore document: colId=$colId, docId=$docId',
          ),
        )
        .catchError(
          (error) =>
              debugPrint('Failed to delete a firestore document: $error'),
        );
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>?> findAccountByEmail(
    String email,
  ) async {
    final docs =
        await getDocsByField(colId: 'users', key: 'email', value: email);
    return docs.isNotEmpty ? docs[0] : null;
  }
}
