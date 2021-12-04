import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volver'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('hola mundo'),

            _Formulario()
          ],
        ),
      ),
    );
  }
}

class _Formulario extends StatelessWidget {
  const _Formulario({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Text('Inicio de sesion')
        ],
      ),
    );
  }
}