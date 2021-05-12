
import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    ProductoModel({
        this.id,
        this.descripcion,
        this.imagen,
        this.nombre,
        this.precio,
        this.tipo,
    });

    String id;
    String descripcion;
    String imagen;
    String nombre;
    int precio;
    String tipo;

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id: json["id"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        precio: json["precio"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "imagen": imagen,
        "nombre": nombre,
        "precio": precio,
        "tipo": tipo,
    };
}