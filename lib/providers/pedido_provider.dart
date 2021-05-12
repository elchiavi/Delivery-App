import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:food_delivery/models/pedido_model.dart';

class PedidosProvider {

  final String _url = 'https://food-delivery-7ca58-default-rtdb.firebaseio.com/pedidos';

  Future<bool> crearPedido(PedidoModel pedido) async {

    final url = '$_url.json';
    final resp = await http.post(Uri.parse(url), body: pedidoModelToJson(pedido));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }


}