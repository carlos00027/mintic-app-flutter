import 'package:flutter/material.dart';
import 'package:mintic_app/pages/auth/auth.dart';
import 'package:mintic_app/pages/home.dart';

import 'package:provider/provider.dart';

import 'services/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mintic app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'auth.login': (_) => LoginPage(),
          'auth.registrar': (_) => RegistrarPage()
        },
        scaffoldMessengerKey: NotificationsService.messengerKey,
      ),
    );
  }
}
