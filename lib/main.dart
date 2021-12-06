import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mintic_app/pages/auth/auth.dart';
import 'package:mintic_app/pages/home.dart';
import 'package:mintic_app/pages/pedidos/pedidos.dart';
import 'package:mintic_app/services/pedidos_service.dart';
import 'package:provider/provider.dart';
import 'services/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => PedidosService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mintic app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'auth.check',
        routes: {
          'home': (_) => HomePage(),
          'auth.check': (_) => CheckPage(),
          'auth.login': (_) => LoginPage(),
          'auth.registrar': (_) => RegistrarPage(),
          'pedidos.listar': (_) => PedidosListarPage(),
          'pedidos.form': (_) => PedidosFormPage(),
          'pedidos.ver': (_) => PedidosVerPage(),
        },
        scaffoldMessengerKey: NotificationsService.messengerKey,
      ),
    );
  }
}
