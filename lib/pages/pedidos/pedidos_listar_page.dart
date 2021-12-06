import 'package:flutter/material.dart';
import 'package:mintic_app/services/pedidos_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PedidosListarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pedidosService = Provider.of<PedidosService>(context);
    final _media = MediaQuery.of(context).size;
    final _formatter = DateFormat('dd MMM yyyy HH:mm');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Listado de pedidos (${_pedidosService.pedidos.length})',
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.menu),
            onSelected: (item) {
              print(item);
              if (item == 0) {
                Navigator.of(context).pushNamed('pedidos.form');
              } else if (item == 1) {
                _pedidosService.listar(refresh: true);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: Text('Crear pedido'),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text('Recargar listado'),
                ),
              ];
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          width: _media.width,
          child: FutureBuilder(
            initialData: _pedidosService.pedidos,
            future: _pedidosService.listar(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int key) {
                      return Column(
                        children: [
                          key == 0 || key == snapshot.data!.length ? Container() : Divider(),
                          ListTile(
                            title: Text('${snapshot.data![key]['clienteId']['nombres']} ${snapshot.data![key]['clienteId']['apellidos']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Cant. Productos: ${snapshot.data![key]['productos'].length}', style: TextStyle(fontSize: 12)),
                                Text('Fecha: ' + _formatter.format(DateTime.parse(snapshot.data![key]['fecha'])), style: TextStyle(fontSize: 12)),
                                Text('Estado: ' + snapshot.data![key]['estados'][snapshot.data![key]['estados'].length - 1]['estado'],
                                    style: TextStyle(fontSize: 12))
                              ],
                            ),
                            trailing: Icon(Icons.navigate_next_outlined),
                            onTap: () {
                              Navigator.of(context).pushNamed('pedidos.ver',arguments: {
                                'id': snapshot.data![key]['_id']
                              });
                            },
                          ),
                        ],
                      );
                    });
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
