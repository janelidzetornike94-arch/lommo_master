import 'package:flutter/material.dart';

class CommentsListScreen extends StatelessWidget {
  final List<String> comments;

  const CommentsListScreen({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comments")),
      body: comments.isEmpty
          ? const Center(child: Text("No comments"))
          : ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, i) => ListTile(
                leading: const Icon(Icons.comment),
                title: Text(comments[i]),
              ),
            ),
    );
  }
}
