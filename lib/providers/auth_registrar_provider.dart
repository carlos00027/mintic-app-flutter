import 'package:flutter/material.dart';

class AuthRegistrarProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String? correo;
  String? clave;
  String? claveConfirmar;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValid() => this.formKey.currentState?.validate() ?? false;

  bool claveIsValid() {
    if(this.clave!.isEmpty) return false;
    else if (this.clave == this.claveConfirmar) return true;
    return false;
  }
}
