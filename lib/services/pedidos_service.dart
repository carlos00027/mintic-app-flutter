import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mintic_app/constants.dart';
import 'package:mintic_app/services/auth_service.dart';

class PedidosService extends ChangeNotifier{
  final _authService = AuthService();

  List pedidos = [];

  Future<Map<String,String>> _getHeaders () async{
    final _token = await _authService.readToken();
    final _headers = {
      'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json'
    };
    return _headers;
  }

  Future<List> listar({bool refresh = false }) async{
    final url = Uri.https(BaseUrl, '/api/pedidos');
    print('consumiendo1 $url');
    final _headers = await this._getHeaders();
    final http.Response response = await http.get(url,headers: _headers);
    final List parseData = json.decode(response.body);

    this.pedidos.clear();
    parseData.forEach((element) {
      this.pedidos.add(element);
    });
    if(refresh){
      notifyListeners();
    }
    return this.pedidos;
  }

  Future<Map<String,dynamic>> ver(String id) async {
    final url = Uri.https(BaseUrl, '/api/pedidos/$id');
    print('consumiendo $url');
    final _headers = await this._getHeaders();
    final http.Response response = await http.get(url,headers: _headers);
    final Map<String,dynamic> parseData = json.decode(response.body);
    return parseData;
  }

  Future<String?> estadoActualizar(Map<String,dynamic> payload, String id) async {
    final url = Uri.https(BaseUrl, '/api/pedidos/$id');
    print('consumiendo $url');
    final _headers = await this._getHeaders();
    final _body = json.encode(payload);
    print(_body);
    final http.Response response = await http.put(url,headers: _headers,body: _body);
    if(response.statusCode == 200) return null;
    final parseData = json.decode(response.body);
    return parseData['message'];
  }
}