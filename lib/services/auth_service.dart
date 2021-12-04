import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mintic_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  final storage = new FlutterSecureStorage();

  Future<Map<String, String>> getHeaders() async {
    final _token = await this.readToken();
    final Map<String, String> _headers = {
      'token': _token,
      'Conten-Type': 'application/json'
    };
    return _headers;
  }

  Future<String> readToken () async {
    return await storage.read(key: 'token') ?? '';
  }
  Future<void> writeToken(String token) async {
    // final options = IOSOptions(accessibility: IOSAccessibility.first_unlock);
    await storage.write(key: 'token', value: token);
  }

  Future<String?> login(Map<String,dynamic> payload) async {
    final _headers = {'Content-Type': 'application/json'};
    final url = Uri.https(BaseUrl, '/api/auth/login');
    print('consumiendo $url');
    final _body = json.encode(payload);
    print(_body);
    final response = await http.post(url, headers: _headers,body: _body);
    final parseData = json.decode(response.body);
    if (response.statusCode == 200) {
      await this.writeToken(parseData['token']);
      return null;
    }
    return parseData['message'];
  }

  Future<String?> registrar(Map<String, dynamic> payload) async {
    final _headers = {'Content-Type': 'application/json'};
    final url = Uri.https(BaseUrl, '/api/usuarios');
    print('consumiendo $url');
    final _body = json.encode(payload);
    final response = await http.post(url, headers: _headers, body: _body);
    if (response.statusCode == 201) return null;
    final parseData = json.decode(response.body);
    return parseData['message'];
  }
}
