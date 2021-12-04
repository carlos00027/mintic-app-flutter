import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mintic_app/constants.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier{
  Future<Map<String,String>> getHeaders() async{
    final Map<String,String> _headers = {
      'token': '',
      'Conten-Type': 'application/json'
    };
    return _headers;
  }

  Future<String?> login() async{
    final _headers = await getHeaders();
    final url = Uri.https(BaseUrl, '/api/ss');
    final response = await http.get(url,headers: _headers);
    final parseData = json.decode(response.body);
    if(response.statusCode == 200) return null;
    return parseData['message'];
  }

}