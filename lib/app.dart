import 'package:flutter/material.dart';
import 'package:gradutionfinalv/screens/login_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loginscreen',
      home: Scaffold(body: LoginScreen()),
    );
  }
}
