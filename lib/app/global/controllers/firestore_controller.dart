import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FirestoreController extends GetxController {
  static FirestoreController get to => Get.find();

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
          (value) => debugPrint(
            'set to firestore: colId="$colId", docId="$docId", data=$data',
          ),
        )
        .catchError(
          (error) => debugPrint('Failed to set to firestore: $error'),
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
          (value) => debugPrint(
            'updated firestore: colId="$colId", docId="$docId", data=$data',
          ),
        )
        .catchError(
          (error) => debugPrint('Failed to update firestore: $error'),
        );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocByDocId({
    required String colId,
    required String docId,
  }) {
    return firestore.collection(colId).doc(docId).get();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getDocsByField({
    required String colId,
    required String key,
    required dynamic value,
  }) async {
    final querySnapshot =
        await firestore.collection(colId).where(key, isEqualTo: value).get();
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
          (value) => debugPrint(
            'Deleted firestore document: colId="$colId", docId="$docId"',
          ),
        )
        .catchError(
          (error) => debugPrint('Failed to delete firestore document: $error'),
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
