import 'package:flutter/material.dart';
import 'package:food_delivery/models/cart_producto_model.dart';

class CartCounterProvider extends ChangeNotifier {

  int _cantidad = 1;
  double _totalProd = 0;
  List<CartProductoModel> _listaProductos = [];
  bool _delivery = false;
  String _estadoPedido = "Ingresado";

  int get cantidad => this._cantidad;
  double get totalProd => this._totalProd;
  bool get delivery => this._delivery;
  String get estadoPedido => this._estadoPedido;

  set cantidad (int valor)  {
    this._cantidad = valor;
    notifyListeners();
  }

  set totalProd (double valor) {
    this._totalProd = valor;
    notifyListeners();
  }

  set delivery (bool valor) {
    this._delivery = valor;
    notifyListeners();
  }

  set estadoPedido (String valor) {
    this._estadoPedido = valor;
    notifyListeners();
  }

  List<CartProductoModel> get listaProductos => this._listaProductos;

  set listaProductos (List<CartProductoModel> productos) {
    this._listaProductos = productos;
    notifyListeners();
  }

  void agregarProducto(CartProductoModel producto) {
    this._listaProductos.add(producto);
  }

  void eliminarProducto(CartProductoModel producto) {
    this._listaProductos.remove(producto);
  }
 
}