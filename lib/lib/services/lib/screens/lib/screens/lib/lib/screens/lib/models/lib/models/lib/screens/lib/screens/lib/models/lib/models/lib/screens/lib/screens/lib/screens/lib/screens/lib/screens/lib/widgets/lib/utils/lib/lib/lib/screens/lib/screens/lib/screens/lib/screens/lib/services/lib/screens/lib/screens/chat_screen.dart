import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';
import '../utils/date_formatter.dart';

class ChatScreen extends StatefulWidget {
  final String topicId;
  final String title;

  const ChatScreen({super.key, required this.topicId, required this.title});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgCtrl = TextEditingController();
  final service = FirestoreService();
  final ScrollController scrollCtrl = ScrollController();

  void send() {
    if (msgCtrl.text.trim().isEmpty) return;
    final user = FirebaseAuth.instance.currentUser;

    service.sendMessage(
      widget.topicId,
      user!.email!,
      msgCtrl.text.trim(),
      DateFormatter.nowReadable(),
    );

    msgCtrl.clear();

    Future.delayed(const Duration(milliseconds: 300), () {
      scrollCtrl.jumpTo(scrollCtrl.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: service.messagesStream(widget.topicId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final msgs = snapshot.data!.docs;

                return ListView.builder(
                  controller: scrollCtrl,
                  itemCount: msgs.length,
                  itemBuilder: (context, i) {
                    final m = msgs[i];
                    return ListTile(
                      title: Text(m["user"]),
                      subtitle: Text(m["text"]),
                      trailing: Text(
                        m["time"],
                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.black12,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: msgCtrl,
                    decoration: const InputDecoration(hintText: "Write message..."),
                    onSubmitted: (_) => send(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: send,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
