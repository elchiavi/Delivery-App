import 'package:flutter/material.dart';
import 'package:food_delivery/models/pedido_model.dart';
import 'package:food_delivery/widgets/orderCard.dart';

class ListCardOrders extends StatelessWidget {

  final List<PedidoModel> pedidos;

  const ListCardOrders({ @required this.pedidos});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: pedidos.length,
        itemBuilder: (context, i) {
            return OrderCard(pedido: pedidos[i]);          
        },
      ),
    );
  }
}