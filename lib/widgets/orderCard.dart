import 'package:flutter/material.dart';
import 'package:food_delivery/models/pedido_model.dart';

import '../constants.dart';

class OrderCard extends StatelessWidget {

  final PedidoModel pedido;

  const OrderCard({ @required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: (pedido.delivery) 
                          ? Icon(Icons.delivery_dining, color: primaryColor)
                          : Icon(Icons.home, color: primaryColor),
                title: Text('${pedido.diaEntrega} - ${pedido.horaEntrega}'),
                subtitle: Text('Estado: ${pedido.estado}'),
                trailing: Text('\$${pedido.total.toInt()}'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Detalles', style: TextStyle(color: primaryColor)),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
    );
  }

}