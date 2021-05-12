import 'dart:convert';

import 'package:food_delivery/models/producto_model.dart';

CartProductoModel productoModelFromJson(String str) => CartProductoModel.fromJson(json.decode(str));

String productoModelToJson(CartProductoModel data) => json.encode(data.toJson());

class CartProductoModel{
  CartProductoModel({
    this.cantidad,
    this.producto,
    this.total,
  });

  int cantidad;
  ProductoModel producto;
  double total;

  factory CartProductoModel.fromJson(Map<String, dynamic> json) => CartProductoModel(
        cantidad: json["cantidad"],
        producto: json["producto"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "cantidad": cantidad,
        "producto": producto,
        "total": total,
    };

}