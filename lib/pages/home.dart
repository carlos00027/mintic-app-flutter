import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('hola mundo'),
            TextButton(onPressed: ()=>Navigator.of(context).pushNamed('auth.login'), child: Text('Ir a login'))
          ],
        ),
      ),
    );
  }
}