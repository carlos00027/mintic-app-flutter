import 'package:flutter/material.dart';
import 'package:mintic_app/providers/auth_registrar_provider.dart';
import 'package:provider/provider.dart';

class RegistrarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volver'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: ChangeNotifierProvider(
              create: (BuildContext context) => AuthRegistrarProvider(),
              child: _MiForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class _MiForm extends StatelessWidget {
  const _MiForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Form(
        child: Column(
          children: [
            SizedBox(height: 15),
            Row(
              children: [
                Text(
                  'Formulario de ',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  'registro',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
            SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(label: Text('Correo electronico')),
            ),
            SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(label: Text('Clave')),
              obscureText: true,
            ),
            SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(label: Text('Confirmar clave')),
              obscureText: true,
            ),
            SizedBox(height: 15),
            MaterialButton(
              minWidth: double.infinity,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                FocusScope.of(context).unfocus();
              },
              child: Text('Registrarme',style: TextStyle(color: Colors.white)),
            ),

            MaterialButton(
              minWidth: double.infinity,
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Volver',style: TextStyle(color: Theme.of(context).primaryColor)),
            )
          ],
        ),
      ),
    );
  }
}
