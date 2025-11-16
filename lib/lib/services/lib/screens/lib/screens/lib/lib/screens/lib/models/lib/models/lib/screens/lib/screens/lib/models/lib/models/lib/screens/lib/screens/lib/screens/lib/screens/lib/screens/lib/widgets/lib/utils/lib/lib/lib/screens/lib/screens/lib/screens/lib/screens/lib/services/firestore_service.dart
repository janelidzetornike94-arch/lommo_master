import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> productsStream() {
    return _db.collection("products").snapshots();
  }

  Stream<QuerySnapshot> categoriesStream() {
    return _db.collection("categories").snapshots();
  }

  Stream<QuerySnapshot> chatTopicsStream() {
    return _db.collection("chat_topics").snapshots();
  }

  Stream<QuerySnapshot> messagesStream(String topicId) {
    return _db
        .collection("chat_topics")
        .doc(topicId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future<void> sendMessage(String topicId, String user, String text, String time) async {
    await _db
        .collection("chat_topics")
        .doc(topicId)
        .collection("messages")
        .add({
      "user": user,
      "text": text,
      "time": time,
    });
  }
}
