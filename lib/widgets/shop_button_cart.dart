import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_delivery/utils/utils.dart';
import 'package:food_delivery/constants.dart';

import 'package:food_delivery/models/cart_producto_model.dart';
import 'package:food_delivery/models/producto_model.dart';

import 'package:food_delivery/providers/cart_counter_provider.dart';
import 'package:food_delivery/providers/notification_provider.dart';

class ShopButtonCart extends StatelessWidget {

  final ProductoModel producto;

  const ShopButtonCart(this.producto) ; 
  
  @override
  Widget build(BuildContext context) {
    bool guardando = Provider.of<NotificationModel>(context).guardando;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),        
      ),
      child: Container(
        height: 70,
        width: double.infinity,
        child: Row(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  children: <Widget> [
                  Icon(Icons.shopping_cart, color: Colors.white ),
                  SizedBox(width: 10),
                  Text('Agregar al carrito', style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))
                  ]
        ),
      ),
      onPressed: (guardando) ? null : () => _agregarProducto(context, producto)
    );
  }

  _agregarProducto(BuildContext context, ProductoModel producto) {

    Provider.of<NotificationModel>(context, listen: false).guardando = true;

    List<CartProductoModel> lista = Provider.of<CartCounterProvider>(context, listen: false).listaProductos;
    int cant = Provider.of<CartCounterProvider>(context, listen: false).cantidad;
    int numero = Provider.of<NotificationModel>(context, listen: false ).numero;
    numero = numero + cant;
    if ((lista.where((e) => e.producto.nombre == producto.nombre)).toList().isEmpty) {                
      CartProductoModel nuevoProd = new CartProductoModel();
      nuevoProd.producto = producto;
      nuevoProd.cantidad = cant;
      nuevoProd.total = producto.precio*cant.toDouble();
      Provider.of<CartCounterProvider>(context, listen: false).agregarProducto( nuevoProd);
    } else {
      int index = lista.indexWhere((e) => e.producto.nombre == producto.nombre);
      int cantPropia = Provider.of<CartCounterProvider>(context, listen: false).listaProductos[index].cantidad;
      double totalPropio = Provider.of<CartCounterProvider>(context, listen: false).listaProductos[index].total;
      Provider.of<CartCounterProvider>(context, listen: false).listaProductos[index].cantidad = cant + cantPropia;
      Provider.of<CartCounterProvider>(context, listen: false).listaProductos[index].total = totalPropio + cant*producto.precio;
    }
    Provider.of<NotificationModel>(context, listen: false ).numero = numero;

    if (numero >= 2) {
          final controller = Provider.of<NotificationModel>(context, listen: false).bounceControler;
          controller.forward(from: 0.0);
          
    }
    mostrarSnackbar(context, 'Producto/s agregado/s');
    Timer(
      Duration(milliseconds: 1200),
        () {
          Navigator.pop(context);
          Provider.of<CartCounterProvider>(context, listen: false ).cantidad = 1;
          Provider.of<NotificationModel>(context, listen: false).guardando = false;
        }
    );
  }
}
            