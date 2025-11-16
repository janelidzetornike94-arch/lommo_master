import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'theme.dart';
import 'app_routes.dart';
import 'services/auth_guard.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LommoApp());
}

class LommoApp extends StatelessWidget {
  const LommoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOMMO',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme.copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      routes: appRoutes,
      home: const AuthGuard(
        child: HomeScreen(),
      ),
    );
  }
}
