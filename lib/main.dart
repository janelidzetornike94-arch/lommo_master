import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';
import 'firebase_options.dart'; // auto-generated file

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
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blueAccent,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: AuthService().getStartPage(),
    );
  }
}
