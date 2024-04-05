import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._privateConstructor();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get firestore => _firestore;
  static final instance = FirestoreService._privateConstructor();

  Future<void> writeData(String path, Map<String, dynamic> data) async {
    try {
      await _firestore.doc(path).set(data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> readData(String node) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(node).get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<void> deleteData(String node, String docId) async {
    try {
      await _firestore.collection(node).doc(docId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
