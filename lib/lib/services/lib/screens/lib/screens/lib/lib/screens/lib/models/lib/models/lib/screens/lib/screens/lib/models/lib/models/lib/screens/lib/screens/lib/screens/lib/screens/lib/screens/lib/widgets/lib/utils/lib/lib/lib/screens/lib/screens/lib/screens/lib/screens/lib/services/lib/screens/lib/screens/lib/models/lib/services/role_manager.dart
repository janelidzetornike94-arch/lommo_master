import 'package:cloud_firestore/cloud_firestore.dart';

class RoleManager {
  static Future<String> getUserRole(String uid) async {
    final doc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (!doc.exists) return "user";
    return doc["role"];
  }
}
