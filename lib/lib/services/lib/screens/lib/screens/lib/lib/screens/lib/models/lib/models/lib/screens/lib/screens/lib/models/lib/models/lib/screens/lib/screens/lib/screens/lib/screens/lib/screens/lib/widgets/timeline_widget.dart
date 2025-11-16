import 'package:flutter/material.dart';

class TimelineWidget extends StatelessWidget {
  final List<String> updates;

  const TimelineWidget({super.key, required this.updates});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: updates.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: const Icon(Icons.access_time),
          title: Text(updates[i]),
        );
      },
    );
  }
}
