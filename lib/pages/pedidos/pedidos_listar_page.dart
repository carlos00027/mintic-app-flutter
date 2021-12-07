import 'package:flutter/material.dart';
import 'package:mintic_app/providers/pedido_estado_provider.dart';
import 'package:mintic_app/services/Notifications_service.dart';
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
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          key == 0 || key == snapshot.data!.length ? Container() : Divider(),
                          ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.shopping_basket_outlined),
                            ),
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
                              Navigator.of(context).pushNamed('pedidos.ver', arguments: {'id': snapshot.data![key]['_id']});
                            },
                            onLongPress: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return ChangeNotifierProvider(
                                      create: (BuildContext context) => PedidoEstadoProvider(),
                                      child: _FormEstado(id: snapshot.data![key]['_id'],),
                                    );
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

class _FormEstado extends StatelessWidget {
  final String id;
  const _FormEstado({
    Key? key, required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formProvider = Provider.of<PedidoEstadoProvider>(context);
    final _pedidosService = Provider.of<PedidosService>(context);
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 10,
        left: 8,
        right: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Cambiar estado del pedido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DropdownButtonFormField(
            decoration: InputDecoration(label: Text('Estado')),
            isExpanded: true,
            value: _formProvider.estado,
            items: <DropdownMenuItem<String>>[
              DropdownMenuItem(
                child: Text('Pago recibido '),
                value: 'Pago recibido',
              ),
              DropdownMenuItem(
                child: Text('En fabricacion'),
                value: 'En fabricacion',
              ),
              DropdownMenuItem(
                child: Text('En empaque'),
                value: 'En empaque',
              ),
              DropdownMenuItem(
                child: Text('En transportadora'),
                value: 'En transportadora',
              ),
              DropdownMenuItem(
                child: Text('recibido por el cliente'),
                value: 'recibido por el cliente',
              )
            ],
            onChanged: (String? value) {
              _formProvider.estado = value;
            },
          ),
          TextFormField(
            onChanged: (String value)=>_formProvider.justificacion = value,
            maxLines: 3,
            decoration: InputDecoration(label: Text('Justificacion')),
          ),
          MaterialButton(
            color: Theme.of(context).primaryColor,
            minWidth: double.infinity,
            onPressed: () async {
              final Map<String,dynamic> payload = {
                'estado': _formProvider.estado,
                'justificacion': _formProvider.justificacion
              };
              final result = await _pedidosService.estadoActualizar(payload, id);
              if(result == null) {
                NotificationsService.showSnackBar('Pedido Actualizado');
                Navigator.of(context).pop();
                return;
              }
              NotificationsService.showSnackBar(result);
            },
            child: Text(
              'Guardar',
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            minWidth: double.infinity,
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cerrar'),
          )
        ],
      ),
    );
  }
}
