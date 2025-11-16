import 'package:flutter/material.dart';

import 'screens/inventory_screen.dart';
import 'screens/chat_categories_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/admin_panel_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/inventory': (context) => const InventoryScreen(),
  '/chatTopics': (context) => const ChatCategoriesScreen(),
  '/settings': (context) => const SettingsScreen(),
  '/admin': (context) => const AdminPanelScreen(),
};
