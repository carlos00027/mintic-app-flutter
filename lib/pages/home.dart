import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mintic_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _Drawer(),
      appBar: AppBar(
        title: Text('MinTic App'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido a nuestro aplicativo'),
          ],
        ),
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authService = Provider.of<AuthService>(context);
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu Principal',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: const Text('Pedidos'),
            leading: Icon(Icons.format_list_bulleted_outlined),
            onTap: () {
              Navigator.of(context).pushNamed('pedidos.listar');
            },
          ),
          /*ListTile(
            title: const Text('Nuevo pedido'),
            leading: Icon(Icons.add),
            onTap: () {
              Navigator.of(context).pushNamed('pedidos.form');
            },
          ),*/
          ListTile(
            title: const Text('Buscar pedido con Qr'),
            leading: Icon(Icons.qr_code_scanner_outlined),
            onTap: () {
              Navigator.of(context).pushNamed('pedidos.scan');
            },
          ),
          Divider(),
          ListTile(
            title: const Text('Cerrar sesion'),
           leading: Icon(Icons.logout_outlined),
            onTap: () {
              _authService.logout();
              Navigator.of(context).pushReplacementNamed('auth.login');
            },
          ),
        ],
      ),
    );
  }
}
