import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/chat_screen.dart';

class ChatCategoriesScreen extends StatelessWidget {
  const ChatCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Topics")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("chat_topics").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              final topic = data[i];

              return ListTile(
                title: Text(topic["title"]),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(topicId: topic.id, title: topic["title"]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
