import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resumeapp/firebase_options.dart';
import 'package:resumeapp/screen/loginpage.dart';
import 'package:resumeapp/screen/registerpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ResumeApp());
}   


class ResumeApp extends StatelessWidget {
  const ResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage(),
    debugShowCheckedModeBanner: false,
    );
  }
}