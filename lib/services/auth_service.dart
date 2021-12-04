import 'package:flutter/material.dart';
import 'package:mintic_app/constants.dart';

class AuthService extends ChangeNotifier{
  Future<Map<String,String>> getHeaders() async{
    final Map<String,String> _headers = {
      'token': '',
      'Conten-Type': 'application/json'
    };
    return _headers;
  }

  Future login() async{
    final _headers = await getHeaders();
    final url = Uri.https(BaseUrl, '/api/ss');
    //    final response = http.
  }
}