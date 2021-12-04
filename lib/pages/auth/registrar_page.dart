import 'package:flutter/material.dart';
import 'package:mintic_app/providers/auth_registrar_provider.dart';
import 'package:mintic_app/services/auth_service.dart';
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
    final _formProvider = Provider.of<AuthRegistrarProvider>(context);
    final _authService = Provider.of<AuthService>(context);
    return Container(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (value){
                final emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                if(value!.isEmpty) return 'Requerido';
                else if(!emailRegExp.hasMatch(value)) return 'Formato de correo no valido';
                return null;
              },
              onChanged: (value) => _formProvider.correo = value,
              decoration: InputDecoration(label: Text('Correo electronico')),
            ),
            SizedBox(height: 15),
            TextFormField(
              validator: (value){
                if(value!.isEmpty) return 'Requerido';
                else if(value.length < 6 ) return 'Minimo 6 caracteres';
                return null;
              },
              textInputAction: TextInputAction.next,
              onChanged: (value) => _formProvider.clave = value,
              decoration: InputDecoration(label: Text('Clave')),
              obscureText: true,
            ),
            SizedBox(height: 15),
            TextFormField(
              validator: (value){
                if(value!.isEmpty) return 'Requerido';
                else if(value.length < 6 ) return 'Minimo 6 caracteres';
                else if(!_formProvider.claveIsValid()) return 'Clave no coincide';
                return null;
              },
              textInputAction: TextInputAction.next,
              onChanged: (value) => _formProvider.claveConfirmar = value,
              decoration: InputDecoration(label: Text('Confirmar clave')),
              obscureText: true,
            ),
            SizedBox(height: 15),
            MaterialButton(
              minWidth: double.infinity,
              color: Theme.of(context).primaryColor,
              onPressed: _formProvider.isLoading ? null : () async {
                FocusScope.of(context).unfocus();
                _formProvider.isLoading = true;
                if(!_formProvider.isValid()) return;

                if(!_formProvider.claveIsValid()) {
                  print('clave no coincide');
                  _formProvider.isLoading = false;
                  return;
                }
                final Map<String,dynamic> payload = {
                  'correo': _formProvider.correo,
                  'clave': _formProvider.clave
                };
                final result = await _authService.registrar(payload);
                if(result != null) {
                  print(result);
                  _formProvider.isLoading = false;
                  return;
                }
                Navigator.of(context).pushNamed('home');
                _formProvider.isLoading = false;
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
