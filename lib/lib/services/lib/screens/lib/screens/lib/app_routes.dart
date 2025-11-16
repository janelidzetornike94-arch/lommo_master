import 'package:flutter/material.dart';
import 'screens/inventory_screen.dart';
import 'screens/chat_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  "/inventory": (context) => const InventoryScreen(),
  "/chat": (context) => const ChatScreen(),
};
