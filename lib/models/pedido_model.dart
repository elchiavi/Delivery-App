import 'dart:convert';

import 'package:food_delivery/models/cart_producto_model.dart';

PedidoModel pedidoModelFromJson(String str) => PedidoModel.fromJson(json.decode(str));

String pedidoModelToJson(PedidoModel data) => json.encode(data.toJson());

class PedidoModel {
    PedidoModel({
      this.id,
      this.total,
      this.delivery,
      this.estado,
      this.direccion,
      this.diaEntrega,
      this.horaEntrega,
      this.celular,
      this.aclaraciones,
      this.productos

    });

    String id;
    int cantidad;
    double total;
    bool delivery;
    String estado;
    String direccion = 'Pelegrini 1644'; // direccion por defecto si no es a domicilio
    String diaEntrega;
    String horaEntrega = '';
    String celular;
    String aclaraciones;
    List<CartProductoModel> productos;

    factory PedidoModel.fromJson(Map<String, dynamic> json) => PedidoModel(
        id: json["id"],
        total: json["total"],
        delivery: json["delivery"],
        estado: json["estado"],
        direccion: json["direccion"],
        diaEntrega: json["diaEntrega"],
        horaEntrega: json["horaEntrega"],
        celular: json["celular"],
        aclaraciones: json["aclaraciones"],
        productos: json["productos"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
        "delivery": delivery,
        "estado": estado,
        "direccion": direccion,
        "diaEntrega": diaEntrega,
        "horaEntrega": horaEntrega,
        "celular": celular,
        "aclaraciones": aclaraciones,
        "productos": productos,
    };


}
