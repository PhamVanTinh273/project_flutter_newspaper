import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:page_login/auth/auth.dart';
import 'package:page_login/firebase_options.dart';
import 'package:page_login/theme/dark_mode.dart';
import 'package:page_login/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Khởi tạo Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
