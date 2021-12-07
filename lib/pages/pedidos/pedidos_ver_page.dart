import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mintic_app/services/pedidos_service.dart';
import 'package:provider/provider.dart';

class PedidosVerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pedidosService = Provider.of<PedidosService>(context);
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String id = args['id'];
    final _formatter = DateFormat('dd MM yyyy HH:mm');
    final _formatNumber = NumberFormat.currency(locale: 'es', symbol: '');
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi pedido'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: _pedidosService.ver(id),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData) {
                  final Map<String, dynamic> _row = snapshot.data ?? {
                    'productos': [],
                    'estados': []
                  };
                  final List<dynamic> _productos = _row['productos'];
                  print(_productos);
                  double _total = 0;
                  for (dynamic _item in _productos) {
                    _total = _total + (_item['precio'] * _item['cantidad']);
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeInImage(
                            width: 200,
                            height: 200,
                            placeholder: AssetImage('assets/images/loading.gif'),
                            image: NetworkImage('https://secret-scrubland-71522.herokuapp.com/api/pedidos/qr/generar/${_row['_id']}'),
                          )
                        ],
                      ),
                      Text('Pedido Numero:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('${_row['_id']}'),
                      SizedBox(height: 15),
                      Text('Fecha:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(_formatter.format(DateTime.parse(_row['createdAt']))),
                      SizedBox(height: 15),
                      Text('Productos:', style: TextStyle(fontWeight: FontWeight.bold)),
                      ..._productos.map((element) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                element['producto'].toString().toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(_formatNumber.format(element['precio'])),
                              trailing: Text('${_formatNumber.format(element['cantidad'] * element['precio'])}'),
                              leading: CircleAvatar(
                                child: Text(
                                  element['cantidad'].toString(),
                                  style: TextStyle(fontSize: 32),
                                ),
                              ),
                              dense: true,
                            ),
                            Divider()
                          ],
                        );
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Text(
                            _formatNumber.format(_total),
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
