import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const ContactApp());
}

class ContactApp extends StatelessWidget {
  const new({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
    );
  }
}

