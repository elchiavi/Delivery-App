import 'package:flutter/material.dart';
import 'package:food_delivery/models/pedido_model.dart';
import 'package:food_delivery/providers/pedido_provider.dart';
import 'package:food_delivery/utils/utils.dart';
import 'package:food_delivery/widgets/custom_all_widgets.dart';

class MyOrdersPage extends StatelessWidget {

  final pedidosProvider = new PedidosProvider();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: customAppBar(context),
      drawer: Menu(),
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          children: <Widget> [
              Text('Mis Pedidos', style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold)
              ),
              SizedBox(height:20),
              Container(
                child: FutureBuilder(
                  future: pedidosProvider.getPedidos(prefs.email),
                  builder: (BuildContext context, AsyncSnapshot<List<PedidoModel>> snapshot) {
                    if (snapshot.hasData) {
                      return ListCardOrders(pedidos: snapshot.data);
                    } else {
                      return Container(
                        height: 200.0,
                        child: Center(
                          child: CustomCircularProgressIndicator(),
                        ),
                      );
                    }
                  }
                ) ,
              )

          ],
        ),
      )
    );
  }
}