import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mintic_app/providers/auth_login_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          //color: Colors.red[200],
          width: double.infinity,
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
        key: _formProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Inicio de sesion',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 15),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              onChanged: (value) => _formProvider.correo = value,
              validator: (value) {
                if (value!.isEmpty) return 'Requerido';
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                labelText: 'Correo electronico',
                hintText: 'Ej. correo@electronico.com',
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_formProvider.passwordIsVisible,
              autocorrect: false,
              textInputAction: TextInputAction.search,
              onChanged: (value) => _formProvider.clave = value,
              validator: (value) {
                if (value!.isEmpty)
                  return 'Requerido';
                else if (value.length < 6) return 'Minimo 6 caracteres';
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                labelText: 'Clave',
                hintText: '******',
                suffixIcon: IconButton(
                  icon: Icon(_formProvider.passwordIsVisible ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    _formProvider.passwordIsVisible = !_formProvider.passwordIsVisible;
                  },
                ),
              ),
            ),
            SizedBox(height: 15),
            MaterialButton(
              minWidth: double.infinity,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                print(_formProvider.correo);
                print(_formProvider.clave);
                print(_formProvider.isValid());
              },
              child: Text(
                'Ingresar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('auth.registrar');
              },
              child: Text(
                'Registrarme',
              ),
            )
          ],
        ),
      ),
    );
  }
}
