import 'package:flutter/material.dart';

class AuthLoginProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? correo;
  String? clave;
  bool _isLoading = false;
  bool _passwordIsVisible = false;

  bool get passwordIsVisible => _passwordIsVisible;

  set passwordIsVisible(bool value) {
    _passwordIsVisible = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  bool isValid() => this.formKey.currentState?.validate() ?? false;
}
