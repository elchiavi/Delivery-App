import 'package:food_delivery/models/producto_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductosProvider {

  final String _url = 'https://food-delivery-7ca58-default-rtdb.firebaseio.com/productos';

  Future<List<ProductoModel>> getHamburguesas() async {

    final url = '$_url/hamburguesas.json';
    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> hamburguesas = [];
    if (decodedData == null) return [];

    decodedData.forEach((id, hamb) {

      final hambTemp = ProductoModel.fromJson(hamb);
      hambTemp.id = id;
      hamburguesas.add(hambTemp);

    });

    return hamburguesas;

  }

  Future<List<ProductoModel>> getPastas() async {

    final url = '$_url/pastas.json';
    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> pastas = [];
    if (decodedData == null) return [];

    decodedData.forEach((id, past) {

      final pastaTemp = ProductoModel.fromJson(past);
      pastaTemp.id = id;
      pastas.add(pastaTemp);

    });

    return pastas;

  }

    Future<List<ProductoModel>> getPizzas() async {

    final url = '$_url/pizzas.json';
    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> pizzas = [];
    if (decodedData == null) return [];

    decodedData.forEach((id, pizz) {

      final pizzaTemp = ProductoModel.fromJson(pizz);
      pizzaTemp.id = id;
      pizzas.add(pizzaTemp);

    });

    return pizzas;

  }

    Future<List<ProductoModel>> getMilanesas() async {

    final url = '$_url/milanesas.json';
    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> milanesas = [];
    if (decodedData == null) return [];

    decodedData.forEach((id, mila) {

      final milaTemp = ProductoModel.fromJson(mila);
      milaTemp.id = id;
      milanesas.add(milaTemp);

    });

    return milanesas;

  }

  Future<List<ProductoModel>> getPostres() async {

    final url = '$_url/postres.json';
    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> postres = [];
    if (decodedData == null) return [];

    decodedData.forEach((id, postre) {

      final postreTemp = ProductoModel.fromJson(postre);
      postreTemp.id = id;
      postres.add(postreTemp);

    });

    return postres;

  }



}