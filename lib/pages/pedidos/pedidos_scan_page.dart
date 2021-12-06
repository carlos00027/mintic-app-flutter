import 'package:flutter/material.dart';

class PedidosScanPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar Pedido QR'),
      ),
      body: Container(
        child: TextButton(
          onPressed: (){
            print('hola');
          },
          child: Center(child: Text('Abrir Camara')),
        ),
      ),
    );
  }
}