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
        title: Text('Listado de pedidos'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.menu),
            onSelected: (item){
              print(item);
              if(item == 0){
                Navigator.of(context).pushNamed('pedidos.form');
              }else if(item == 1){
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
                            subtitle: Text(_formatter.format(DateTime.parse(snapshot.data![key]['fecha']))),
                            trailing: Icon(Icons.navigate_next_outlined),
                            onTap: () {},
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
