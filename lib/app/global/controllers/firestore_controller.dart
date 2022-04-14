import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FirestoreController extends GetxController {
  static FirestoreController get to => Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addToFirestore({
    required String colId,
    required String docId,
    required Map<String, dynamic> data,
  }) {
    final docRef = firestore.collection(colId).doc(docId);
    return docRef
        .set(data)
        .then(
          (value) =>
              debugPrint('Added to firestore: colId="$colId", docId="$docId"'),
        )
        .catchError(
          (error) => debugPrint('Failed to add to firestore: $error'),
        );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getFromFirestore({
    required String colId,
    required String docID,
  }) {
    final docRef = firestore.collection(colId).doc(docID);
    return docRef.get();
  }

  Future<void> deleteFirestoreDoc({
    required String colId,
    required String docId,
  }) {
    final docRef = firestore.collection(colId).doc(docId);
    return docRef
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
}
