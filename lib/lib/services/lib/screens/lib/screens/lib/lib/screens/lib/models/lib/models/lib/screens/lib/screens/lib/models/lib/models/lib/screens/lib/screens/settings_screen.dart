import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: const [
          ListTile(
            title: Text("App Theme"),
            subtitle: Text("Light / Dark mode"),
          ),
          ListTile(
            title: Text("Account Settings"),
          ),
          ListTile(
            title: Text("About"),
            subtitle: Text("Version 1.0.0"),
          ),
        ],
      ),
    );
  }
}
