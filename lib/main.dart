import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/enlist_controller.dart';
import 'package:flutter_app/firebase_options.dart';
import 'package:flutter_app/views/main_view.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  EnlistController.fetchRawEnlists();
  runApp(const LetsEnlist());
}

class LetsEnlist extends StatelessWidget {
  const LetsEnlist({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lets Enlist',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(primary: Color(0xFF536349)),
      ),
      home: const MainView(),
    );
  }
}
