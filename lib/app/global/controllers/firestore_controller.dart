import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirestoreController extends GetxController {
  static FirestoreController get to => Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addToFirestore({
    required String colId,
    required String docID,
    required Map<String, dynamic> data,
  }) {
    final docRef = firestore.collection(colId).doc(docID);
    return docRef.set(data);
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
    required String docID,
  }) {
    final docRef = firestore.collection(colId).doc(docID);
    return docRef.delete();
  }
}
