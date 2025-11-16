import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/date_formatter.dart';

class CommentAddScreen extends StatefulWidget {
  final String productId;

  const CommentAddScreen({super.key, required this.productId});

  @override
  State<CommentAddScreen> createState() => _CommentAddScreenState();
}

class _CommentAddScreenState extends State<CommentAddScreen> {
  final TextEditingController commentCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Add Comment")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: commentCtrl,
              decoration: const InputDecoration(hintText: "Write comment..."),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text("Send"),
              onPressed: () {
                final txt = commentCtrl.text.trim();
                if (txt.isEmpty) return;

                FirebaseFirestore.instance
                    .collection("products")
                    .doc(widget.productId)
                    .update({
                  "comments": FieldValue.arrayUnion([
                    "${user!.email} | ${DateFormatter.nowReadable()} → $txt"
                  ]),
                });

                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
