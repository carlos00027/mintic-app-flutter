import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mintic_app/providers/auth_login_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        //color: Colors.red[200],
        width: double.infinity ,
        height: _media.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ChangeNotifierProvider(
                create: (_) => AuthLoginProvider(),
                child: _Formulario(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Formulario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formProvider = Provider.of<AuthLoginProvider>(context);
    final _media = MediaQuery.of(context).size;
    return Container(
      // color: Colors.blue[300],
      height: _media.height,
      padding: EdgeInsets.all(8),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Inicio de sesion',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 15),
            TextFormField(
              onChanged: (value) => _formProvider.correo = value,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Correo electronico',
                hintText: 'Ej. correo@electronico.com',
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              onChanged: (value) => _formProvider.clave = value,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Clave',
                hintText: '******',
              ),
            ),
            SizedBox(height: 15),
            Material(
              child: MaterialButton(
                minWidth: double.infinity,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  print(_formProvider.correo);
                  print(_formProvider.clave);
                },
                child: Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
