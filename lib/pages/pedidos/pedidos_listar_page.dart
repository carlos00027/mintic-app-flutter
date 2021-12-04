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
      ),
      body: SafeArea(
        child: Container(
          width: _media.width,
          child: Container(
            height: _media.height,
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
                            key == 0 ? Container() : Divider(),
                            ListTile(
                              title: Text('${snapshot.data![key]['clienteId']['nombres']} ${snapshot.data![key]['clienteId']['apellidos']}'),
                              subtitle: Text( _formatter.format( DateTime.parse(snapshot.data![key]['fecha']) ) ),
                              trailing: Icon(Icons.navigate_next_outlined),
                              onTap: (){

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
      ),
    );
  }
}
