import 'package:flutter/material.dart';

class RegistrarPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volver'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Text('Registrarme')
            ],
          ),
        ),
      ),
    );
  }
}