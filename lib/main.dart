import 'package:final_project/screens/welcome_screen.dart';
import 'package:final_project/screens/movie_selection_screen.dart';
import 'package:final_project/utils/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppState(),
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: const WelcomeScreen(),
      routes: {
        '/movieSelection': (context) => MovieSelectionScreen(),
      },
    );
  }
}
