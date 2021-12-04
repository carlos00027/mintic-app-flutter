import 'package:flutter/material.dart';
import 'package:mintic_app/pages/auth/auth.dart';
import 'package:mintic_app/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mintic app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage(),
        'auth.login': (_) => LoginPage()
      },
    );
  }
}
